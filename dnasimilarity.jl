function dnasimilarity(s1, s2)
s=0
for i in 1:length(s1)
s+=s1[i]==s2[i]
end
s
end

println(dnasimilarity("ATCG", "ATGC"))
println(dnasimilarity("ATATATA", "TATATAT"))
