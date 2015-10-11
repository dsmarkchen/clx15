# find low in low

# input format: tradingDay,open,high,low,close,volume
 
BEGIN {
    FS = ","
    n = 0
    la = 0
    lb = 0
    lc = 0 
      

}
{
    print $4
    if(la == 0) {
        la = $4
        ta = $1    
        next
    }
    if(lb == 0) {
        lb = $4
        tb = $1
        next
    }
    if(lc == 0) {
        lc = $4
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
