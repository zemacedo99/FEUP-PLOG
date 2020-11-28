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

getRow(1, [Row|_], Row).
getRow(RowIndex, [_|T], Row):-
    getRow(RowIndex2, T, Row), RowIndex is RowIndex2 + 1.

getSpace(1, [Space|_], Space).
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


replace_row(1, SpaceIndex, Color, [Row | Rest], [New_row | Rest]):-
    replace_space(SpaceIndex, Color, Row, New_row).

replace_row(N, SpaceIndex, Color, [Row | Rest], [Row | New_rest]):-
    N > 1,
    Next is N - 1,
    replace_row(Next, SpaceIndex, Color , Rest, New_rest).

replace_space(1, Color, [_ | Rest], [Color | Rest]).

replace_space(N, Color, [X | Rest], [X | New_rest]):-
    N > 1,
    Next is N - 1,
    replace_space(Next, Color , Rest, New_rest).


move(RowIndex, SpaceIndex, Color, Board, NewBoard):-
    /*updates board*/
    replace_row(RowIndex, SpaceIndex, Color, Board, NewBoard).
    /*podemos  é aqui que vamos chamar aqui o check_for_win*/
    /* acho que o move talvez possa de receber um player tb para sabermos de quem foi a jogada e mandar ao check for win*/



check_for_win(Board, Player):-
    check_orange_win(Board,Player). % verificação da ligação laranja-laranja
    /*checks if there is a connection, if so, call game_over to identify winner and display game over menu*/
    
check_orange_win(Board,Player):-
    check_row(0,Board,ListOfColors),   % verifica a primeira linha
    check_normal_row(1,Board,ListOfColors),      % verificação das linhas normais
    check_row(12,Board,ListOfColors),   % verifica a ultima linha
    check_complete_path(ListOfColors).  % verificação de casos expeciais 
    

/*check if the row have the color, in the case orange*/
check_row(RowIndex,Board,ListOfColors):-        % ListOfColors -> [RowIndex-SpaceIndex,RowIndex-SpaceIndex,etc]
    getRow(RowIndex,Board,Row).
    /* se a Row nao tiver a cor de laranja nao é um caso de vitória e deve terminar*/
    /* se tiver, guardar a posição (rowIndex e spaceIndex ) onde esta(o) a(s) peça(s) cor de laranja numa lista ListOfColors*/
    /* */

check_normal_row(NormalRowIndex,Board,ListOfColors):-
    check_row(NormalRowIndex,Board,NewListOfColors),
    /* se na ListOfColors nao tiver cores na Row anterior nao é um caso de vitória e deve terminar*/
    /* se tiver,
        compara a NewListOfColor com a ListOfColors recebida e ve se as a SpaceIndex da ListaOfColors == SpaceIndex da NewListOfColors e ListaOfColors ==  SpaceIndex-1 da NewListOfColors
        se true faz apend da NewListOfColors com a listofcolors se nao termina
    */
    /*o caso do SpaceIndex == 0  ou SpaceIndex == NewListOfColors.length, ve de maneira difernte */
    NormalRowIndex == 11, % terminar a recrusividade 
    NextRowIndex is NormalRowIndex + 1, 
    check_normal_row(NextRowIndex,Board,NewListOfColors).


/*Takes the Player and switches to the other one*/
switch_player(1, NewPlayer):-
    NewPlayer == 2.
    
switch_player(2, NewPlayer):-
    NewPlayer == 1.


next_player(Player, NewPlayer):-
    switch_player(Player, NewPlayer).


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