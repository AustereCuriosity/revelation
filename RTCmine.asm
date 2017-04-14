.MODEL TINY
.286
.STACK 100
ORG 100H

CODE SEGMENT
	ASSUME CS:CODE,DX:CODE,ES:CODE
	OLD_IP DW 00
	OLD_CS DW 00
	JMP INIT
	
MY_TSR:
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		PUSH SI
		PUSH DI
		PUSH ES
		
		MOV AX,0B800H
		MOV ES,AX
		MOV DI,3650
		
		MOV AH,02H
		INT 1AH
		MOV BX,CX
		
		MOV CL,02H
	LOOP1:
		ROL BH,04
		MOV AL,BH
		AND AL,0FH
		ADD AL,30H
		MOV AH,17H
		MOV ES:[DI],AX
		INC DI
		INC DI
		DEC CL
		JNZ LOOP1
		
		MOV AL,':'
		MOV AH,97H
		MOV ES:[DI],AX
		INC DI
		INC DI
		
		MOV CL,02H
	LOOP2:
		ROL BL,04
		MOV AL,BL
		AND AL,0FH
		ADD AL,30H
		MOV AH,17H
		MOV ES:[DI],AX
		INC DI
		INC DI
		DEC CL
		JNZ LOOP2
		
		MOV AL,':'
		MOV AH,97H
		MOV ES:[DI],AX
		INC DI
		INC DI
		
		MOV BH,DH
		MOV CL,02H
	LOOP3:
		ROL BH,04
		MOV AL,BH
		AND AL,0FH
		ADD AL,30H
		MOV AH,17H
		MOV ES:[DI],AX
		INC DI
		INC DI
		DEC CL
		JNZ LOOP3
		
		POP ES
		POP DI
		POP SI
		POP DX
		POP CX
		POP BX
		POP AX

INIT:
		MOV AX,CS
		MOV DS,AX
		
		CLI
		
		MOV AH,35H
		MOV AL,08H
		INT 21H
		
		MOV OLD_IP,BX
		MOV OLD_CS,ES
		
		MOV AH,25H
		MOV AL,08H
		LEA DX,MY_TSR
		INT 21H
		
		MOV AH,31H
		MOV DX,OFFSET INIT
		STI
		INT 21H
		
CODE ENDS

END