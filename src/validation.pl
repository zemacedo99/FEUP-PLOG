
/**
 * validate_row(+Board , +Row)
 * 
 * Succeeds if the row corresponds to a board row.
 */
validate_row(Board,Row):-
    length(Board,Check),
    Check < Row,
    write('Invalid Row! Try again..\n\n').

/**
 * validate_column(+Row, +SpaceIndex)
 * 
 * Succeeds if the SpaceIndex is in the row
 */
validate_column(Row,SpaceIndex):-
    length(Row,Check),
    Check < SpaceIndex,
    write('Invalid Column! Try again..\n\n').


valid_move(RowIndex, SpaceIndex, Board, Space, Player, Mode):-
    Mode == 'HumanOnly',
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space == 'X'.

valid_move(RowIndex, SpaceIndex, Board, Space, Player, Mode):-
    Mode == 'HumanOnly',
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space /= 'X',
    write('\nInvalid move\n'),
    display_game(Board, Player).

valid_move(RowIndex, SpaceIndex, Board, Space, Player, Mode):-
    Mode == 'HumanPC',
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space == 'X'.

valid_move(RowIndex, SpaceIndex, Board, Space, Player, Mode):-
    Mode == 'HumanPC',
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space /= 'X',
    write('\nInvalid move\n'),
    display_game_computer(Board, Player).

valid_move(RowIndex, SpaceIndex, Board, Space, Player, 'PConly'):-
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space == 'X'.

valid_move(RowIndex, SpaceIndex, Board, Space, Player, 'PConly'):-
    getRow(RowIndex, Board, Row),
    getSpace(SpaceIndex, Row, Space),
    Space /= 'X',
    write('\nInvalid move\n'),
    display_game_computer_PC_only(Board, Player).

