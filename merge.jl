
#x og y er to sorterte arrays, coordinate angir koordinat akse
function mergearrays(x,y,coordinate)
	temp = [1 1] 
    x_idx = 1
    y_idx = 1
    while (x_idx <= size(x,1) && y_idx <= size(y,1))
        if (x[x_idx, coordinate] <= y[y_idx, coordinate])
            temp = vcat(temp, [x[x_idx,1] x[x_idx,2]])
            x_idx+=1
        else
            temp = vcat(temp, [y[y_idx,1] y[y_idx,2]])
            y_idx+= 1
        end
    end
	if (x_idx<=size(x,1))
	    for i in x_idx:size(x,1)
		temp = vcat(temp, [x[i, 1] x[i,2]]) 
	    end
		    temp = temp[setdiff(1:end, 1), :]	

		return temp
	end
	    for i in y_idx:size(y,1)
		temp = vcat(temp, [y[i,1] y[i, 2]]) 
	    end
	    temp = temp[setdiff(1:end, 1), :]	
	    return temp
end
#x usortert array, coordinate angir koordinat akse vi skal sortere langs
function mergesort(x, coordinate)
	if (size(x,1) <= 1)
		return x
	end
	left = x[1:size(x,1)÷2, :]
	right = x[size(x,1)÷2+1:size(x,1), :]
	return mergearrays(mergesort(left, coordinate), mergesort(right, coordinate), coordinate)    
end
#print(mergearrays([1 3; 2 2; 3 5; 4 2], [1 2; 1 2; 4 3], 1));
arr = mergesort([3 2; 2 6; 4 5; 6 3; 4 6; 2 6; 3 5; 65 4; 1 1; 2 2 ; 342 1; 324 2], 2)
println(mergesort([1 2; 4 6; 2 1],1)) 
println(mergesort([1 2; 4 5; 2 1],2)) 
print(arr)
print([2 6][1, 1])
