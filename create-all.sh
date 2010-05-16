artist=$1
ARTIST_DIR="/home/storage/music/lastfm/$artist"
if [ ! -e "$ARTIST_DIR" ]; then
    mkdir "$ARTIST_DIR"
fi
for i in `seq 2 10`; do 
cat > shell-fm${i}.rc << EOF
username=USERNAME
password=yourpasswordhere
default-radio=lastfm://artist/ARTISTNAME/similarartists
extern=dd of=/home/storage/music/lastfm/'ARTISTNAME'/%a\;%t\;%l\;%d.mp3
delay-change=true
minimum=80
gap~=20
EOF
sed -e "s/ARTISTNAME/$(printf %q "$artist")/g" -e "s/USERNAME/shellfm-bot${i}/g" -i shell-fm${i}.rc; 
done;
