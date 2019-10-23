/******************************************************************************
* File: string_comparison.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
### Part 1
Compare two strings of ASCII characters to see which is larger (i.e., which
follows the other in alphabetical ordering). Both strings have the same
length as defined by the **LENGTH** variable. The strings’ starting addresses
are defined by the **START1** and **START2** variables. If the string defined by
**START1** is greater than or equal to the other string, clear the **GREATER**
variable; otherwise set the variable to all ones ***(0xFFFFFFFF)***.

*/
  @BSS SECTION
  .bss
    GREATER: .word 0          @ will hold array length 

  @ DATA SECTION
      .data
	LENGTH: .word 6
	START1:  .ascii "ABCDGE"
	START2:  .ascii "ABCDGH"
	
  @ TEXT section
      .text

.globl _main

_main:
    LDR R0, =START1
    LDR R1, =START2
    LDR R3, =LENGTH  ; load strings and their length
    LDR R4, [R3]       
    MOV R8, #0       ; to hold the value of greater variable

LOOP:
	CMP R4, #0 ; till we reach the end of string (length becomes 0)
	BEQ EXIT
    LDRB R5, [R0], #1 ; read next char
    LDRB R6, [R1], #1  
    SUB R4, R4, #1     
    CMP R5, R6        ; compare characters
    BGT S1GREATER     ; if R5 is greater , clear greater variable and exit
    CMP R6, R5        
	  BGT S2GREATER     ;if R6 is greater, set greater variable and exit
    B LOOP            ;both characters are equal continue to next character

S2GREATER:
	MOV R8, #0xFFFFFFFF
	B EXIT

S1GREATER:
  MOV R8, #0x00000000
  B EXIT

 EXIT:
    LDR R7, =GREATER
    STR R8, [R7]
 	SWI 0x11
    .end