# set term png size 1920,1080 enhanced font 'Verdana,10'
# set output "clx15.png"
set grid
set datafile separator ","
set label "dsmarkchen\\@gmail.com" at graph 0.01, 0.07

set palette defined (-1 'red', 1 'green')
set cbrange [-1:1]
unset colorbox
set border linecolor rgbcolor "black"
set border linewidth 0.5
set style fill solid border linecolor rgbcolor "black" 
set boxwidth 57500 absolute
set logscale y

set xdata time
#set timefmt '%d/%m/%Y %H:%M:%S'
set timefmt '%Y-%m-%d'
set xtics format "%b %d, %Y"
set title "CLX15 Daily"

set xrange ["2015-01-31":*]
# set yrange [37:67]
#set ytics (65, 60, 55, 50, 45, 40, 35, 30)
#set ytics (4.5, 4, 3.5, 3, 2.5, 2, 1.5,1,0.5, 0.5)
#set yrange [0.5:5]
set yrange [*:*]

#plot 'file.dat' using 1:3 skip 1 with lines
plot 'qqq2.csv' using 1:2:4:3:5:($5 < $2 ? -1 : 1) skip 1 notitle with candlesticks palette , \
 'll2.csv' using 1:2 notitle, 'hh2.csv' using 1:2 notitle, \
 'ill2.csv' using 1:2 notitle, 'ihh2.csv' using 1:2 notitle, \
 'lll2.csv' using 1:2 notitle , 'lhh2.csv' using 1:2 notitle 
