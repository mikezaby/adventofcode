import java.io.File

enum class Direction {
    UP,
    DOWN,
    LEFT,
    RIGHT,
    UP_LEFT,
    UP_RIGHT,
    DOWN_LEFT,
    DOWN_RIGHT,
}

fun getOffset(direction: Direction): Pair<Int, Int> {
    return when (direction) {
        Direction.UP -> 0 to 1
        Direction.DOWN -> 0 to -1
        Direction.LEFT -> -1 to 0
        Direction.RIGHT -> 1 to 0
        Direction.UP_LEFT -> -1 to 1
        Direction.UP_RIGHT -> 1 to 1
        Direction.DOWN_LEFT -> -1 to -1
        Direction.DOWN_RIGHT -> 1 to -1
    }
}

val xmasChars = "XMAS".toCharArray()

fun List<List<Char>>.xmasCount(): Int {
    var counter = 0

    this.forEachIndexed { x, row ->
        row.forEachIndexed { y, char ->
            if (char != xmasChars[0]) return@forEachIndexed

            counter += this.xmasCountMultiDirectional(x,y)
        }
    }

    return counter
}

fun List<List<Char>>.xmasCountMultiDirectional(x: Int, y: Int) =
    Direction.values().sumOf { direction -> this.xmasCountDirectional(x,y,direction) }

fun List<List<Char>>.xmasCountDirectional(x: Int, y: Int, direction: Direction, charIndex: Int = 1): Int {
    if (charIndex == 4) return 1

    val (x1, y1) = getOffset(direction)
    val newX = x + x1
    val newY = y + y1
    if (newX < 0 || newY < 0 || newX >= this.size || newY >= this[0].size) return 0

    return if (this[newX][newY] === xmasChars[charIndex]) this.xmasCountDirectional(newX, newY,direction, charIndex + 1) else 0
}

File("data.txt").readLines().map { it.toCharArray().toList() }.xmasCount()