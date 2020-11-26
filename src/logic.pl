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

getRow(1, [H|_], Row).
getRow(RowIndex, [_|T], Row):-
    getRow(RowIndex2, T, Row), RowIndex is RowIndex2 + 1.

getSpace(1, [H|_], Space).
getSpace(SpaceIndex, [_|T], Space):-
    getRow(SpaceIndex2, T, Space), SpaceIndex is SpaceIndex2 + 1.

/* replace(+Elem, +NewElem, +List, -NewList) */
/*replace(_,_,[],[]) :- !.
*replace(Elem,NewElem,[Elem|List],[NewElem|New]): !,
*    replace(Elem,NewElem,List,New).
*/replace(Elem,NewElem,[X|List],[X|New]) :- replace(Elem,NewElem,List,New).

/*check if the row and space is an X - empty space*/
valid_move(RowIndex, SpaceIndex, Board, Space, Player):-
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space == 'X'.

valid_move(RowIndex, SpaceIndex, Board, Space, Player):-
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space /= 'X',
    write('Invalid move'),
    display_game(Board, Player).


replace_space([],_,_,_,_).
replace_space([Space|Rest], [NewSpace|NewRest], SpaceIndex, CurrrentSpaceIndex, Color):-
    SpaceIndex /= CurrrentSpaceIndex,
    nth1(CurrrentSpaceIndex, NewSpace, Space, NewRest),
    replace_space(Rest, NewRest, SpaceIndex, CurrrentSpaceIndex2, Color),
    CurrrentSpaceIndex is CurrrentSpaceIndex2 + 1.

replace_space([Space|Rest], [NewSpace|NewRest], SpaceIndex, CurrrentSpaceIndex, Color):-
    SpaceIndex == CurrrentSpaceIndex,
    nth1(CurrrentSpaceIndex, NewSpace, Color, NewRest),
    replace_space(Rest, NewRest, SpaceIndex, CurrrentSpaceIndex2, Color),
    CurrrentSpaceIndex is CurrrentSpaceIndex2 + 1.


replace_row([], _ , _, _, _).
replace_row([Row|Rest], [NewRow|NewRest], SpaceIndex, CurrentRowIndex, Color):-
    replace_space(Row, NewRow, SpaceIndex, 1, Color),
    replace_row(Rest,NewRest, SpaceIndex, CurrentRowIndex2, Color),
    CurrentRowIndex is CurrentRowIndex2 + 1.


move(RowIndex, SpaceIndex, Color, Board, NewBoard):-
    /*updates board*/
    replace_row(Board, NewBoard, RowIndex, 1, Color).

    


check_for_win(Board, Player):-
    /*checks if there is a connection, if so, call game_over to identify winner and display game over menu*/
    

/*Takes the Player and switches to the other one*/
switch_player(Player):-
    Player == 1,
    Player is 2.

switch_player(Player):-
    Player == 2,
    Player is 1.


/*____________________________________________________*/
valid_moves(+GameState, +Player, -ListOfMoves).
/* to obtain a list of possible moves */

move(+GameState, +Move,-NewGameState).
/* validation and execution of a move, obtaining the new game state */

/* check if the game is over and identify the winner */
game_over(+GameState, -Winner):-
    check_game_over(Board),
    display_board(Board).

value(+GameState, +Player, -Value).
/* Formas de avaliação do estado do jogo
 não sei a utilidade disto :s 
 */

choose_move(+GameState, +Player, +Level, -Move).
/*
move choice to be made by the computer,
depending on the difficulty level
*/