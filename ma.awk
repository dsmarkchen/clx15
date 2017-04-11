# calculate sma and ema

# input format: tradingDay,open,high,low,close,volume
 
BEGIN {
    FS = ","
    n = 0
     
#    offset_var = 20      

}
{
    if (!($5 ~ /[0-9]/)) next
    t[n] = $1
    y[n++] = $5
}
END {


    for (i = 0; i < offset_var-1; i++) {
        sma[i] = 0;
    }

    for (i = offset_var -1 ; i < n; i++) {
        sum = 0;
        for (j = 0; j < offset_var ; j++) {
            sum += y[i-(offset_var - 1) + j];
        }
        sma[i] = sum / offset_var;
    }

    c = 2.0 / (offset_var + 1);
    ema[offset_var - 1] = sma[offset_var - 1];
    for (i = offset_var; i < n; i++)
    {
        ema[i] = ema[i - 1] + c * (y[i] - ema[i - 1]);
    }

    for(i=0; i<n;i++) {
        print t[i] "," sma[i] "," ema[i]
    }
} 
