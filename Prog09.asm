;��������� ��������� ������ ����� ���� � �� ����� ������, ���� ���
;��� ���������
;CSEG segment
;assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h

; -------------- ������ -------------
Begin:
;��������� ���� � ������� �������������
;        mov dx,offset File_name
	call Open_file	       ;��������� ���� � ������ Prog09.com
	jc Error_file	       ;��������� �� ����� Error_file ��� �������
; -------------- ������� ���� -----------
 
	mov bx,ax	       ;��������� ������������� �����
			       ;������ �����
	mov ah,3Fh	       ;��������� ����� ����� ��������� (���������� �������� ������) � ������� cx...
;        mov cx,offset Finish-100h
;        mov dx,offset Begin    ;� ������ ���� � ������,
	int 21h 	       ;������� � ����� Begin.
; ------------- ��������� ���� ----------------
 
	call Close_file        ;��������� ���� � ������� �������������
 
; ------------ ������� ��������� --------------
	mov ah,9	       ;������� ��������� �� ������� ����������
;        mov dx,offset Mess_ok
	int 21h
	ret
				;���� ���� � ��������� ������ �� ����� (File_name db 'Prog09.com',0),
				;�� ������ �������� ������ � �������
; ---------- �� ������ ����� ���� -----------------
Error_file:
	mov ah,2
	mov dl,7
	int 21h
	ret
 
; ���������
; --- �������� ����� ---
Open_file:
;          cmp Handle,0FFFFh      ;��������, ������ �� ����
	  jne Quit_open 	 ;� ���� �� ������ � ��������� ���
	  mov ax,3D00h
	  int 21h
;          mov Handle,ax
	  ret
Quit_open:
	stc			 ;������������� ���� �������� � 1, �����������
	ret			 ;��� ������������� ����� �������� ����� (��� jc)
	Handle dw 0FFFFh
;Open_file endp
 
; --- �������� ����� ---
Close_file:
	   mov ah,3Eh
	   mov bx,Handle
	   int 21h
	   ret
;Close_file endp
 
; ������
File_name db 'Prog09.com',0	 ;0Ah,0Dh � ������� � ������ ��������� ������
Mess_ok db '��� ���������!', 0Ah, 0Dh, '$'
 
Finish equ $ 
				 ;������� (�����) ����� ���� ���������
;CSEG ends
;end Begin