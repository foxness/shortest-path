a = 
'210010'\
'101010'\
'010100'\
'001011'\
'110100'\
'000100'\

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

    def find_shortest_path(a, b)

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

puts Graph.new na