# TP1 PLOG - Alliances

## Group T2 Alliances_3

| Name                                      | Number    | E-Mail               |
| ----------------------------------------- | --------- | -------------------- |
| Adriana Cruz e Silva da Costa Gonçalves   | 201808911 | up201808911@fe.up.pt |
| José António Dantas Macedo                | 201705226 | up201705226@fe.up.pt |

---

## Game Description
Alliances, a 2-player game by Markus Hagenauer.
<br>
<br>
Alliances is a tricky game requires you to connect opposite sides of
the board.
<br>
To connect opposite sides of the board, 
each player must use the colour matching the sides and form an
uninterrupted chain of discs between those sides.
<br>
The chain of discs can also be formed by the allied colours, which is different for each player:
![](./images/allied_colours.png)

<br>
### Gameplay
Every turn a player take a disc from the supply and place it on any empty space on the board. <br>
If a connection is made between opposite sides,
with an uninterrupted chain of discs of the sides colour and/or the allied colour,
the player wins the colour of the connected sides.

### Goal
Win 2 colours. A player win a colour by being the first to connect its to sides of the board.

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
<br>

![Board](./images/board.png)
<br>
*Fig. 1: Board of Alliances*

<br>
<br>

----
## Internal representation of the state of the game
<br>

The board is represented by a list of lists with differents lengths. To exemplify, it was created 3 boards:
an [initial board](./boards/InitialBoard.pl), 
an [intermediate board](./boards/InterBoard.pl)
and a [final board](./boards/finalBoard.pl). 
The first list describes the state of the game: the number of discs in the Gain and Risk areas of both players, and the number of discs that the players have. The rest of the lists describes the board. They vary in size.

To represent the discs and the differents spaces of the board, several atoms where used. The following table makes the correspondence between the atoms and their meaning:

| Atom | Meaning                         |
| ---- | ------------------------------- |
|  X   | Empty space on the board        |
|  G   | Green Disc                      |
|  P   | Purple Disc                     |
|  O   | Orange Disc                     |

<br>
-----
## Visualizing the game


<br>
<br>
