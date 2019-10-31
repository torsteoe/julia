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

    sort!(E)
    A = [] 
    # Implement kruskal, abort when k elements left.
   
    # for each vertex v in G.v
    nodes = []
    for i in 1:n
        node = DisjointSetNode()
        makeset(node)
        push!(nodes, node) 
    end
    for edge in E
        if k==0
            return A
        if findset(edge.u) != findset(edge.v)
            push!(A, (edge.u, edge.v))
            union!(findset(edge.u), findset(edge.v))
            k-=1
        end
        # finish when k sets left
    end
    return A
end

