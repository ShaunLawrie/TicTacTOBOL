       IDENTIFICATION DIVISION.
       PROGRAM-ID. TIC-TAC-TOBOL.
       
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT FD-WINMASKS ASSIGN TO "SMACK.DAT"
                       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
               FD FD-WINMASKS.
                   01 FD-WINMASK PIC X(9).

           WORKING-STORAGE SECTION.
      *        Strings with conditions
               01 WS-PLAYER PIC A(1).
                   88 HUMAN-PLAYER VALUE "X".
                   88 COMPUTER-PLAYER VALUE "O".
               01 WS-STATE PIC A(5).
                   88 GAME-OVER VALUES "WIN", "LOSE", "STALE".
               01 WS-MOVE-OUTCOME PIC A(5).
                   88 MOVE-COMPLETE VALUES "WIN", "LOSE", "FAIL".
      *        Numbers with conditions
               01 WS-MASK-DETECTED PIC 9(1).
                   88 WIN-DETECTED VALUES 3, 4, 5, 6, 7, 8, 9.
               01 WS-COMPUTER-MOVED PIC 9(1).
                   88 COMPUTER-MOVED VALUE 1.
               01 WS-EOF PIC 9(1).
                   88 EOF VALUE 1.
               01 WS-SWAP-PLAYERS PIC 9(1).
                   88 SWAP-PLAYERS VALUE 1.
      *        Alphanumerixxx
               01 WS-NEXT-MOVE PIC X(2).
                   88 FINISHED-PLAYING VALUES "N", "n".
      *        The main game grid
               01 WS-GAME-GRID.
                   05 WS-GAME-GRID-ROW OCCURS 3 TIMES.
                       10 WS-GAME-GRID-COL OCCURS 3 TIMES.
                           15 WS-CELL PIC X(1).
      *        Constants
               01 WS-COLOR-GREEN PIC 9(1) VALUE 2.
               01 WS-COLOR-BLACK PIC 9(1) VALUE 0.
               01 WS-COLOR-WHITE PIC 9(1) VALUE 7.
               01 WS-COLOR-BLUE PIC 9(1) VALUE 3.
               01 WS-COLOR-RED PIC 9(1) VALUE 4.
      *        Numerixxx
               01 WS-FG-CELL PIC 9(1).
               01 WS-FG PIC 9(1).
               01 WS-BG PIC 9(1).
               01 WS-COL PIC 9(1).
               01 WS-ROW PIC 9(1).
               01 WS-WINS PIC 9(2).
               01 WS-MOVES PIC 9(2).
               01 WS-GAMES PIC 9(2).
               01 WS-COMPUTER-MOVE PIC 9(1).
               01 WS-DETECT-LOOP-COUNT PIC 9(1).
      *        Stringy bois        
               01 WS-MESSAGE PIC X(128).
               01 WS-INSTRUCTION PIC X(16).
               01 WS-FLAT-GAME-GRID PIC X(9).

           SCREEN SECTION.
           01 BOARD-SCREEN.
               05 BLANK SCREEN
                   BACKGROUND-COLOR WS-COLOR-BLACK
                   FOREGROUND-COLOR WS-COLOR-WHITE.
               05 LINE 1 COLUMN 1 VALUE IS "   +---+---+---+   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 2 COLUMN 1 VALUE IS " A |   |   |   |   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 3 COLUMN 1 VALUE IS "   +---+---+---+   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 4 COLUMN 1 VALUE IS " B |   |   |   |   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 5 COLUMN 1 VALUE IS "   +---+---+---+   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 6 COLUMN 1 VALUE IS " C |   |   |   |   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 7 COLUMN 1 VALUE IS "   +---+---+---+   "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 8 COLUMN 1 VALUE IS "     1   2   3     "
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG.
               05 LINE 2 COLUMN 6 PIC A(1) FROM WS-CELL(1,1)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 2 COLUMN 10 PIC A(1) FROM WS-CELL(1,2)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 2 COLUMN 14 PIC A(1) FROM WS-CELL(1,3)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 4 COLUMN 6 PIC A(1) FROM WS-CELL(2,1)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 4 COLUMN 10 PIC A(1) FROM WS-CELL(2,2)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 4 COLUMN 14 PIC A(1) FROM WS-CELL(2,3)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 6 COLUMN 6 PIC A(1) FROM WS-CELL(3,1)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 6 COLUMN 10 PIC A(1) FROM WS-CELL(3,2)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 6 COLUMN 14 PIC A(1) FROM WS-CELL(3,3)
                   BACKGROUND-COLOR WS-BG FOREGROUND-COLOR WS-FG-CELL.
               05 LINE 10 COLUMN 2 VALUE IS "Message: ".
                   05 MSG PIC X(128) FROM WS-MESSAGE.
               05 LINE 11 COLUMN 2 PIC X(16) FROM WS-INSTRUCTION.
                   05 NEXT-MOVE PIC X(2) USING WS-NEXT-MOVE.
               05 LINE 13 COLUMN 2 VALUE IS "Stats: ".
               05 LINE 14 COLUMN 2 VALUE IS " > Moves played = ".
                   05 MOVES PIC 9(1) FROM WS-MOVES.
               05 LINE 15 COLUMN 2 VALUE IS " > Games won = ".
                   05 WINS PIC 9(2) FROM WS-WINS.
               05 LINE 15 COLUMN 19 VALUE IS "/".
                   05 GAMES PIC 9(2) FROM WS-GAMES.

       PROCEDURE DIVISION.
           MOVE "X" TO WS-PLAYER
           PERFORM GAME-LOOP-PARAGRAPH
               WITH TEST AFTER UNTIL FINISHED-PLAYING
           STOP RUN.

           GAME-LOOP-PARAGRAPH.
               INITIALIZE WS-GAME-GRID
               INITIALIZE WS-STATE
               INITIALIZE WS-MOVES
               MOVE "Make a move like 'A2'" TO WS-MESSAGE
               PERFORM GAME-FRAME-PARAGRAPH
                   WITH TEST AFTER UNTIL GAME-OVER
               ADD 1 TO WS-GAMES END-ADD
               EVALUATE WS-STATE
               WHEN "WIN"
                   ADD 1 TO WS-WINS END-ADD
                   MOVE WS-COLOR-BLACK TO WS-FG
                   MOVE WS-COLOR-BLACK TO WS-FG-CELL
                   MOVE WS-COLOR-GREEN TO WS-BG
               WHEN "STALE"
                   MOVE WS-COLOR-BLACK TO WS-FG
                   MOVE WS-COLOR-BLACK TO WS-FG-CELL
                   MOVE WS-COLOR-BLUE TO WS-BG
               WHEN OTHER
                   MOVE WS-COLOR-BLACK TO WS-FG
                   MOVE WS-COLOR-BLACK TO WS-FG-CELL
                   MOVE WS-COLOR-RED TO WS-BG
               END-EVALUATE
               MOVE "One more (y/n)? " TO WS-INSTRUCTION
               MOVE "y" TO WS-NEXT-MOVE
               DISPLAY BOARD-SCREEN END-DISPLAY
               ACCEPT BOARD-SCREEN END-ACCEPT
           .

           GAME-FRAME-PARAGRAPH.
               MOVE "Move to square: " TO WS-INSTRUCTION
               MOVE WS-COLOR-GREEN TO WS-FG
               MOVE WS-COLOR-WHITE TO WS-FG-CELL
               MOVE WS-COLOR-BLACK TO WS-BG
               INITIALIZE WS-MOVE-OUTCOME
               
               IF COMPUTER-PLAYER
      *            Generate some bullshit move for the computer
                   INITIALIZE WS-COMPUTER-MOVED
                   PERFORM UNTIL COMPUTER-MOVED
                       COMPUTE WS-ROW = FUNCTION RANDOM * 3 + 1
                       END-COMPUTE
                       COMPUTE WS-COL = FUNCTION RANDOM * 3 + 1
                       END-COMPUTE
                       IF WS-CELL(WS-ROW,WS-COL) IS EQUAL TO " "
                       THEN
                           SET WS-COMPUTER-MOVED TO 1
                           MOVE WS-PLAYER TO WS-CELL(WS-ROW,WS-COL)
                       END-IF
                   END-PERFORM
               ELSE
      *            Prompt for input from the user
                   INITIALIZE WS-NEXT-MOVE
                   DISPLAY BOARD-SCREEN END-DISPLAY
                   ACCEPT BOARD-SCREEN END-ACCEPT
    
      *            Crappily parse the user input
                   EVALUATE FUNCTION UPPER-CASE(WS-NEXT-MOVE(1:1))
                       WHEN "A" SET WS-ROW TO 1
                       WHEN "B" SET WS-ROW TO 2
                       WHEN "C" SET WS-ROW TO 3
                       WHEN OTHER MOVE "FAIL" TO WS-MOVE-OUTCOME
                   END-EVALUATE
                   SET WS-COL TO WS-NEXT-MOVE(2:1)

      *            Check move is a valid square
                   IF
                       WS-MOVE-OUTCOME IS NOT EQUAL TO "FAIL"
                       AND WS-COL IS GREATER THAN 0
                       AND WS-COL IS LESS THAN 4
                       AND WS-CELL(WS-ROW,WS-COL) = " "
                   THEN
                       MOVE WS-PLAYER TO WS-CELL(WS-ROW,WS-COL)
                   ELSE
                       MOVE "FAIL" TO WS-MOVE-OUTCOME
                   END-IF
               END-IF
               
      *        Convert the grid to the same format as the winmask
               MOVE WS-GAME-GRID TO WS-FLAT-GAME-GRID
               IF HUMAN-PLAYER
                   INSPECT WS-FLAT-GAME-GRID REPLACING ALL "X" BY "1"
                   INSPECT WS-FLAT-GAME-GRID REPLACING ALL "O" BY "0"
               ELSE
                   INSPECT WS-FLAT-GAME-GRID REPLACING ALL "X" BY "0"
                   INSPECT WS-FLAT-GAME-GRID REPLACING ALL "O" BY "1"
               END-IF
               INSPECT WS-FLAT-GAME-GRID REPLACING ALL " " BY "0"
               
      *        Check for winning condition
               INITIALIZE WS-EOF
               OPEN INPUT FD-WINMASKS
               PERFORM UNTIL EOF OR MOVE-COMPLETE
                   READ FD-WINMASKS NEXT RECORD
                       AT END
                           SET WS-EOF TO 1
                       NOT AT END
                           PERFORM VALIDATE-WIN-PARAGRAPH
                   END-READ
               END-PERFORM
               CLOSE FD-WINMASKS

      *        Must be stalemaaaaaaaate
               IF NOT MOVE-COMPLETE AND WS-MOVES IS EQUAL TO 8
                   MOVE "STALE" TO WS-MOVE-OUTCOME
               END-IF
                
      *        Handle the result
               INITIALIZE WS-SWAP-PLAYERS
               EVALUATE WS-MOVE-OUTCOME
               WHEN "WIN"
                   MOVE "WINNER! (^_^)" TO WS-MESSAGE
                   MOVE "WIN" TO WS-STATE
                   SET WS-SWAP-PLAYERS TO 1
               WHEN "LOSE"
                   MOVE "YOU DIED (x_x)" TO WS-MESSAGE
                   MOVE "LOSE" TO WS-STATE
                   SET WS-SWAP-PLAYERS TO 1
               WHEN "STALE"
                   MOVE "Stalemate! (>_<)" TO WS-MESSAGE
                   MOVE "STALE" TO WS-STATE
               WHEN "FAIL"
                   MOVE "Invalid move... (o_O)" TO WS-MESSAGE
               WHEN OTHER
                   MOVE "Enter a move" TO WS-MESSAGE
                   SET WS-SWAP-PLAYERS TO 1
                   ADD 1 TO WS-MOVES END-ADD
               END-EVALUATE

      *        Swap whose turn it is if the move was valid
               IF SWAP-PLAYERS
                   IF HUMAN-PLAYER
                       MOVE "O" TO WS-PLAYER
                   ELSE
                       MOVE "X" TO WS-PLAYER
                   END-IF
               END-IF
           .

           VALIDATE-WIN-PARAGRAPH.
               INITIALIZE WS-MASK-DETECTED
               SET WS-DETECT-LOOP-COUNT TO 1
               PERFORM 9 TIMES
                   IF
                       FD-WINMASK(WS-DETECT-LOOP-COUNT:1)
                       IS EQUAL TO
                       WS-FLAT-GAME-GRID(WS-DETECT-LOOP-COUNT:1)
                       AND IS EQUAL TO 1
                   THEN
                       ADD 1 TO WS-MASK-DETECTED END-ADD
                   END-IF
                   ADD 1 TO WS-DETECT-LOOP-COUNT END-ADD
               END-PERFORM
               IF WIN-DETECTED
                   IF HUMAN-PLAYER
                       MOVE "WIN" TO WS-MOVE-OUTCOME
                   ELSE
                       MOVE "LOSE" TO WS-MOVE-OUTCOME
                   END-IF
               END-IF
           .
