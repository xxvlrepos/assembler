;CSEG segment
;assume CS:CSEG, DS:CSEG, ES:CSEG, SS:CSEG

org 100h
;int 10h
 
Start:
	mov ax,0B800h
	mov es,ax
	mov al,1
	mov ah,31
	mov cx,254
 
Next_screen:
	mov di,0
	call Out_chars
	inc al
	loop Next_screen

	mov ah,10h
	int 16h
 
	int 20h
 
 
Out_chars:
	mov dx,cx
	mov cx,2000
Next_face:
	mov [es:di],ax
	add di,2
	loop Next_face
 
	mov cx,dx
	ret
;Out_chars endp
 
;CSEG ends
;end Start