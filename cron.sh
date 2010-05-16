#!/bin/bash
# Run this every T hours
# i.e. T = 6 hours

## Hide pushd/popd output
pushd()
{
    builtin pushd "$@" > /dev/null
}

popd()
{
    builtin popd "$@" > /dev/null
}

restart() {
    echo "Restarting..."
    find seed -name '*.mp3' | cut -d';' -f1 | cut -d'/' -f3 > "$TEMP_FILE"
}

get_next() {
    echo "Getting the next artist"
    pushd "$artist"
    ret=`ls *.mp3 2> /dev/null | wc -l`
    if [ $ret -eq 0 ]; then
        # no songs were recorded to select from
        echo "Current directory found empty"
        echo "FOUND EMPTY" | cat >> $LOG_FILE
        popd
        restart
    else
        ls *.mp3 | cut -d';' -f1 > "$TEMP_FILE"
        popd
    fi
}

SHELL_FM_HOME="/home/zeller/.shell-fm"
MUSIC_DIR="/home/storage/music/lastfm"
R_SCRIPT="${SHELL_FM_HOME}/inverse-sample.r"
TEMP_FILE="/tmp/artists"
LOG_FILE="$SHELL_FM_HOME/markov.log"

# 10% of the time (or first time) we sample the main directory
# 90% of the time we sample the current directory
cd "$SHELL_FM_HOME"
artist=`tail -n 1 $LOG_FILE 2> /dev/null`
ret=$?
pushd "$MUSIC_DIR"
if [ $ret -ne 0 ] || [ $(($RANDOM % 3)) -eq 0 ]; then
    restart
    echo "RESTART" | cat >> $LOG_FILE
else
    get_next
fi
popd

# get a new artist using some statistics
artist=`Rscript "${R_SCRIPT}" < ${TEMP_FILE}`

# write out artist to a log file
echo "$artist" | cat >> $LOG_FILE

# restart shell-fm with the new configuration
./create-all.sh "$artist"
./run-all.sh
