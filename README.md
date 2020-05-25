# Tic Tac TOBOL

This is just a version of Tic Tac Toe in COBOL. It's not a great language for this type of thing but I wanted to learn something 😜  

For instructions on how to build and run this see [How to Play](https://github.com/BasiliusCarver/TicTacTOBOL#how-to-play) at the bottom of the readme.  

I started by reading [this on tutorialspoint.com](https://www.tutorialspoint.com/cobol/) and hacking together bits and pieces 'til it worked, I didn't copy a version of this game from anywhere so it's a bit spaghetti because it was just how I understood the game to work.  

Using a file to define win conditions wasn't a very efficient way to do it but I wanted to do some basic file operations to see how it worked. Using REDEFINE and breaking the functionality into more paragraphs could massively simplify this version.  

Another version of Tic Tac Toe is at this [blog post on torquingwetstrainers](https://torquingwetstrainers.wordpress.com/2010/01/13/tic-tac-toe-cobol/) which is a lot easier to read than mine as it doesn't use a full screen display, colors or a computer opponent.  

You can compile COBOL in freeform with `cobc -free` which relaxes [the old punchcard column enforcement](https://en.wikipedia.org/wiki/Computer_programming_in_the_punched_card_era) so you don't have to start every line with at least 7 spaces to leave room for the punchcard margin but I wrote mine in the old format.  

## Example
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
1. Install a cobol compiler  
`sudo apt install open-cobol`  
2. Compile the COBOL file  
`cobc -W -x -o TicTacTOBOL TicTacTOBOL.cbl`  
3. Run the executable  
`./TicTacTOBOL`  
4. Play the game
