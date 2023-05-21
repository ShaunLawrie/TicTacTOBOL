# Tic Tac TOBOL
![Example Game](./TicTacTOBOL.gif)
[cool-retro-term](https://github.com/Swordfish90/cool-retro-term) was used for this ^

## Features
 - A terrible opponent that just picks random available squares
 - ASCII graphics

## Future Enhancements
 - Blockchain
 - AI
 - Raytracing
 - Webscale

## How to Play
### Online
Here's a version that kind of works but you have to make all the move choices ahead of time in the STDIN tab. I quickly hacked together a version that works without a real terminal display or file operations so I could run it online http://tpcg.io/28wFoKOu.  
Before you click "execute" paste some input into the STDIN tab e.g.
```
a1
a2
a3
b1
b2
b3
c1
c2
c3
```
### Locally
This one uses a proper terminal display output and looks more like the gif above.  
1. Install a cobol compiler  
`sudo apt install open-cobol`  
2. Compile the COBOL file  
`cobc -W -x -o TicTacTOBOL TicTacTOBOL.cbl`  
3. Run the executable  
`./TicTacTOBOL`  
4. Play the game
