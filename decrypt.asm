; decrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Spring '22

            .ORIG x3000
            
            ; Prompt for the key.
            AND R3, R3, #0

            ; TODO: Read the decryption key from the keyboard, echo it, and
            ;       convert it into an integer. Save the decryption key in R3.

            ; Prompt for the string.
            LEA R0, STR_PROMPT  ; Load the prompt.
            LD  R1, NEW_OFFSET  ; Load a "negative newline" into R1.
            LEA R2, STRING      ; Load the address of the string into R2.
            PUTS                ; Print the prompt.

            ; Get and encrypt the string.
LOOP        GETC                ; While the user types characters...
            OUT                 ; ...echo the character...
            LD  R1, NEW_OFFSET  ; Load a "negative newline" into R1.
            ADD R4, R0, R1      ; ...and the character...
            BRz DONE            ; ...is not the newline...

            ; TODO: Apply the decryption key, which is in R5, to the character,
            ;       which is in R0. Replace unprintable characters with '?'.
            ADD R0, R0, R3 ; ADD deCRYPTION KEY FROM R3 into R0
            STR R0, R2, #0      ; STORE R0 into address of R2
            ADD R2, R2, #1      ; ...increment the address...
            BRnzp LOOP          ; ...loop back.

            ; Print the result.
DONE        AND R4, R4, #0      ; Get the null char.
            STR R4, R2, #0      ; Store the null char.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, COUNTER
            PUTS
            LEA R0, RES0  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, STRING      ; Load the string.
            PUTS                ; Print the string.
            LEA R0, NL
            PUTS
            
            ADD R3, R3, #1      ; increment decryption key
            AND R4, R4, #0      ; counter = 0
            
LOOP2       ADD R4, R4, #-9
            BRp HUCK
            ADD R4, R4, #9
            ADD R4, R4, #1      ; increment counter
            LD R0, COUNTER
            LEA R2, COUNTER
            ADD R0, R0, #1
            STR R0, R2, #0
            
            LD R0, STRING
            BRz FINN
            LEA R2, STRING
LOOP1       ADD R0, R0, #1
            STR R0, R2, #0
            ADD R2, R2, #1
            BRnzp LOOP1
            
FINN        LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, COUNTER
            PUTS
            LEA R0, RES0  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, STRING      ; Load the string.
            PUTS                ; Print the string.
            BRnzp LOOP2
            
HUCK        HALT                ; Halt.
            

            ; TODO: Add any additional required constants below this point.
COUNTER     .STRINGZ "0"
NEW_OFFSET  .FILL x-0A
STR_PROMPT  .STRINGZ "\nEncrypted string: "
RES_PROMPT  .STRINGZ "Decryption key "
RES0        .STRINGZ ": "
NL          .STRINGZ "\n"
STRING      .BLKW #33

FIRST       .FILL xFFBF ; -65 A
            .END
