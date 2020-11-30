# TP1 PLOG - Alliances

## Group T2 Alliances_3

| Name                                      | Number    | E-Mail               |
| ----------------------------------------- | --------- | -------------------- |
| Adriana Cruz e Silva da Costa Gonçalves   | 201808911 | up201808911@fe.up.pt |
| José António Dantas Macedo                | 201705226 | up201705226@fe.up.pt |

---
## Installation and Execution
  Put all files with extension '.pl' in the same folder
  Start Sicstus Prolog (or another Prolog development environment compatible with Sicstus and the ISO standard)
  Consult / import the file 'alliances.pl' *<consult (' path / to / file / alliances.pl ')>*
  Call the play/0 function by typing the command 'play.'
  Follow the game instructions

## Game Description
Alliances, a 2-player game by Markus Hagenauer.
<br>
<br>
Alliances is a tricky game that requires you to connect opposite sides of
the board.
<br><br>
*The board has a shape of a 7x7 hexagon without the edges.*
<br>
![](./images/alliances_real.jpg)
<br>
<br>
To connect opposite sides of the board, 
each player must use the color matching the sides and form an
uninterrupted chain of discs between those sides.
<br> <br>
The chain of discs can also be formed by the allied colors, which is different for each player:
<br> <br>
![](./images/allied_colours.png)

### Game Components
1 gameboard, 42 green discs, 42 orange discs, 42 purple discs, 2 silver discs

### Gameplay
Every turn a player takes a disc from the supply and places it on any empty space on the board. <br>
If a connection is made between opposite sides,
with an uninterrupted chain of discs of the sides' color and/or the allied colour,
the player wins the color of the connected sides.
<br>

![](./images/win_board.png)
<br>

### Goal
Win 2 colors. A player wins a color by being the first to connect its two sides on the board or if a move makes it impossible for either player to connect a
particular color (by fencing it off), then the blocked player's opponent wins that color. 

<br>![](./images/win2_board.png)<br>

You can find a more explanation
[here](./pdf/ALLIANCES_EN.pdf)
or find it online: 
<br>
https://nestorgames.com/rulebooks/ALLIANCES_EN.pdf;
<br>
https://boardgamegeek.com/boardgame/302399/alliances;
<br>
*gameplay video:*
https://www.youtube.com/watch?v=VNyHiCfOWhw&feature=emb_logo.

----

# Game Logic:
Program starts by calling the predicate **play/0**, in which the initial menu is displayed calling **display_main_menu/0**.
According to the selected game mode, the predicate that will fill the state of the game will be called (**display_game/2** or **display_game_computer/2** or **display_game_computer_PC_only/2**) .

## Internal representation of the state of the game
<br>

The current state of the game is stored in a list of lists with differents lengths. <br>
The list represents the board, and the lists within that list represents the different rows of the board. <br>
The rows of the board have multiple atoms that represent the discs and the empty spaces of the board. <br>

Atoms meaning:

| Atom | Meaning                         |
| ---- | ------------------------------- |
|  X   | Empty space on the board        |
|  G   | Green Disc                      |
|  P   | Purple Disc                     |
|  O   | Orange Disc                     |

Current Player is represented by the variable 'Player'.
<br><br>
Exemple of representation of game states:
<br>

```
Example of initial board:
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
```

<br>

```
Example of intermediate board:
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
```

<br>

```
Example of final board:
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
```
-----



## Visualizing the game
The predicate of the game state visualization was implemented by calling the predicate **initial** that returns the variable 'Board' with the initial game state (empty board).<br>
Then the predicate **random_select** selects a random player to start and returns the variable 'Player',
the predicate **display_game** is then called with the variables 'Board' and 'Player' and calls the predicate **display_board** that calls several predicates that will write the game state. <br>
Here's an example of the game state visualization:
<br>

*Emply Board of Alliances*
<br>
![Board](./images/board.png)

<br>
*Intermediate Board of Alliances*
<br>
![Board](./images/intermediate_board.png)

<br>
*Final Board of Alliances*
<br>
![Board](./images/final_board.png)

## List of valid plays
After showing the board game, the player can choose a position to play a certain piece, and the predicate **valid_move/6** will check if is valid to place the piece on that position. If it can place the piece there, the predicate **move/5** will be called and will put the chosen piece on the chosen position.

## Computer Play
After calling the predicate **display_game_computer_PC_only/2** or **display_game_computer/2**,
auxiliary functions are used to determine where the pc will play and the predicate **valid_move/6** will validade that move or not.

### Conclusions
In this project we implement the board game Alliances was developed in Prolog language using the development system Sicstus.
It's playable by Human vs Human, PC vs PC and Human vs PC.
The game was quite complex, and due to lack of time and other reasons, the validation of win condition is not fully complete in this delivery.

### Bibliography

[More information about the game Alliances](https://nestorgames.com/rulebooks/ALLIANCES_EN.pdf)

[Buy the board game Alliances](https://boardgamegeek.com/boardgame/302399/alliances)

[Prolog Manual](https://www.swi-prolog.org/pldoc/doc_for?object=manual)


