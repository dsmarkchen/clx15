gawk -f reverse.awk qqq.csv > qqq2.csv
gawk -f hh.awk qqq2.csv > hhh2.csv
gawk -f ll.awk qqq2.csv > lll2.csv
c:\gnuplot\bin\gnuplot.exe qqq.plt
