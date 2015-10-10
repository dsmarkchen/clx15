set term png size 1920,1080 enhanced font 'Verdana,10'
set output "clx15.png"
set grid
set datafile separator ","
set label "dsmarkchen\\@gmail.com" at graph 0.01, 0.07
set logscale y

set ytics (60, 55, 50, 45, 40, 35, 30)
# set yrange [35:65]
set xdata time
#set timefmt '%d/%m/%Y %H:%M:%S'
set timefmt '%Y-%m-%d'
set xtics format "%b %d, %Y"
set title "CLX15 Daily"
set xrange ["2015-05-31":*]
#plot 'file.dat' using 1:3 skip 1 with lines
plot 'qqq2.csv' using 1:2:4:3:5 skip 1 notitle with candlesticks, 'lll2.csv' using 1:2 notitle , 'hhh2.csv' using 1:2 notitle 
