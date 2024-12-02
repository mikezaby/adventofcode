import java.io.File
import kotlin.math.abs

fun isSafe(level: List<Int>, index: Int = 0, recursive: Boolean = true): Boolean {
    val prev = level[index]
    val current = level[index + 1]
    val next = level[index + 2]

    val prevDiff = current - prev
    val nextDiff = next - current

    if ((prevDiff * nextDiff <= 0) ||
        (abs(prevDiff).let { it < 1 || it > 3 }) ||
        (abs(nextDiff).let { it < 1 || it > 3 })) {
        if (!recursive) return false

        val list1 = level.toMutableList().apply { removeAt(index) }
        val list2 = level.toMutableList().apply { removeAt(index + 1) }
        val list3 = level.toMutableList().apply { removeAt(index + 2) }

        return isSafe(list1, recursive = false) || isSafe(list2,recursive = false) || isSafe(list3, recursive = false)
    }

    return if (index == level.size - 3) true else isSafe(level, index + 1, recursive)
}

File("data.txt").readLines().map {
    isSafe(level = it.split(" ").map(String::toInt))
}.count { it }