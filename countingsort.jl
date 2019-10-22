function countingsortletters(A,position)
    #let c be a 1 indexed array filled with 0s
    C = fill(0, 26)
    B = fill("",length(A))
    for i in 1:length(A)
        C[chartodigit(A[i][position])] += 1
    end

    for i in 1:length(C)-1
       C[i+1] += C[i] 
    end
    
    println(A, B, C)
    for i in length(A):-1:1
        B[C[chartodigit(A[i][position])]] = A[i] 
        C[chartodigit(A[i][position])] -= 1
    end
    println(A, B, C)
    return B 
end



function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.

    return character - '`'
end

A = ["hei", "are", "hovr", "bbbb"]
println(countingsortletters(A, 2))
println(countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2))
