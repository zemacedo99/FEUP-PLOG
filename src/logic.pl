/* In this file we have
* all the logic of how the game actually works, meaning:
* checking for winning and losing cases
* checking for possible places where the player can play (and where he can't) - basically have a possible positions list
* everytime a player plays, given the chosen color, the functions need to check for winning and update that space as being occupied with that color
*/

/* The player can choose between
* G : Green piece
* P : Purple piece
* O : Orange piece 
*/

/* Player 1 has the following color combinations:
* To connect orange - Orange & Purple
* To connect purple - Purple & Green
* To connect green - Green & Orange
*/

/* Player 2 has the following color combinations:
* To connect orange - Orange & Green
* To connect purple - Purple & Orange
* To connect green - Green & Purple
*/


/* map the board with coordinates */

valid_moves(+GameState, +Player, -ListOfMoves).
/* to obtain a list of possible moves */

move(+GameState, +Move,-NewGameState).
/* validation and execution of a move, obtaining the new game state */

game_over(+GameState, -Winner).
/* check if the game is over and identify the winner */

value(+GameState, +Player, -Value).
/* Formas de avaliação do estado do jogo
 não sei a utilidade disto :s 
 */

choose_move(+GameState, +Player, +Level, -Move).
/*
move choice to be made by the computer,
depending on the difficulty level
*/