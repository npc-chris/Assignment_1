; register_immediate_operand_mov.asm
; Objective: To test MOV instructions (register and immediate operands)
;
.386
.model flat, stdcall

; Declare external exit function from kernel32
ExitProcess PROTO :DWORD

; .data
	; msgValid BYTE "Assembled: valid instruction",0
	; msgEnd   BYTE "Program finished",0

.code
main PROC
	; --- Part 1: Register-to-register and register-to-segment ---

	; mov ax,bx       ; a. V  - both are 16-bit general-purpose registers
	; mov dx,bl       ; b. I  - size mismatch: DX is 16-bit, BL is 8-bit
	; mov ecx,edx     ; c. V  - both are 32-bit registers
	; mov si,di       ; d. V  - both are 16-bit index registers
	; mov ds,ax       ; e. V - assembler-legal; runtime depends on selector validity
	; mov ax,es       ; f. V  - segment register to 16-bit general register
	; mov al,dh       ; g. V  - both are 8-bit registers
	; mov ax,dh       ; h. I  - size mismatch: AX is 16-bit, DH is 8-bit
	; mov ip,ax       ; i. I  - IP/EIP/RIP cannot be written directly with MOV
	; mov si,cl       ; j. I  - size mismatch: SI is 16-bit, CL is 8-bit
	; mov edx,ax      ; k. I  - size mismatch: EDX is 32-bit, AX is 16-bit
	; mov ax,es       ; l. V  - valid segment-to-register move

	; --- Part 2: Register and immediate MOV ---

	; mov ax,16        ; a. V  - immediate 16 fits in 16-bit AX
	; mov dx,7F65h     ; b. V  - 0x7F65 fits 16-bit DX
	; mov ecx,6F23458h ; c. V  - 0x6F23458 fits 32-bit ECX
	; mov si,-1        ; d. V  - -1 encodes as 0xFFFF and fits 16-bit SI
	; mov ds,1000h     ; e. I  - cannot move an immediate directly into a segment register
	; mov al,100h      ; f. I  - 0x100 does not fit in 8-bit AL
	; mov 123,dh       ; g. I  - immediate cannot be the destination
	; mov ss,ds        ; h. I  - moving directly between segment registers is not allowed
	; mov 0FABh,ax     ; i. I  - immediate cannot be the destination
	; mov si,cl        ; j. I  - size mismatch: CL is 8-bit, SI is 16-bit
	; mov edx,esi      ; k. V  - 32-bit register to 32-bit register
	; mov edx,-2       ; l. V  - immediate -2 fits in 32-bit EDX (encoded as two's complement)

	push 0
	call ExitProcess
main ENDP

END main
