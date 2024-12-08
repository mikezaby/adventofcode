import java.io.File

fun <T> List<T>.combinations(size: Int): List<List<T>> {
    if (size > this.size) return emptyList()
    if (size == 0) return listOf(emptyList())
    if (size == 1) return this.map { listOf(it) }

    return this.flatMapIndexed { index, element ->
        this.drop(index + 1).combinations(size - 1).map { listOf(element) + it }
    }
}

data class Point(val x: Int, val y: Int): Comparable<Point> {
    override fun toString(): String {
       return "($x, $y)"
    }

    override fun compareTo(other: Point): Int {
        if (x == other.x) {
            if (y > other.y) return 1
            if (y < other.y) return -1
            else return 0
        }

        if (x > other.x) return 1

        return -1
    }

    fun add(plusX: Int, plusY: Int): Point {
        return Point(x + plusX, y + plusY)
    }
}

data class Antenna(val id: Char, val point: Point): Comparable<Antenna> {
    val x = point.x
    val y = point.y


    override fun compareTo(other: Antenna): Int {
        return point.compareTo(other.point)
    }
}

class Map(private val fileName: String) {
    private val map = File(fileName).readLines().map { it.toList() }
    private val ignoreChar = ".".single()

    val rowRange = 0 until map.size
    val colRange = 0 until map[0].size


    val antennas = map.mapIndexedNotNull { x, line ->
        line.mapIndexedNotNull { y, c ->
            if(c == ignoreChar)
                null
            else
                Antenna(c, Point(x, y))
        }
    }.flatten()

    val antinodes = mutableSetOf<Point>()

    init {
        antennas.groupBy { it.id }.values.map { it.combinations(2) }.flatMap { it }.forEach { it ->
            antinodesFor(it)
        }
        antennas.forEach { antinodes.add(it.point) }
    }

    fun antinodesFor(pair: List<Antenna>) {
        val points = mutableListOf<Point>()
        val (a, b) = pair.sorted()

        val xAdjust = b.x - a.x
        val yAdjust = b.y - a.y

        addAntinodes(a.point, -xAdjust, -yAdjust)
        addAntinodes(b.point, xAdjust, yAdjust)
    }

    fun addAntinodes(point: Point, x: Int, y: Int) {
        val newPoint = point.add(x, y)

        if (newPoint.x in rowRange && newPoint.y in colRange) {
            antinodes.add(newPoint)
            addAntinodes(newPoint, x, y)
        }
    }
}

Map("data.txt").antinodes.count()