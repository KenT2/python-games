#!/bin/sh
# Thanks to KenT for contributions

RET=0
SOUND=$(zenity --list --width=350 --height=250 --radiolist \
  --title="Choose the Audio Output" \
  --column "Select" --column="Output" TRUE "Leave as is" FALSE "Auto" FALSE "Force Headphones" FALSE "Force HDMI"  )
RET=$?
echo $SOUND
if [ "$SOUND" = "Leave as is" ]; then
   echo "Leave as is"
elif [ "$SOUND" = "Auto" ]; then
   amixer -c 0 cset numid=3 0
   echo "Auto set"
elif [ "$SOUND" = "Force Headphones" ]; then
   amixer -c 0 cset numid=3 1
   echo "Headphones set"
elif [ "$SOUND" = "Force HDMI" ]; then
   amixer -c 0 cset numid=3 2
   echo "HDMI set"
else
   echo "cancel"
fi

while [ $RET -eq 0 ]; do
  GAME=$(zenity --width=350 --height=700 --list \
    --title="Choose the Python game to launch" \
    --text="Games by Al Sweigart. Manual at inventwithpython.com/pygame" \
    --column="Script name" --column="Description" \
    flippy "A game like reversi" \
    fourinarow "Get four in a row" \
    gemgem "A tile matching puzzle" \
    inkspill "Flood the screen with pixels" \
    memorypuzzle "Test your memory" \
    pentomino "5 block Tetris" \
    simulate "Repeat the pattern" \
    slidepuzzle "Traditional slide puzzle" \
    squirrel "Eat the smaller squirrels" \
    starpusher "Sokoban" \
    tetromino "Tetris-like game" \
    tetrominoforidiots "Tetris for Idiots" \
    wormy "Snake-like game" \
    website "inventwithpython.com")
  RET=$?
  echo $RET
  if [ "$RET" -eq 0 ]
  then
     if [ "$GAME" = "website" ]
     then
        sensible-browser "http://inventwithpython.com/pygame"
     else
       if [ "$GAME" != "" ]; then
          cd /home/$USER/python_games
          python $GAME.py
       fi
     fi
  fi
done
