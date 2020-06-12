#!/bin/bash -x

#@Author : Amrut
#TicTacToe UseCase 8 [Check for computer win and block]

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
playerTurn=''
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
		playerTurn=0
      echo "Player Won The Toss"
      echo "====================="
   else
		playerTurn=1
      echo "Computer Won The Toss"
      echo "======================="
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
         printf "\n"
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
		if [ "$playerTurn" == 0 ]
      then
      echo""
      echo "*****Player's Turn*****"
      echo "************************"

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
			else
         	board[$rowIndex,$columnIndex]=$PLAYER_LETTER
				playerTurn=1

         if [ $(checkResult $PLAYER_LETTER) -eq 1 ]
         then
            echo "You Won The Game"
            return 0
          fi
		  fi
      fi
    else
       printf "\n"
       echo "****Computer's Turn****"
       echo "************************"
		 checkRowForCompWin
       checkColForCompWin
       checkDiagonalForCompWin
       computerTurn
       playerTurn=0
       if [ $(checkResult $COMP_LETTER) -eq 1 ]
       then
            echo "Computer Won The Game"
            return 0

		 fi
    fi
  done
      echo "Match Tie"
}

#function to check the result after every move
function checkResult()
{
	  symbol=$1

   if [ ${board[0,0]} == $symbol ] && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi
}

#function for computer turn
function computerTurn()
{
#for Rows
    local row=0
   local col=0
   for ((row=0; row<NUM_OFROWS; row++))
   do
      if [ ${board[$row,$col]} == $PLAYER_LETTER ] && [ ${board[$(($row)),$(($col+1))]} == $PLAYER_LETTER ]
      then
          if [ ${board[$row,$(($col+2))]} != $COMP_LETTER ]
          then
             board[$row,$(($col+2))]=$COMP_LETTER
             break
          fi
      elif [ ${board[$row,$(($col+1))]} == $PLAYER_LETTER ] && [ ${board[$row,$(($col+2))]} == $PLAYER_LETTER ]
      then
          if [ ${board[$row,$col]} != $COMP_LETTER ]
          then
             board[$row,$col]=$COMP_LETTER
             break
          fi
      elif [ ${board[$row,$col]} == $PLAYER_LETTER ] && [ ${board[$row,$(($col+2))]} == $PLAYER_LETTER ]
      then
          if [ ${board[$row,$(($col+1))]} != $COMP_LETTER ]
          then
             board[$row,$(($col+1))]=$COMP_LETTER
             break
          fi
      fi
   done

#FOR COLUMN
   local row=0
   local col=0
   for ((col=0; col<NUM_OFCOLUMNS; col++))
   do
      if [ ${board[$row,$col]} == $PLAYER_LETTER ] &&  [ ${board[$(($row+1)),$col]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+2)),$col]} != $COMP_LETTER ]
         then
            board[$(($row+2)),$col]=$COMP_LETTER
            break
         fi
      elif [ ${board[$(($row+1)),$col]} == $PLAYER_LETTER ] && [ ${board[$(($row+2)),$col]} == $PLAYER_LETTER ]
      then
         if [ ${board[$row,$col]} != $COMP_LETTER ]
         then
            board[$row,$col]=$COMP_LETTER
            break
          fi
      elif [ ${board[$row,$col]} == $PLAYER_LETTER ] && [ ${board[$(($row+2)),$col]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+1)),$col]} != $COMP_LETTER ]
         then
            board[$(($row+1)),$col]=$COMP_LETTER
            break
         fi
      fi
   done

#FOR DIAGONAL
      local row=0
      local col=0

      if [ ${board[$row,$col]} == $PLAYER_LETTER ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+2)),$(($col+2))]} != $COMP_LETTER ]
         then
            board[$(($row+2)),$(($col+2))]=$COMP_LETTER
            return
         fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_LETTER ] && [ ${board[$(($row+2)),$(($col+2))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$row,$col]} != $COMP_LETTER ]
         then
            board[$row,$col]=$COMP_LETTER
            return
          fi
      elif [ ${board[$row,$col]} == $PLAYER_LETTER ] && [ ${board[$(($row+2)),$(($col+2))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $COMP_LETTER ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $PLAYER_LETTER ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$row,$(($col+2))]} != $COMP_LETTER ]
         then
            board[$row,$(($col+2))]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $PLAYER_LETTER ] && [ ${board[$row,$(($col+2))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+2)),$col]} != $COMP_LETTER ]
         then
            board[$(($row+2)),$col]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $PLAYER_LETTER ] && [ ${board[$row,$(($col+2))]} == $PLAYER_LETTER ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $COMP_LETTER ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_LETTER
            return
          fi
		 else
         while [ true ]
         do
            local row=$(( RANDOM % $ROWS ))
            local col=$(( RANDOM % $COLUMNS ))

            if [ ${board[$row,$col]} == $PLAYER_LETTER ] || [ ${board[$row,$col]} == $COMP_LETTER ]
            then
               continue
            else
               board[$row,$col]=$COMP_LETTER
               break
            fi
         done
      fi
}

