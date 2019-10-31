function hammingdistance(s1, s2)
    sum = length(s1)
    for i = 1:length(s1)
        sum -= Int(s1[i]==s2[i])
    end
    return sum
end 

