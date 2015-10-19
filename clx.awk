# generate gnuplot file based on input finace data

# input
# input format: tradingDay,open,high,low,close,volume

BEGIN {
    FS = ","

#    _enable_willr = 1
#    _enable_vol = 0

    if(_enable_willr && _enable_vol) exit

    hmax = 0
    lmin = 10000
    N=10
    start_time = "2015-06-18"
    s_date = start_time
    gsub( /-/, " ", s_date ); 
    s_date = s_date " " 00 " " 00 " " 00; 
    s_time = mktime(s_date);


    while(( getline line < "stockname") > 0 ) {
     s_stockname = line
    }
}

{
    e_date = $1
    gsub( /-/, " ", e_date ); 
     e_date = e_date " " 00 " " 00 " " 00; 
    e_time = mktime(e_date);
    if(s_time > e_time) next
    if($3 ~ /[0-9]/)
    {
        if($3 > hmax) {
            hmax = $3
        }

        if($6 > vmax) {
            vmax = $6
        }
 
        if($4 < lmin) {
            lmin = $4
        }
    }
}
END {
    print "set term png size 920,680 enhanced font 'Verdana,10'"
    print "set output '" _stock  _enable_willr _enable_vol ".png'"    
    print "set multiplot"
    print "set size 1, 0.7"
    print "set origin 0, 0.3"
    print "set lmargin 7"  


    print "set grid x y2"
    print "set datafile separator \",\""
    print "set label \"dsmarkchen\\\\@gmail.com\" at graph 0.01, 0.07"
    print "set rmargin 7"  # make x-axis label not cropped

    print "set palette defined (-1 'red', 1 'green')"
    print "set cbrange [-1:1]"
    print "unset colorbox"
    print "set border linecolor rgbcolor \"black\""
    print "set border linewidth 0.5"
    print "set style fill solid border linecolor rgbcolor \"black\"" 
    print "set boxwidth 57500 absolute"
    print "set logscale y"
    print "set xdata time"
    print "set timefmt '%Y-%m-%d'"
    print "set xtics format \" \""   #"set xtics format \"%b %d\""
    print "set title \"" s_stockname " Daily Plot\""

    print "set xrange [\"" start_time "\":*]"

    l = int(lmin);
    l0 = l;
    if(l == 0) l0 = 0.5;
    print "set y2range [" l0 ":" int (hmax+1.5) "]"
    h = int (hmax+1.5);
    n = (h-l0)/N
    printf "set y2tics (" 
    for(i=0;i<N;i++) {
        printf l0 + n*i ","
    }
    print ")"
    print "unset yrange"
    print "unset ytics"
    print "plot 'qqq2.csv' using 1:2:4:3:5:($5 < $2 ? -1 : 1)  skip 1 notitle axes x1y2 with candlesticks palette , \\"
    print " 'll2.csv' using 1:2 notitle axes x1y2, 'hh2.csv' using 1:2 notitle axes x1y2, \\"
    print " 'ill2.csv' using 1:2 notitle axes x1y2, 'ihh2.csv' using 1:2 notitle axes x1y2, \\"
    print " 'lll2.csv' using 1:2 notitle pt 7 ps 2 lc \"green\" axes x1y2, 'lhh2.csv' using 1:2 notitle pt 7 ps 2 axes x1y2, \\"
    print " 'ma100.csv' using 1:2 title \"SMA100\" with lines axes x1y2, 'ma100.csv' using 1:3 title \"EMA100\" with lines axes x1y2,\\" 
    print " 'ma2.csv' using 1:2 title \"SMA20\" with lines axes x1y2, 'ma2.csv' using 1:3 title \"EMA20\" with lines axes x1y2" 

    l = int(vmax/1000000/3); # 1 m 
    if(l == 0) {
         l = 0.5 
         print "set format y \"%1.2f\""
    } 
    else {
        print "set format y \"%1.0f\""
    }

    print "unset label"
    print "unset title"
    print "set size 1.0, 0.3"
    print "set origin 0, 0.0"
    print "set xtics format \"%b %d\""
   if(_enable_willr) {
        print "unset ytics "
        print "unset yrange"
        print "set title \" William Percentage Range\"" " offset 0,-1"
        print "set y2range [-100:0]"
        print "set y2tics 20 " 
        print "plot 'willr2.csv' using 1:2 notitle axes x1y2 with lines"

    }
    if(_enable_vol) {
        print "unset logscale y2"
        print "set autoscale y2"
        print "set y2tics " l
        print "plot 'qqq2.csv' using 1:($6/1000000):($5 < $2 ? -1 : 1) notitle axes x1y2 with boxes palette lt 3"
    }
    print "unset multiplot"
}
