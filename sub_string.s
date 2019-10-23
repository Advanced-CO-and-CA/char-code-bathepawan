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
	SUBSTR:  .asciiz "667"
	
  @ TEXT section
  .text

.globl _main
  
_main:

    LDR R0, =STRING
    MOV R1, #0    
STRLEN_LOOP:
    LDRB R2, [R0], #1
    CMP R2,#0
    BEQ EXIT_STRLEN 
    ADD R1, R1, #1
    B STRLEN_LOOP

EXIT_STRLEN:
    LDR R0, =SUBSTR
    MOV R3, #0    

SUB_STRLEN_LOOP:
    LDRB R2, [R0], #1
    CMP R2,#0
    BEQ EXIT_SUB_STRLEN 
    ADD R3, R3, #1
    B SUB_STRLEN_LOOP
; 1 and 3 hold length


EXIT_SUB_STRLEN:
    LDR R0, =STRING
    MOV R6, #0

OUTER_MATCH:
            LDR R2, =SUBSTR
            LDRB R5, [R2], #0
            ADD R6, R6, #1
            MOV R1, R0
            LDRB R4, [R0], #1
            CMP R4, #0
            BEQ EXIT
            CMP R4, R5 
            BEQ INNER_MATCH
            B OUTER_MATCH

INNER_MATCH:
            LDRB R4, [R1], #1
            LDRB R5, [R2], #1
            CMP R4, R5
            BEQ INNER_MATCH
            CMP R5, #0
            BEQ UPDATE_PRESENT
            B OUTER_MATCH


UPDATE_PRESENT:
              LDR R8, =PRESENT
              STR R6, [R8]

EXIT:
     SWI 0x11
    .end