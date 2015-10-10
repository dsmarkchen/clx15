BEGIN {
    n = 0
}
{
    L[n++] = $0 
} 
END { 
    while(n--) print L[n] 
}
