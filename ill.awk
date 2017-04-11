 # find low in low

# input format: tradingDay,low
 
BEGIN {
    FS = ","
    n = 0
    la = 0
    lb = 0
    lc = 0 
      

}
{
    if(la == 0) {
        la = $2
        ta = $1    
        next
    }
    if(lb == 0) {
        lb = $2
        tb = $1
        next
    }
    if(lc == 0) {
        lc = $2
        tc = $1

        if((la > lb) && (lc > lb)) {
            L[n++] = tb "," lb;
        }
        else {
           # L[n++] = 0;
        }

        la = lb
        ta = tb
        lb = lc
        tb = tc
        lc = 0
    }
}
END{
    for(i=0;i<n;i++) {
        print L[i]
    }
}
