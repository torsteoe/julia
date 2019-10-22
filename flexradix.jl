
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
    
    for i in length(A):-1:1
        B[C[chartodigit(A[i][position])]] = A[i] 
        C[chartodigit(A[i][position])] -= 1
    end
    return B 
end



function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.

    return character - '`'
end



function countingsortlength(A)
    C = fill(0, 100)
    B = fill("", length(A))
    for i in 1:length(A)
        C[length(A[i])+1] += 1
    end
    for i in 1:length(C)-1
        C[i+1] += C[i]
    end
    
    for i in length(A):-1:1
        B[C[length(A[i])+1]] = A[i]
        C[length(A[i])+1] -= 1
    end
    return B
end


function flexradix(A, maxlength)
    if maxlength==0
        return A
    end
    A = countingsortlength(A)
    B = [[A[end]]]

    #make B a 2d array where all arrays in same sub have the same length
    current_length = length(A[end])
    index_B = 1
    for i in length(A)-1:-1:1
        if length(A[i]) != current_length
            current_length = length(A[i])
            index_B += 1
            push!(B, [])
        end
        push!(B[index_B],A[i])


    end
    array = B[1]
    println(B)
    index_B = 1
    for current_position in maxlength:-1:1
        println("Current position ", current_position)
        if index_B != size(B,1)
            if index_B != size(B,1) && length(B[index_B+1][1]) == current_position
                array = vcat(B[index_B+1], array)
                index_B+=1
            end


        end

        array = countingsortletters(array,  current_position)

        println("array:\t", array)
    end
    if B[end][1] == ""
        array = vcat(B[end], array)

    end
    return array
end
A = ["d", "c", "b", ""]
println("sorted array", flexradix(A, 1))

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test flexradix(["d", "c", "b", "a"], 1) == ["a", "b", "c", "d"]
    @test flexradix(["d", "c", "b", ""], 1) == ["", "b", "c", "d"]
    @test flexradix(["jeg", "elsker", "deg"], 6) == ["deg", "elsker", "jeg"]
    @test flexradix(["denne", "oppgaven", "mangler", "emojies"], 8) == ["denne", "emojies", "mangler", "oppgaven"]
    @test flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6) == ["agg", "aggie", "hyblen", "kobra", "kort"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
