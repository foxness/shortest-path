a = # матрица смежности
'210010'\
'101010'\
'010100'\
'001011'\
'110100'\
'000100'\

source = 0 # индекс начальной вершины
destination = 5 # индекс конечной вершины

# !! все, что выше - входные данные программы !!

class Graph # класс графа
    attr_accessor :nodes # граф имеет только вершины, которые представлены массивами их соседей

    # метод, создающий объект графа из данной матрицы смежности
    def initialize(matrix)
        n = matrix.length # n - количество вершин
        @nodes = []
        n.times { @nodes << [] } # для начала заполняем граф n несвязанными вершинами
        n.times do |y|
            n.times do |x|
                if matrix[y][x] > 0
                    @nodes[y] << @nodes[x] # связываем вершины, если элемент на пересечении матрицы больше нуля
                end
            end
        end
    end

    # метод, находящий кратчайший путь от А до Б с помощью алгоритма Дейкстры
    def find_shortest_path(source, destination)
        unvisited = @nodes.dup # в начале все вершины - непосещенные
        distance = Hash.new Float::INFINITY # а также расстояния равны бесконечности
        previous = Hash.new # будет показывать предыдущую вершину в оптимальном пути к этой вершине

        distance[source] = 0 # расстояние до начальной вершины - 0

        while !unvisited.empty? # пока есть непосещенные вершины
            current = unvisited.min { |a, b| distance[a] <=> distance[b] } # делаем ближайшую непосещенную вершину текущей

            return { found: false } if distance[current] == Float::INFINITY # если расстояние до текущей вершины - бесконечность, то выходим, т.к. пути не существует

            unvisited.delete current # удаляем из непосещенных вершин текущую

            current.each do |neighbor| # для каждого соседа текущей вершины
                alt = distance[current] + 1 # предварительное расстояние до соседа = расстояние до текущей + 1
                if alt < distance[neighbor] # если новое расстояние меньше старого
                    distance[neighbor] = alt # используем новое расстояние
                    previous[neighbor] = current # предыдущая вершина соседа в оптимальном пути - текущая вершина
                end
            end

            unless unvisited.include? destination # если конечная вершина посещена
                path = [] # ниже строим массив вершин кратчайшего пути
                current = destination # текущая вершина = конечная вершина
                while current # пока существует текущая вершина
                    path.unshift current # добавляем текущую вершину в начало массива пути
                    current = previous[current] # текущая вершина = предыдущая вершина текущей вершины в оптимальном пути
                end

                # конвертируем вершины пути в их индексы, начинающиеся с 1, для удобного восприятия их человеком, и возвращаем их
                return { found: true, path: path.map! { |a| (@nodes.index a) + 1 } }
            end
        end
    end
end

n = (a.length ** 0.5).to_i # вычисляем сторону данной матрицы смежности

# ниже преобразуем данную матрицу смежности из строки в двумерный массив чисел
na = []
n.times do |i|
    na << a[i * n, n].chars.map { |s| s.to_i } # преобразуем одну строку матрицы
    p na.last # затем выводим ее
end

g = Graph.new na # создаем граф из преобразованной матрицы смежности
result = g.find_shortest_path g.nodes[source], g.nodes[destination] # ищем кратчайший путь

# делаем данные индексы начинающимися с 1 для удобного восприятия человеком
source += 1
destination += 1

if result[:found] # если путь найден
    puts "The shortest path from #{source} to #{destination} has been found: #{result[:path]}" # выводим его
else
    puts "No path from #{source} to #{destination} has been found" # если не найден - то пишем, что пути нет
end