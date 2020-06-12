#!/bin/bash -x

#@Author : Amrut
#TicTacToe UseCase 3 [Assinging symbols i.e. 0 or x to player and computer]

echo "******Welcome to TicTacToe Game******"

#constants
ROWS=3
COLUMNS=3
EMPTY=0

#variables
declare -a board

#function for resetting board
function resettingBoard()
{
   for (( i=0; i<ROWS; i++ ))
   do
      for (( j=0; j<COLUMNS; j++ ))
      do
         board[$i,$j]=$EMPTY
      done
   done
}

#function for the toss
function toss()
{
   if [ $(( RANDOM%2 )) -eq 0 ]
   then
      echo "Player Won The Toss"
      echo "==================="
      echo "Player's Turn"
   else
      echo "Computer Won The Toss"
      echo "====================="
      echo "Computer's Turn"
   fi
}

#function for assigning the letter
function assigningLetter()
{
   if [ $(( RANDOM%2 )) -eq 0 ]
	 then
      PLAYER_LETTER=X
      COMP_LETTER=O
   else
      PLAYER_LETTER=O
      COMP_LETTER=X
   fi
echo "Player's Letter is : $PLAYER_LETTER"
echo "Computer's Letter is : $COMP_LETTER"
}
resettingBoard
toss
assigningLetter

