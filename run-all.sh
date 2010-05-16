killall shell-fm &> /dev/null
for i in `seq 2 10`; do 
/usr/local/bin/shell-fm -r shell-fm${i}.rc &> /dev/null &
done;
