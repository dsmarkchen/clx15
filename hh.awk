# find high in high 

# input format: tradingDay,open,high,low,close,volume
 
BEGIN {
    FS = ","
    n = 0
    ha = 0
    hb = 0
    hc = 0 
      

}
{
    #print $1 "+++" $3
    if (!($3 ~ /[0-9]/)) next
    if(ha == 0) {
        ha = $3
        ta = $1    
        next
    }
    if(hb == 0) {
        hb = $3
        tb = $1
        next
    }
    if(hc == 0) {
        hc = $3
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
