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
