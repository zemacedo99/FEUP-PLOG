/*In this file we'll call the functions to:
* start the game
* show the start menu
* call the gameplay functions
* call the end game menu display 
*/

:- consult('display.pl').
:- consult('logic.pl').
:- use_module(library(system)).
:- use_module(library(random)).


/* Starts the game and displays start menu.
*  Also reads option the player selects.
*/
play:- 
    /*repeat,*/
    display_main_menu,
    read(Option),
    /*valid_option(Option).*/
    option_is_valid(Option).


/* Validates the player's chosen option*/
/* This validation function is commented because it's failing sometimes

valid_option(Option):-
    (\+ num(Option)) ->
    write('Invalid option. Please try again. \n\n '),
    fail
    ;
    option_is_valid(Option).
*/


/*Go back option*/
option_is_valid(0):-
    play.

/* Human vs Human option*/
option_is_valid(1):-
    initial(Board),
    random_select(Player, [1, 2], _),
    display_game(Board, Player).
    

/* Human vs. PC option*/
option_is_valid(2):-
    display_not_yet_implemented,
    read(Option),
    /*valid_option(Option).*/
    option_is_valid(Option).

/* PC vs. PC option*/
option_is_valid(3):-
    display_not_yet_implemented,
    read(Option),
    /*valid_option(Option).*/
    option_is_valid(Option).

/* Exit option */
option_is_valid(4):-
    write('Exiting game...\n').