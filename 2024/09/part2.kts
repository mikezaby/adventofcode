import java.io.File

class DiskManager(fileName: String) {
    val emptyChar = "."

    val data = mutableListOf<List<String>>()
    val rearranged = mutableListOf<List<String>>()

    val disk = File(fileName).readText().mapIndexed { index, c ->
        val num = c.toString().toInt()

        if (index % 2 == 0) {
            val char = "${(index / 2)}"
            (1..num).map { char }.also { data.add(it) }
        } else {
            (1..num).map { emptyChar }
        }
    }

    init {
        val cloneData = data.toMutableList().also { it.reverse() }

        disk.forEachIndexed { index, group ->
            if (group.contains(emptyChar)) {
                var currentFreeSpace = group.size

                while (currentFreeSpace > 0) {
                    cloneData.indexOfFirst { it.size <= currentFreeSpace && index < ((it[0].toInt() * 2) + 1) }?.also { i ->
                        if (i >= 0) {
                            cloneData.removeAt(i).also {
                                rearranged.add(it)
                                currentFreeSpace = currentFreeSpace - it.size
                            }
                        } else {
                            rearranged.add((1..currentFreeSpace).map { emptyChar })
                            currentFreeSpace = 0
                        }
                    }
                }
            } else {
                if (cloneData.contains(group)) {
                    rearranged.add(group)
                } else {
                    rearranged.add(group.map { emptyChar })
                }
            }
        }
    }

    fun checksum() =
        rearranged.flatten().mapIndexed { index, c ->
            if (c == emptyChar) 0 else index * c.toLong()
        }.sum()
}

val diskManager = DiskManager("data.txt")
diskManager.checksum()
