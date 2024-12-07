import java.io.File

fun caclulcatable(values: List<Long>, result: Long): Boolean {
    val a = values[0]
    val b = values[1]

    if (a > result) return false

    val result1 = a + b
    val result2 = a * b
    val result3 = "$a$b".toLong()

    if (values.size == 2) {
        return result1 == result || result2 == result || result3 == result
    }

    val rest = values.drop(2)

    return caclulcatable(listOf(result1) + rest, result) || caclulcatable(listOf(result2) + rest, result) || caclulcatable(listOf(result3) + rest, result)
}

File("data.txt").readLines().map {
    it.split(": ").let { (a, b) -> a.toLong() to b.split(" ").map(String::toLong) }
}.sumOf {
    if (caclulcatable(it.second, it.first)) it.first else 0L
}

