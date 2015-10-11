# generate gnuplot file based on input finace data

# input
# input format: tradingDay,open,high,low,close,volume

BEGIN {
    FS = ","
    hmax = 0
    lmin = 10000
    N=10
    start_time = "2015-03-31"
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
        if($4 < lmin) {
            lmin = $4
        }
    }
}
END {
#    print int(lmin) "##" int(hmax + 0.5)


    print "set grid"
    print "set datafile separator \",\""
    print "set label \"dsmarkchen\\\\@gmail.com\" at graph 0.01, 0.07"
    print "set rmargin 5"  # make x-axis label not cropped

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
    print "set xtics format \"%b %d, %Y\""
    print "set title \"" s_stockname " Daily Plot\""

    print "set xrange [\"" start_time "\":*]"

    l = int(lmin);
    l0 = l;
    if(l == 0) l0 = 0.5;
    print "set yrange [" l0 ":" int (hmax+1.5) "]"
    h = int (hmax+1.5);
    n = (h-l0)/N
    printf "set ytics (" 
    for(i=0;i<N;i++) {
        printf l0 + n*i ","
    }
    print ")"
    print "plot 'qqq2.csv' using 1:2:4:3:5:($5 < $2 ? -1 : 1) skip 1 notitle with candlesticks palette , \\"
    print " 'll2.csv' using 1:2 notitle, 'hh2.csv' using 1:2 notitle, \\"
    print " 'ill2.csv' using 1:2 notitle, 'ihh2.csv' using 1:2 notitle, \\"
    print " 'lll2.csv' using 1:2 notitle pt 7 ps 2 lc \"green\", 'lhh2.csv' using 1:2 notitle pt 7 ps 2 "

}
