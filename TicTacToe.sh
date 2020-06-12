#!/bin/bash -x

#@Author : Amrut
#TicTacToe UseCase 2 [Toss to decide who get first chance to fill the board]

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
   else
      echo "Computer Won The Toss"
   fi
}
resettingBoard
toss

