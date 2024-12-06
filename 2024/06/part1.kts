import java.io.File
import kotlin.time.Duration

class Map(private val fileName: String) {
    val obstractionChar = "#".single()
    val positionChar = "^".single()
    private val map = File(fileName).readLines().map { it.toList() }
    val initialPosition: Position

    val rowCount = map.size
    val columnCount = map[0].size

    val xObstractions = mutableMapOf<Int, MutableList<Int>>()
    val yObstractions = mutableMapOf<Int, MutableList<Int>>()

    init {
        var position: Position? = null

        map.forEachIndexed { x, row ->
            row.mapIndexed { y, value ->
                if (value == obstractionChar) {
                    xObstractions.getOrPut(x) { mutableListOf<Int>() }.add(y)
                    yObstractions.getOrPut(y) { mutableListOf<Int>() }.add(x)
                } else if (value == positionChar) {
                    position = Position(Point(x, y), Direction.UP)
                } else {}
            }
        }

        initialPosition = position ?: throw Error("Missing position")
    }

    fun findObstruction(position: Position) = when (position.direction) {
        Direction.UP -> yObstractions.get(position.y)!!.filter { it < position.x }.maxOrNull()?.let { Point(it + 1, position.y) }
            ?: Point(0, position.y)

        Direction.DOWN -> yObstractions.get(position.y)!!.filter { it > position.x }.minOrNull()?.let { Point(it - 1, position.y) }
            ?: Point(rowCount - 1, position.y)

        Direction.LEFT -> xObstractions.get(position.x)!!.filter { it < position.y }.maxOrNull()?.let { Point(position.x, it + 1) }
            ?: Point(position.x, 0)

        Direction.RIGHT -> xObstractions.get(position.x)!!.filter { it > position.y }.minOrNull()?.let { Point(position.x, it - 1) }
            ?: Point(position.x, columnCount - 1)
    }

    fun edge(point: Point) = point.x == rowCount - 1 || point.y == columnCount - 1 || point.x == 0 || point.y == 0
}

enum class Direction {
    UP, RIGHT, DOWN, LEFT;

    fun next(): Direction {
        val values = Direction.values()
        val currentIndex = values.indexOf(this)

        return values[(currentIndex + 1) % 4]
    }
}

data class Point(val x: Int, val y: Int) {
    fun route(point: Point): List<Point> {
        if (x == point.x) {
            if (y > point.y) {
                return y.downTo(point.y).map { Point(x, it) }
            } else {
                return (y..(point.y)).map { Point(x, it) }
            }
        } else {
            if (x > point.x) {
                return x.downTo(point.x).map { Point(it, y) }
            } else {
                return (x..(point.x)).map { Point(it, y) }
            }
        }
    }

    override fun toString(): String {
        return "Point(x=$x, y=$y)"
    }
}

data class Position(val point: Point, val direction: Direction) {
    val x = point.x
    val y = point.y
}


class Guard(val map: Map) {
    val route = mutableSetOf<Point>()
    var position = map.initialPosition

    fun move() {
        val point = map.findObstruction(position)
        position.point.route(point).forEach { route.add(it) }

        if (map.edge(point)) {
            return
        }

        position = Position(point, position.direction.next())
        move()
    }
}

val map = Map("data.txt")
val guard = Guard(map)
guard.move()
guard.route.count()
