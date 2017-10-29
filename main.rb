a = 
'210010'\
'101010'\
'010100'\
'001011'\
'110100'\
'000100'\

source = 0
destination = 5

class Graph
    attr_accessor :nodes

    @nodes

    def initialize(matrix)
        n = matrix.length
        @nodes = []
        n.times { @nodes << Node.new }
        n.times do |y|
            n.times do |x|
                if matrix[y][x] > 0
                    @nodes[y].neighbors << @nodes[x]
                end
            end
        end
    end

    def find_shortest_path(source, destination)
        unvisited = @nodes.dup
        distance = Hash.new Float::INFINITY
        previous = Hash.new

        distance[source] = 0

        while !unvisited.empty?
            current = unvisited.min { |a, b| distance[a] <=> distance[b] }

            if distance[current] == Float::INFINITY
                return { found: false }
            end

            unvisited.delete current

            current.neighbors.each do |neighbor|
                alt = distance[current] + 1
                if alt < distance[neighbor]
                    distance[neighbor] = alt
                    previous[neighbor] = current
                end
            end

            unless unvisited.include? destination
                path = []
                current = destination
                while current
                    path.unshift current
                    current = previous[current]
                end
                return { found: true, path: path.map! { |a| @nodes.find_index(a) } } 
            end
        end
    end
end

class Node
    attr_accessor :neighbors

    @neighbors

    def initialize
        @neighbors = []
    end
end

na = []
n = (a.length ** 0.5).to_i

n.times do |i|
    na << a[i * n, n].chars.map { |s| s.to_i }
    p na[-1]
end

g = Graph.new na
result = g.find_shortest_path g.nodes[source], g.nodes[destination]

if result[:found]
    puts "The shortest path from #{source} to #{destination} has been found: #{result[:path].map { |i| i + 1 }}"
else
    puts "No path from #{source} to #{destination} has been found"
end