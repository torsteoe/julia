function usegreed(coins)
    # Din kode her
    for i in 2:length(coins)
       if (coins[i-1]%coins[i]!=0)
            return false
       end
    end
    return true
end

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

function mincoinsdynamic(coins, value)
    counts=[0]
    for i in 2:value+1
        push!(counts, counts[i-1]+1)
        for coin in coins
            if coin < i && counts[i-coin]+1<counts[i]
                counts[i] = counts[i-coin]+1
            end
        end
    end
        return counts[value+1]
end
function mincoins(coins, value)
    # Om du ikke trenger inf kan du fjerne den
    inf = typemax(Int)
    # Din kode her
    if usegreed(coins)
        return mincoinsgreedy(coins, value)
    end
    return mincoinsdynamic(coins, value) 
end
printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoins([4,3,1],18) == 5
  @test mincoins([1000,500,100,30,7,1],14) == 2
  @test mincoins([40, 30, 20, 10, 1], 90) == 3
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
