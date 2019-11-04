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
function hammingdistance(s1, s2)
    sum = length(s1)
    for i = 1:length(s1)
        sum -= Int(s1[i]==s2[i])
    end
    return sum
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
    C = [] # contains placement of elements
    # Implement kruskal, abort when k elements left.

    # for each vertex v in G.v
    nodes = Array{DisjointSetNode}(undef, 0)
    for i in 1:n
        node = DisjointSetNode()
        makeset(node)
        push!(nodes, node)
    # lag en array A som er initialisert : [[node1], [node2], ...[noden]]
        push!(A, [i])
        push!(C, i)
    end

    # hver gang node_x og node_y ikke er i samme set legger vi node_y i nodex-array og fjerner node_y fra A


    for edge in E
        if temp==k
            B = []
            for i in 1:length(A)
                if length(A[i]) != 0
                    push!(B, A[i])
                end
            end
            return B
        end
        if findset(nodes[edge[2]]) != findset(nodes[edge[3]])
            println("This is A,", A)
            position_of_2 = C[edge[2]]
            position_of_3 = C[edge[3]]
            for i in 1:length(A[position_of_3])
                # fetch element i at three position
                element = A[position_of_3][1]

                # push element at position of 3 to position of 2
                push!(A[position_of_2], element)

                # delete element at position of 3 as it is added to the position of 2.
                deleteat!(A[position_of_3], 1)

               # update position
                C[element] = position_of_2
            end

            union!(findset(nodes[edge[2]]), findset(nodes[edge[3]]))
            temp-=1
        end
        # finish when k sets left
    end
            B = []
            for i in 1:length(A)
                if length(A[i]) != 0
                    push!(B, A[i])
                end
            end
            return B
end
function findanimalgroups(animals, k)

    edges = []
    for i in 1:length(animals)-1
        for j in i+1:length(animals)
            str1 = animals[i][2]
            str2 = animals[j][2]
            weight = hammingdistance(str1, str2)
            push!(edges, (weight,i, j))
        end
    end
    clusters = findclusters(edges, length(animals), k)
    A = [] 
    for cluster in clusters
        temp = []
        for idx in cluster
            push!(temp, animals[idx][1])
        end
        push!(A, temp)
    end
    return A
end

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")], 2)]) == sort([["Ugle"], ["Elg", "Hjort"]])

    @test sort([sort(x) for x in findanimalgroups([("Hval", "CGCACATA"), ("Ulv", "AGAAACCT"), ("Delfin", "GGCACATA"), ("Hund", "GGAGACAA"),
    ("Katt", "TAACGCCA"), ("Leopard", "TAACGCCT")], 3)]) == sort([["Hund", "Ulv"], ["Delfin", "Hval"], ["Katt", "Leopard"]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
