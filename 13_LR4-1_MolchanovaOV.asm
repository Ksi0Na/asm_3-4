use16
org 0x100
Start:
	jmp Init

Begin:
	pusha
	push ds

	mov ax, cs 		
	mov ds, ax 
	
	xor si, si

	mov cx, 16
	dump:
		push cx
		mov cx, 16
		dump_line:
			push cx
			mov ax, [es:si]
			mov [Value], al
			mov cx, 2
			print_al:
				push dx
				mov al, [Value]
				and al, 0xf0
				shr al, 4
				mov dl, al
				cmp dl, 0x09
				ja m1
				add  dl, 0x30
				jmp m2
				m1:
					add dl, 0x37

				m2:
					mov ah, 0x2
					int 0x21
					xor dx, dx
					
					mov al, [Value]
					shl al, 4
					mov [Value], al
					
					pop dx
			loop print_al
			pop cx
			
			push ax
			push dx
			mov ah, 0x9
			mov dx, str_space
			int 21h
			pop ax
			pop dx
			
			inc si
		loop dump_line
		
		push ax
		push dx
		mov ah, 0x09
		mov dx, str_enter
		int 21h
		pop ax
		pop dx
		
		pop cx
	loop dump

	
	pop ds
	popa
	iret


str_space db ' ','$'
str_enter db 0xD, 0xA, '$'
Value db 0

Init:
	mov ah, 0x25
	mov al, 0x8D
	mov dx, Begin
	
	int 0x21
	mov dx, Init
	int 0x27