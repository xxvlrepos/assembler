;CSEG segment
;assume cs:CSEG, es:CSEG, ds:CSEG, ss:CSEG
org 100h
 
Begin:
;      mov sp,offset Lab_1
      mov ax,9090h
      push ax
      int 20h
 
Lab_1:
      mov ah,9
;      mov dx,offset Mess
      int 21h
 
      int 20h
 
Mess db '????? $'
 
;CSEG ends
;end Begin