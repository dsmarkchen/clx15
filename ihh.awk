# find high in high 

# input format: tradingDay,high
 
BEGIN {
    FS = ","
    n = 0
    ha = 0
    hb = 0
    hc = 0 
      

}
{
    #print $1 "+++" $3
    if(ha == 0) {
        ha = $2
        ta = $1    
        next
    }
    if(hb == 0) {
        hb = $2
        tb = $1
        next
    }
    if(hc == 0) {
        hc = $2
        tc = $1

        if((ha < hb) && (hc < hb)) {
            L[n++] = tb "," hb;
        }
        else {
           # L[n++] = 0;
        }

        ha = hb
        ta = tb
        hb = hc
        tb = tc
        hc = 0
    }
}
END{
    for(i=0;i<n;i++) {
        print L[i]
    }
}
