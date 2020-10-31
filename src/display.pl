/* In this file we'll:
* create the display functions for displaying the menus (start menu, end menu)
* create the functions to display the board
* create the funtions to change the display of the board as the players are playing
*/
:-use_module(library(lists)).

/* Display Main Menu */
display_main_menu:-
    write('-----------------------------------\n'),
    write('-----       Alliances         -----\n'),
    write('-----                         -----\n'),
    write('-----     1: Human / Human    -----\n'),
    write('-----     2: Human / PC       -----\n'),
    write('-----     3: PC / PC          -----\n'),
    write('-----     4: Exit             -----\n'),
    write('-----                         -----\n'),
    write('-----------------------------------\n').

/* Display Not Available Yet Menu */
display_not_yet_implemented:-
    write('-----------------------------------\n'),
    write('-----       Alliances         -----\n'),
    write('-----                         -----\n'),
    write('-----     This option is not  -----\n'),
    write('-----     available yet.      -----\n'),
    write('-----                         -----\n'),
    write('-----     0: Go back          -----\n'),
    write('-----     4: Exit             -----\n'),
    write('-----------------------------------\n').

/*
* Size of rows, from the top down: 5, 8, 9, 10, 11, 12, 11, 12, 11, 10, 9, 8, 5
*/
initial([
    [X,X,X,X,X],
    [X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X,X],
    [X,X,X,X,X,X,X,X],
    [X,X,X,X,X]
]).

/*Example of intermediate board*/
intermediate_board([
    [X,X,O,X,X],
    [X,X,X,O,X,X,X,X],
    [X,X,X,X,P,X,X,X,X],
    [X,X,X,X,P,X,X,X,X,X],
    [X,X,X,X,X,O,X,X,X,X,X],
    [X,X,X,X,X,O,X,X,X,X,X,X],
    [X,X,X,X,X,O,X,X,X,X,X],
    [X,X,X,X,G,X,X,X,X,X,X,X],
    [X,X,X,X,X,G,X,X,X,X,X],
    [X,X,X,X,O,G,X,X,X,X],
    [X,X,X,X,G,O,X,X,X],
    [X,X,X,X,O,X,X,X],
    [X,X,O,X,X]
]).

/* Example of final board - In this case the player on the top completes the path with orange and purple colors first*/
final_board([
    [X,X,O,X,X],
    [X,X,X,O,X,X,X,X],
    [X,X,X,X,P,O,X,X,X],
    [X,X,X,X,P,O,X,X,X,X],
    [X,X,X,X,X,O,X,X,X,X,X],
    [X,X,X,X,X,O,X,X,X,X,X,X],
    [X,X,X,X,P,O,X,X,X,X,X],
    [X,X,X,P,G,X,X,X,X,X,X,X],
    [X,X,X,X,P,G,X,X,X,X,X],
    [X,X,X,X,O,G,X,X,X,X],
    [X,X,X,X,G,O,X,X,X],
    [X,X,X,X,O,X,X,X],
    [X,X,O,X,X]
]).


display_game(Board, Player):-
    display_board(Board),
    write('Choose an option (G, P, O): ').
    /* need to read chosen option, update board,
    *  switch player and loop to display_game with updated Board and updated Player :)
    */


display_board(Board):-
    write('\n\n\n\n'),
    write('       |OOOOO|       \n'),
    display_current_board_colors(Board, 0),
    write('       |OOOOO|       \n'),
    write('______________________\n'),
    write('G - Green\n'),
    write('P - Purple\n'),
    write('O - Orange\n').


/* The ! mark prevents backtracking - when the board is empty goes to previous function */
display_current_board_colors([], _ ):- !.

/* Iterates over the board to get the row and displays it */
display_current_board_colors([Row | OtherRows], RowIndex):-
    /*nth0(RowIndex, Board, Row),*/
    display_board_structure1(RowIndex),
    display_color(Row, RowIndex),
    display_board_structure2(RowIndex),
    NextRowIndex is RowIndex + 1,
    display_current_board_colors(OtherRows, NextRowIndex).

/* The ! mark prevents backtracking - when the row is empty goes to previous function */
display_color([], _ ):- !. 

/* Displays the color, or white space, in every position of a certain row*/
display_color([Color | RestRow], ColorIndex):-
    /*nth0(ColorIndex, Row, Color),*/
    write_color(Color),
    NextColorIndex is ColorIndex + 1,
    display_color(RestRow, NextColorIndex).

/* Write white space if that position in the board is unoccupied*/
write_color('X'):-
    write('X').

/*Writes the Green symbol*/
write_color('G'):-
    write('G').

/*Writes the Purple symbol*/
write_color('P'):-
    write('P').

/*Writes the Orange symbol*/
write_color('O'):-
    write('O').


/*Board structure fillers to make the board look like the real game - because the board is an hexagon and has a different structure depending on the row*/ 
display_board_structure1(0):-
    write('       |').

display_board_structure2(0):-
    write('|       \n').

display_board_structure1(1):-
    write('GGGG|').

display_board_structure2(1):-
    write('|PPPP\n').

display_board_structure1(2):-
    write('GGG|').

display_board_structure2(2):-
    write('|PPP\n').

display_board_structure1(3):-
    write('GG|').

display_board_structure2(3):-
    write('|PP\n').

display_board_structure1(4):-
    write('G|').

display_board_structure2(4):-
    write('|P\n').

display_board_structure1(5):-
    write('|').

display_board_structure2(5):-
    write('|\n').

display_board_structure1(6):-
    write(' |').

display_board_structure2(6):-
    write('| \n').

display_board_structure1(7):-
    write('|').

display_board_structure2(7):-
    write('|\n').

display_board_structure1(8):-
    write('P|').

display_board_structure2(8):-
    write('|G\n').

display_board_structure1(9):-
    write('PP|').

display_board_structure2(9):-
    write('|GG\n').

display_board_structure1(10):-
    write('PPP|').

display_board_structure2(10):-
    write('|GGG\n').

display_board_structure1(11):-
    write('PPPP|').

display_board_structure2(11):-
    write('|GGGG\n').

display_board_structure1(12):-
    write('       |').

display_board_structure2(12):-
    write('|       \n').
