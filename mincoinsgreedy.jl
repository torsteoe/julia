function mincoinsgreedy(coins, value)
    # Din kode her
    num = 0
    i = 1
    while value != 0 
        numThisCoin = div(value, coins[i]) 
        value -= numThisCoin*coins[i]

        num += numThisCoin 
        if numThisCoin == 0
            i+=1
        end
    end
    return num
end
printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoinsgreedy([1000,500,100,20,5,1],1226) == 6
  @test mincoinsgreedy([20,10,5,1],99) == 10
  @test mincoinsgreedy([5,1],133) == 29
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
