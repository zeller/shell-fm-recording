for file; do
info=${file##*/}
info=${info%.mp3}
artist=$(echo $info | cut -d';' -f1)
song=$(echo $info | cut -d';' -f2)
album=$(echo $info | cut -d';' -f3)
id3v2 -a "$artist" -t "$song" -A "$album" "$file";
done;