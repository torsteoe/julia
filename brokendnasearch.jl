try
	mutable struct Node
    	children::Dict{Char,Node}
    	count::Int
	end
catch
	println("Node() allerede definert")
end



function brokendnasearch(root, dna, i=1)
    currentNode = root
    sum = 0
    #get to correct node
    for letterIdx in i:length(dna)
        letter = dna[letterIdx]
        if haskey(currentNode.children, letter)
           currentNode = currentNode.children[letter] 
        elseif letter == '?'
            replace(dna, "?"=>"T",count= 1)
           println("dna: ", dna) 
          sum+=  brokendnasearch(currentNode, dna[letterIdx+1:end], letterIdx+1) 
            replace(dna, "?"=>"A",count=1)
          sum+=  brokendnasearch(currentNode, dna[letterIdx+1:end], letterIdx+1) 
            replace(dna, "?"=>"C",count=1)
          sum+=  brokendnasearch(currentNode, dna[letterIdx+1:end], letterIdx+1) 
            replace(dna, "?"=>"G", count=1)
          sum+=  brokendnasearch(currentNode, dna[letterIdx+1:end], letterIdx+1) 
        return sum
        end
    end
    sum += currentNode.count
    return sum 
end
root1 = Node(Dict('A' => Node(Dict{Char,Node}(), 1)), 0)
root2 = Node(Dict('A' => Node(Dict('G' => Node(Dict('T' => Node(Dict('A' => Node(Dict{Char,Node}(), 1),'T' => Node(Dict{Char,Node}(), 1),'C' => Node(Dict{Char,Node}(), 1)), 4)), 5)), 5)), 0)
root3 = Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict('C' => Node(Dict{Char,Node}(), 1)), 2)), 3)), 4)), 5)), 6)), 0)
s1 = "A"
s2 = "T"
s3 = "?"
s4 = "??"
s5 = "C?C"
s6 = "???"
s7 = "?????"




### Tester ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
#	@test brokendnasearch(root1, s1) == 1
#	@test brokendnasearch(root1, s2) == 0
	@test brokendnasearch(root1, s3) == 1
	@test brokendnasearch(root1, s4) == 0
#	@test brokendnasearch(root2, s1) == 5
	@test brokendnasearch(root2, s3) == 5
	@test brokendnasearch(root2, s4) == 5
	@test brokendnasearch(root2, s5) == 0
	@test brokendnasearch(root2, s6) == 4
	@test brokendnasearch(root3, s5) == 4
	@test brokendnasearch(root3, s6) == 4
	@test brokendnasearch(root3, s7) == 2
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
