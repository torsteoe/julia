function findset(x)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end

