import java.io.File

class DiskManager(fileName: String) {
    val emptyChar = "."

    val data = mutableListOf<String>()
    val rearranged = mutableListOf<String>()

    val disk = File(fileName).readText().mapIndexed { index, c ->
        val num = c.toString().toInt()
        val block = mutableListOf<String>()

        if (index % 2 == 0) {
            val char = "${(index / 2)}"
            repeat(num) {
                data.add(char)
                block.add(char)
            }
        } else {
            repeat(num) { block.add(emptyChar) }
        }

        block
    }.flatMap { it }

    init {
        val cloneData = data.toMutableList()

        disk.forEachIndexed { index, char ->
            if (data.size == rearranged.size) {
                return@forEachIndexed
            }

            if (char == emptyChar) {
                rearranged.add(cloneData.removeLast())
            } else {
                rearranged.add(char)
            }

        }
    }

    fun checksum() =
        rearranged.mapIndexed { index, c -> index * c.toLong() }.sum()
}

val diskManager = DiskManager("data.txt")

diskManager.checksum()
