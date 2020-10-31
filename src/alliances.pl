/*In this file we'll call the functions to:
* start the game
* show the start menu
* call the gameplay functions
* call the end game menu display 
*/

:- consult('display.pl').
:- consult('logic.pl').
:- use_module(library(system)).


/* Starts the game and displays start menu.
*  Also reads option the player selects.
*/
play:- 
    display_main_menu,
    read(Option),
    /*valid_option(Option).*/
    option_is_valid(Option).


/* Validates the player's chosen option*/
/*valid_option(Option):-
    
    option_is_valid(Option)
    ;
    write('Invalid option. Please try again. ').*/


/*Go back option*/
option_is_valid(0):-
    play.

/* 2 players option*/
option_is_valid(1):-
    initial_board(Board),
    display_game(Board).
    

/* 1 player vs. PC option*/
option_is_valid(2):-
    display_not_yet_implemented,
    read(Option),
    /*valid_option(Option).*/
    option_is_valid(Option).

/* Exit option */
option_is_valid(3):-
    write('Exiting game...\n').