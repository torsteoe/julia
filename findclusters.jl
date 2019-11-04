mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end
function findset(x)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end

function link(x,y)
    if x.rank>y.rank
        y.p = x
    else
        x.p = y
        if x.rank==y.rank
            y.rank = y.rank+1
        end
    end
end
function union!(x,y)
    link(findset(x), findset(y))
end

function makeset(v)
    v.p = v
    v.rank = 0
end

function findclusters(E, n, k)
    #k = number of clusters

    temp = n
    sort!(E)
    A = [] 
    # Implement kruskal, abort when k elements left.
   
    # for each vertex v in G.v
    nodes = Array{DisjointSetNode}(undef, 0)
    for i in 1:n
        node = DisjointSetNode()
        makeset(node)
        push!(nodes, node) 
    end
    # lag en array A som er initialisert : [[node1], [node2], ...[noden]]
    # hver gang node_x og node_y ikke er i samme set legger vi nodey i nodex-array og fjerner node_y fra A
    for edge in E
        if temp==k
            println("A: ", A)
            return A
        end
        if findset(nodes[edge[2]]) != findset(nodes[edge[3]])
            println("i if-setning", A)
            push!(A, [edge[2], edge[3]])
            union!(findset(nodes[edge[2]]), findset(nodes[edge[3]]))
            temp-=1
        end
        # finish when k sets left
    end
    return A
end
printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2),
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2) 

using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2)]) == sort([[1, 2], [3, 4]])
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2), 
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)]) == sort([[1], [2], [3, 4]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
