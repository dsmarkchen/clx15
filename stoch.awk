# calculate stochastic indication %K %D

# input format: tradingDay,open,high,low,close,volume
# output format: 
 
BEGIN {
    FS = ","
    n = 0
     
#    offset_var =  14  
#    slow_var = 3   

}
{
    if (!($2 ~ /[0-9]/)) next
    t[n] = $1
    h[n] = $3   # high
    l[n] = $4   # low
    y[n++] = $5
}
END {

    #print "n: " n
    for (i = 0; i < offset_var-1; i++) {
        sma[i] = 0;
    }

    for (i = offset_var -1 ; i < n; i++) {
        min = 10000;
        max = 0
        for (j = 0; j < offset_var ; j++) {
            if(min > l[i-(offset_var - 1) + j]) min = l[i-(offset_var - 1) + j];
            if(max < h[i-(offset_var - 1) + j]) max = h[i-(offset_var - 1) + j];

        }
        cl[i] = y[i] - min   # close - lowest low
        # highest hight - lowest low
        hl[i] = max - min
        
        perK[i] = cl[i]/hl[i] * 100
       
        hh[i] = max
        ll[i] = min 

    }
    #for(i=0; i<n;i++) {
    #    print "xxx " t[i] ","  perK[i] "," cl[i] ", " hl[i] "," hh[i], "," ll[i]
    #}
  
    for (i=offset_var - 1 + slow_var -1  ; i < n; i++) {
        sumcl = 0;
        sumhl = 0;
        for(j=0; j< slow_var; j++) {
            sumcl += cl[i - (slow_var -1) + j] 
            sumhl += hl[i - (slow_var -1) + j]
        }
    #   print "i n sumcl sumhl: " i  " " n " " sumcl " " sumhl 
        ss[i] = sumcl/sumhl * 100
    } 

    for (i=slow_var -1; i < n; i++) {
        sum = 0;
        for(j=0; j< slow_var; j++) {
            sum += ss[i - (slow_var -1) + j] 
        }
        perD[i] = sum/slow_var;  # signal level
    } 



   for(i=0; i<n;i++) {
        print t[i] ","  perK[i] "," perD[i]
   }
} 
