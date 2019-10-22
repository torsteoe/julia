
function countingsortlength(A)
    C = fill(0, 5)
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

using Test
@testset "Basic tests" begin
    @test countingsortlength(["ccc", "bb", "a"]) == ["a", "bb", "ccc"]
    @test countingsortlength(["aaa", "bb", "c"]) == ["c", "bb", "aaa"]
    @test countingsortlength(["bb", "a", ""]) == ["", "a", "bb"] # Testen her sjekker om du kan sortere også med emtpy string
    @test countingsortlength(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"] # Fra oppgaven
end
