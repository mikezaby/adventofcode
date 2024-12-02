import java.io.File
import kotlin.math.abs

fun isSafe(level: List<Int>) = level.windowed(size = 3) {
    val (prev, current, next) = it
    val prevDiff = current - prev
    val nextDiff = next - current

    if (prevDiff * nextDiff <= 0) false
    else if (abs(prevDiff).let { it < 1 || it > 3 }) false
    else if (abs(nextDiff).let { it < 1 || it > 3 }) false
    else true
}.all { it }

File("data.txt").readLines().map {
    isSafe(level = it.split(" ").map(String::toInt))
}.count { it }