#function to check row for computer win
function checkRowForCompWin()
{
   local row=0
   local column=0
   for ((row=0; row<ROWS; row++))
   do
      if [ ${board[$row,$column]} == $COMP_LETTER ] && [ ${board[$row,$(($column+1))]} == $COMP_LETTER ]
      then
         if [ ${board[$row,$(($column+2))]} != $PLAYER_LETTER ]
         then
            board[$row,$(($column+2))]=$COMP_LETTER
            break
         fi
      elif [ ${board[$row,$column]} == $COMP_LETTER ] && [ ${board[$row,$(($colum+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$row,$column]} != $PLAYER_LETTER ]
         then
            board[$row,$column]=$COMP_LETTER
            break
         fi
      elif [ ${board[$row,$column]} == $COMP_LETTER ] && [ ${board[$row,$(($colum+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$row,$(($column+1))]} != $PLAYER_LETTER ]
         then
            board[$row,$(($column+1))]=$COMP_LETTER
            break
         fi
      fi
   done
}

#function to check column for computer win
function checkColForCompWin()
{
   local row=0
   local column=0
   for ((column=0; column<COLUMNS; column++))
   do
      if [ ${board[$row,$column]} == $COMP_LETTER ] && [ ${board[$(($row+1)),$column]} == $COMP_LETTER ]
      then
         if [${board[$(($row+2)),$column]} != $PLAYER_LETTER ]
         then
            board[$(($row+2)),$column]=$COMP_LETTER
            break
         fi
      elif [ ${board[$(($row+1)),$column]} == $COMP_LETTER ] && [ ${board[$(($row+2)),$column]} == $COMP_LETTER ]
      then
         if [${board[$row,$column]} != $PLAYER_LETTER ]
         then
            board[$row,$column]=$COMP_LETTER
            break
         fi
      elif [ ${board[$row,$column]} == $COMP_LETTER ] && [ ${board[$(($row+2)),$column]} == $COMP_LETTER ]
      then
         if [${board[$(($row+1)),$column]} != $PLAYER_LETTER ]
         then
            board[$(($row+1)),$column]=$COMP_LETTER
            break
         fi
      fi
   done

}

#function to check diagonal for computer win
function checkDiagonalForCompWin()
{
   local row=0
   local col=0

      if [ ${board[$row,$col]} == $COMP_LETTER ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $COMP_LETTER ]
      then
         if [ ${board[$(($row+2)),$(($col+2))]} != $PLAYER_LETTER ]
         then
            board[$(($row+2)),$(($col+2))]=$COMP_LETTER
            return
         fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $COMP_LETTER ] && [ ${board[$(($row+2)),$(($col+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$row,$col]} != $PLAYER_LETTER ]
         then
            board[$row,$col]=$COMP_LETTER
            return
          fi
      elif [ ${board[$row,$col]} == $COMP_LETTER ] && [ ${board[$(($row+2)),$(($col+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $PLAYER_LETTER ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $COMP_LETTER ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $COMP_LETTER ]
      then
         if [ ${board[$row,$(($col+2))]} != $PLAYER_LETTER ]
         then
            board[$row,$(($col+2))]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+1)),$(($col+1))]} == $COMP_LETTER ] && [ ${board[$row,$(($col+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$(($row+2)),$col]} != $PLAYER_LETTER ]
         then
            board[$(($row+2)),$col]=$COMP_LETTER
            return
          fi
      elif [ ${board[$(($row+2)),$col]} == $COMP_LETTER ] && [ ${board[$row,$(($col+2))]} == $COMP_LETTER ]
      then
         if [ ${board[$(($row+1)),$(($col+1))]} != $PLAYER_LETTER ]
         then
            board[$(($row+1)),$(($col+1))]=$COMP_LETTER
				 return
          fi
      else
         return
      fi
}

resettingBoard
toss
assigningLetter
initializeBoard
checkBoardForInput
printBoard



