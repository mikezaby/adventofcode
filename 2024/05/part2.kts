import java.io.File

class Node(val value: Int): Comparable<Node> {
    var connections: MutableSet<Node> = mutableSetOf()

    fun addNode(node: Node) {
        connections.add(node)
    }

    override fun compareTo(other: Node): Int {
        return if (connections.contains(other)) -1
        else if (other.connections.contains(this)) 1
        else 0
    }
}

val nodes = mutableMapOf<Int, Node>()

val (nodesText, printQueText) = File("data.txt").readText().split(Regex("\\r?\\n\\r?\\n"))

nodesText.split("\n").forEach {
    val (num1, num2) = it.split("|").map(String::toInt)
    val node1 = nodes.getOrPut(num1) { Node(num1) }
    val node2 = nodes.getOrPut(num2) { Node(num2) }

    node1.addNode(node2)
}
val printerQue = printQueText.split("\n").map { it.split(",").map(String::toInt) }
printerQue.mapNotNull { line ->
    val lineNodes = line.mapNotNull { nodes.get(it) }

    if (lineNodes.size != line.size)
        null
    else
       if (lineNodes.sorted() != lineNodes) lineNodes else null
}.sumOf { it.sorted()[it.size / 2].value }
