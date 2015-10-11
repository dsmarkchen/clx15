gawk -f reverse.awk qqq.csv > qqq2.csv
gawk -f clx.awk qqq2.csv > q.plt
gawk -f hh.awk qqq2.csv > hh2.csv
gawk -f ihh.awk hh2.csv > ihh2.csv
gawk -f ihh.awk hh2.csv > lhh2.csv

gawk -f ll.awk qqq2.csv > ll2.csv
gawk -f ill.awk ll2.csv > ill2.csv
gawk -f ill.awk ill2.csv > lll2.csv

c:\gnuplot\bin\gnuplot.exe q.plt
