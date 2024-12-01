import java.io.File
import kotlin.math.abs

val (column1, column2) = File("data.txt").readLines().map {
  val (a, b) = it.split("   ").map(String::toInt)

  a to b
}.unzip()

val similarities = mutableMapOf<Int, Int>()
column1.forEach { a -> similarities.getOrPut(a) { a * column2.count { b -> a == b } } }

println(similarities.values.sum())