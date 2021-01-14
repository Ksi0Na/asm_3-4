use16
org 0x100
sti
mov ax, 0xE78
mov es, ax 
mov di, 20
int 0x8D
mov ax, cs
mov ds, ax
int 20h