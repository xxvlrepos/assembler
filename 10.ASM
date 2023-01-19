org 100h
Begin:
    mov ah,9
;    mov dx,offset String
    int 21h
 
    int 20h 
 
    String db 'My string.$'