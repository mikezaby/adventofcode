import java.io.File
import kotlin.math.abs

val (column1, column2) = File("data.txt").readLines().map {
  val (a, b) = it.split("   ").map(String::toInt)

  a to b
}.unzip()

column1.sort()
column2.sort()

val result = column1.zip(column2) { a, b -> abs(a - b) }.sum()
println(result)