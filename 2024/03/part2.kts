import java.io.File

val REGEX = "(don't\\(\\)|do\\(\\)|mul\\((\\d+),(\\d+)\\))".toRegex()

fun parse(): List<Pair<Int, Int>> {
    var skip: Boolean = false

    return REGEX.findAll(File("data.txt").readText()).mapNotNull { match ->
        if (match.value == "don't()") {
            skip = true
            return@mapNotNull null
        }
        if (match.value == "do()") {
            skip = false
            return@mapNotNull null
        }

        if (skip) return@mapNotNull null

        match.groups.let { it[2]!!.value.toInt() to it[3]!!.value.toInt() }
    }.toList()
}

parse().map { (a, b) -> a * b }.sum()