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
            antinodesFor(it).forEach { antinodes.add(it) }
        }
    }

    fun antinodesFor(pair: List<Antenna>): List<Point> {
        val points = mutableListOf<Point>()
        val (a, b) = pair.sorted()

        val xAdjust = b.x - a.x
        val yAdjust = b.y - a.y

        val aX = a.x - xAdjust
        val aY = a.y - yAdjust
        val bX = b.x + xAdjust
        val bY = b.y + yAdjust

        if (aX in rowRange && aY in colRange) {
            points.add(Point(aX, aY))
        }

        if (bX in rowRange && bY in colRange) {
            points.add(Point(bX, bY))
        }

        return points
    }
}

Map("data.txt").antinodes.count()