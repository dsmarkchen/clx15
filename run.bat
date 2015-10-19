rem system for stock speculation
rem
rem download stock file with qsc utility
qsc %1 > temp.txt
set /p qscres=<temp.txt
if %qscres% neq OK goto :EOF

rem processing the file and plot

gawk -f reverse.awk qqq.csv > qqq2.csv
gawk -v _stock=%1 -v _enable_willr=1 -v _enable_vol=0 -f clx.awk qqq2.csv > q.plt
gawk -v _stock=%1 -v _enable_willr=0 -v _enable_vol=1 -f clx.awk qqq2.csv > qvol.plt
gawk -v offset_var=20 -f ma.awk  qqq2.csv > ma2.csv
gawk -v offset_var=50 -f ma.awk  qqq2.csv > ma50.csv
gawk -v offset_var=100 -f ma.awk  qqq2.csv > ma100.csv
gawk -v _offset=14 -f willr.awk qqq2.csv > willr2.csv
gawk -f hh.awk qqq2.csv > hh2.csv
gawk -f ihh.awk hh2.csv > ihh2.csv
gawk -f ihh.awk hh2.csv > lhh2.csv

gawk -f ll.awk qqq2.csv > ll2.csv
gawk -f ill.awk ll2.csv > ill2.csv
gawk -f ill.awk ill2.csv > lll2.csv

c:\gnuplot\bin\gnuplot.exe q.plt

c:\gnuplot\bin\gnuplot.exe qvol.plt
