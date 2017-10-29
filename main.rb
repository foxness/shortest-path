class Graph
    @nodes
end

class Node
    @neighbors
end

N = 6

a = 
'210010'\
'101010'\
'010100'\
'001011'\
'110100'\
'000100'\

# N.times do |i|
#     puts a[i * N, N]
# end

na = []

N.times do |i|
    na.push a[i * N, N].chars.map { |s| s.to_i }
    p na[-1]
end

