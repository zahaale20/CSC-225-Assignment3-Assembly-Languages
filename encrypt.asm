; Encrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Spring '22

            .ORIG x3000
            
            ; Prompt for the key.
            LEA R0, KEY_PROMPT  ; Load the prompt.
            PUTS                ; Print the prompt.
            GETC                ; Get encryption key(0-9)
            ADD R3, R0, #0      ; Add encryption key to R3
            OUT
            ADD R3, R3, #-16 ; SUBTRACT -48 CAUSE YOU HAVE TO
            ADD R3, R3, #-16
            ADD R3, R3, #-16

            ; TODO: Read the encryption key from the keyboard, echo it, and
            ;       convert it into an integer. Save the encryption key in R3.

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

            ; TODO: Apply the encryption key, which is in R5, to the character,
            ;       which is in R0. Replace unprintable characters with '?'.
            ADD R0, R0, R3 ; ADD ENCRYPTION KEY FROM R3
            
HERE        STR R0, R2, #0      ; STORE R0 into address of R2
            ADD R2, R2, #1      ; ...increment the address...
            BRnzp LOOP          ; ...loop back.

            ; Print the result.
DONE        AND R4, R4, #0      ; Get the null char.
            STR R4, R2, #0      ; Store the null char.
            LEA R0, RES_PROMPT  ; Load the prompt.
            PUTS                ; Print the prompt.
            LEA R0, STRING      ; Load the string.
            PUTS                ; Print the string.
            HALT                ; Halt.
            
QUES        AND R0, R0, #0
            ADD R0, R0, #15     ; load '?' to R0 (63 -> 0x003f)
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #15
            ADD R0, R0, #3
            BRnzp HERE
            

            ; TODO: Add any additional required constants below this point.

NEW_OFFSET  .FILL x-0A
KEY_PROMPT  .STRINGZ "Encryption key (0-9): "
STR_PROMPT  .STRINGZ "\nUnencrypted string: "
RES_PROMPT  .STRINGZ "Encrypted string: "
STRING      .BLKW #33

FIRST       .FILL xFFBF ; -65 A
            .END
