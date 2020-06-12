#!/bin/bash -x

#@Author : Amrut
#TicTacToe UseCase 5 [Check Result After Every Move win,loss and tie]

echo "******Welcome to TicTacToe Game******"

#constants
ROWS=3
COLUMNS=3
EMPTY=0
PLAYER_LETTER=''
COMP_LETTER=''
LENGTH=$(( $ROWS * $COLUMNS ))

#variables
cell=1
inputCell=''
declare -A board

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
      echo "====================="
      echo "### Player's Turn ###"
      echo "*********************"
   else
      echo "Computer Won The Toss"
      echo "======================="
      echo "### Computer's Turn ###"
      echo "***********************"
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
printf "\n"
echo "Computer's Letter is : $COMP_LETTER"
}

#function to initialize the board
function initializeBoard()
{
   for (( i=0; i<ROWS; i++ ))
   do
      for (( j=0; j<COLUMNS; j++ ))
      do
         board[$i,$j]=$cell
         ((cell++))
      done
   done
}

#function to display the board
function printBoard()
{
   for (( i=0; i<ROWS; i++ ))
   do
      for (( j=0; j<COLUMNS; j++ ))
      do
         echo -n "|  ${board[$i,$j]}  |"
      done
         printf "\n\n"
   done
}

#function to check the board and input the letter
function checkBoardForInput()
{
   local rowIndex=''
   local columnIndex=''

   for (( i=0; i<$LENGTH; i++ ))
   do
      printBoard
      read -p "Choose a cell you want : " inputCell

      if [ $inputCell -gt $LENGTH ]
      then
         echo "Invalid input, please select valid one"
         printf "\n"
         ((i--))
      else
         rowIndex=$(( $inputCell / $ROWS ))
         if [ $(( $inputCell % $ROWS )) -eq 0 ]
         then
            rowIndex=$(( $rowIndex - 1 ))
         fi
         columnIndex=$(( $inputCell % $ROWS ))
         if [ $columnIndex -eq 0 ]
         then
            columnIndex=$(( $columnIndex + 2 ))
         else
            columnIndex=$(( $columnIndex - 1 ))
         fi

         if [ "${board[$rowIndex,$columnIndex]}" == "$PLAYER_LETTER" ] || [ "${board[$rowIndex,$columnIndex]}" == "$COMP_LETTER" ]
         then
            echo "Invalid input, This cell is already filled, please choose another cell"
            printf "\n"
            ((i--))
         fi
         board[$rowIndex,$columnIndex]=$PLAYER_LETTER

         if [ $(checkResult) -eq 1 ]
         then
            echo "You Won The Game"
            return 0
         else
            printf "\n"
            echo "**Change Turn**"
			 fi
      fi
   done
      echo "Match Tie"
}

#function to check the result after every move
function checkResult()
{
   if [ $((${board[0,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[0,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[0,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[1,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[1,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[2,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[2,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[2,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[0,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,0]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[2,0]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[0,1]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[2,1]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[0,2]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,2]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[2,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[0,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[2,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   elif [ $((${board[2,0]})) -eq $(($PPLAYER_LETTER)) ] && [ $((${board[1,1]})) -eq $(($PLAYER_LETTER)) ] && [ $((${board[0,2]})) -eq $(($PLAYER_LETTER)) ]
   then
      echo 1
   else
      echo 0
   fi
}
resettingBoard
toss
assigningLetter
initializeBoard
checkBoardForInput
printBoard



