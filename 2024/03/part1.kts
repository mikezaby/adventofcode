import java.io.File

val REGEX = "mul\\((\\d+),(\\d+)\\)".toRegex()

fun parse(): List<Pair<Int, Int>> {
    return REGEX.findAll(File("data.txt").readText()).map { match ->
        match.groups.let { it[1]!!.value.toInt() to it[2]!!.value.toInt() }
    }.toList()
}

parse().map { (a, b) -> a * b }.sum()