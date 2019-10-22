function binaryintervalsearch(x,delta, coordinate)
	if x.empty
		return -1, -1
  	end 
	#find median
	len = size(x,1)
	if (len  % 2 == 0)
		median = (x[len/2]+x[len/2+1])/2
	else 
		median = x[len/2+1]
	end
	index_left = ceiling(median - delta)
	index_right = floor(median + delta) 
end
