# calculate  bollinger upper band, lower band

# input format: tradingDay,open,high,low,close,volume
# output format: trading day, middle band, standard deviation, up band, low band
 
BEGIN {
    FS = ","
    n = 0
     ratio = 2

     offset_var = 13 # 20      

}
{
    if (!($5 ~ /[0-9]/)) next
    t[n] = $1
    y[n++] = $5
}
END {

    # print "n: " n
    for (i = 0; i < offset_var-1; i++) {
        sma[i] = 0;
    }

    for (i = offset_var -1 ; i < n; i++) {
        sum = 0;
        sumsq = 0;
        for (j = 0; j < offset_var ; j++) {
            sum += y[i-(offset_var - 1) + j];
            sumsq += y[i-(offset_var - 1) + j]^2;
        }
        stddev[i] = sqrt((1/offset_var) * (sumsq - sum ^2/offset_var))
        sma[i] = sum / offset_var;
        mbands[i] = sma[i]
    }

 
    for(i=0; i<n;i++) {
        print t[i] ","  mbands[i] "," stddev[i] "," mbands[i] + stddev[i]*ratio "," mbands[i] - stddev[i]*ratio
    }
} 
