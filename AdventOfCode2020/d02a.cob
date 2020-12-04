       IDENTIFICATION DIVISION.
       PROGRAM-ID. AOC-2020-02-1.
       AUTHOR. ANNA KOSIERADZKA.
      
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUTFILE ASSIGN TO "d2.input"
           ORGANIZATION IS LINE SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
         FD INPUTFILE
         RECORD IS VARYING IN SIZE FROM 8 to 50
         DEPENDING ON REC-LEN.
         01 INPUTRECORD PIC X(50).
       WORKING-STORAGE SECTION.
         01 FILE-STATUS PIC 9 VALUE 0.
         01 REC-LEN  PIC 9(2) COMP.
         01 WS-MIN PIC 9(4).
         01 WS-MAX PIC 9(4).
         01 WS-CHAR PIC A.
         01 WS-STRING-EMPTY PIC X.
         01 WS-PASSWORD PIC A(50).
         01 WS-SUBSTR-1 PIC X(5). 
         01 WS-CHAR-COUNT PIC 9(2).

       LOCAL-STORAGE SECTION.
         01 CORRECT-ROWS UNSIGNED-INT VALUE 0.

       PROCEDURE DIVISION.
       001-MAIN.
            OPEN INPUT INPUTFILE.
            PERFORM 002-READ UNTIL FILE-STATUS = 1.
            CLOSE INPUTFILE.
            DISPLAY CORRECT-ROWS.
            STOP RUN.

       002-READ.
            READ INPUTFILE
                AT END MOVE 1 TO FILE-STATUS
                NOT AT END PERFORM 003-PROCESS-RECORD
            END-READ.
       
       003-PROCESS-RECORD.
           MOVE 0 TO WS-CHAR-COUNT.
           UNSTRING INPUTRECORD DELIMITED BY SPACE OR "-" OR ":" INTO 
               WS-MIN
               WS-MAX
               WS-CHAR
               WS-STRING-EMPTY
               WS-PASSWORD.
           INSPECT WS-PASSWORD TALLYING WS-CHAR-COUNT FOR ALL WS-CHAR.
           IF WS-CHAR-COUNT >= WS-MIN AND WS-CHAR-COUNT <= WS-MAX THEN 
              ADD 1 TO CORRECT-ROWS
           END-IF.