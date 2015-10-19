# input format: tradingDay,open,high,low,close,volume
BEGIN {
    FS = ","
    n = 0
     
}
{
    if (!($5 ~ /[0-9]/)) next
    t[n] = $1     # time
    y[n] = $3     # high  
    z[n] = $4     # low
    c[n++] = $5   # close
}
END {
    for (i = 0; i < _offset-1; i++) {
        willr[i] = 0;
    }

    for (i = _offset -1 ; i < n; i++) {

        h = 0;
        l = 10000;

        # find hightest and lowest
        for (j = 0; j < _offset ; j++) {
            if(h < y[i-(_offset -1) + j]) h = y[i-(_offset-1) + j];
            if(l > z[i-(_offset -1) + j]) l = z[i-(_offset-1) + j];
        }
        willr[i] = (h - c[i])/(h-l) * (-100)
    }

    for(i=0; i<n;i++) {
        print t[i] "," willr[i] 
    }
} 
