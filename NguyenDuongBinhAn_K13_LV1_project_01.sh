#Download Data
wget https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv
#Clean Data
awk -F, 'NF<21' tmdb-movies.csv > unclean_data.csv
awk -F, 'NF==21' tmdb-movies.csv > clean_data.csv
#Task 1
csvsort -c release_date -r clean_data.csv > task1.csv
#Task 2
awk -F, 'NR == 1 {print $0; next} {if ($18 > 7.5) {print $0}}' clean_data.csv > task2.csv
#Task 3
awk -F, 'NR==1 {print $0;next} {if ($21 > max || NR==2) {max=$21; maxLine=$0}} {if ($21 < min || NR==2) {min=$21; minLine=$0}} END {print "Max revenue film:"  maxLine; print "Min revenue film:"  minLine}' clean_data.csv > task3.csv
#Task 4
awk -F, 'NR==1 {sum=0;next} {sum += $21} END {print "Total revenue: " sum;}' clean_data.csv > task4.csv
#Task 5
awk -F, 'NR > 1 {print $0}' clean_data.csv | sort -t',' -k21,21nr | head -10 > task5.csv
#Task 6
csvtool col 9 clean_data.csv | tr '|' '\n'| awk -F, '{print $0;}'| awk -F, '{if ($1) {a[$1]++;}} END {for (i in a) if (a[i] > 0) {print i, "," , a[i];}}' | sort -t',' -k2,2nr > output.csv
head -1 output.csv > task6.csv
tail -1 output.csv >> task6.csv
#Task 7
csvtool col 14 clean_data.csv | tr '|' '\n'| awk -F',' 'NR>1 {print $0;}'| awk -F',' '{if ($1) {a[$1]++;}} END {for (i in a) if (a[i] > 0) {print i, a[i];}}' > task7.csv

