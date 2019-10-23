/******************************************************************************
* File: sub_string.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
Given two strings, check whether the second string is a substring of the First
one. The starting addresses of two strings are defined by the **STRING** and
**SUBSTR** variables, respectively. If the string defined by SUBSTR is not
present in the string defined by **STRING**, clear the **PRESENT** variable;
else set the variable with the position of the First occurrence of the
second string in the First string.

*/
  @BSS SECTION
  .bss
    PRESENT: .word 0          @ will hold array length 

  @ DATA SECTION
  .data
	STRING:  .asciiz "CS66206679"
	SUBSTR:  .asciiz "66"
	
  @ TEXT section
  .text

.globl _main
  
_main:

    LDR R0, =STRING
    MOV R1, #0    

STRLEN_LOOP:                ; Calculate string length
    LDRB R2, [R0], #1
    CMP R2,#0
    BEQ EXIT_STRLEN 
    ADD R1, R1, #1
    B STRLEN_LOOP

EXIT_STRLEN:
    LDR R0, =SUBSTR
    MOV R3, #0    

SUB_STRLEN_LOOP:            ; Calculate substring length
    LDRB R2, [R0], #1
    CMP R2,#0
    BEQ EXIT_SUB_STRLEN 
    ADD R3, R3, #1
    B SUB_STRLEN_LOOP

EXIT_SUB_STRLEN:
    LDR R0, =STRING
    MOV R6, #0

OUTER_MATCH:                      ; loop through string and if first char of substring matches any of the char in string, compare remaining characters
            LDR R2, =SUBSTR
            LDRB R5, [R2], #0     ; read first char of substring without incrementing index
            ADD R6, R6, #1
            MOV R1, R0            ; store current index of string being compared, if match found start comparing from here
            LDRB R4, [R0], #1     ; iterate through string
            CMP R4, #0            ; check if end of string is reached
            BEQ EXIT              ; if so exit 
            CMP R4, R5            ; else compare if first character of substring matches here 
            BEQ INNER_MATCH       ; jump to check complete substring match
            B OUTER_MATCH         ; check for next position where substring may match

INNER_MATCH:
            LDRB R4, [R1], #1     ; current character in string, where substring first char is matched
            LDRB R5, [R2], #1     ; start of substring 
            CMP R4, R5            ; compare iteratively 
            BEQ INNER_MATCH       ; if match , go for next characters
            CMP R5, #0            ; if end of substring reached means whole substring is present
            BEQ UPDATE_PRESENT  
            B OUTER_MATCH         ; if end of substring is not reached, and character is not matching jump to see next match in string


UPDATE_PRESENT:
              LDR R8, =PRESENT    ; update present where match is found
              STR R6, [R8]

EXIT:
     SWI 0x11
    .end