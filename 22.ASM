;include 'win32wx.inc'
;CSEG segment
org 100h
Start:

     mov ah,9
     mov dx, String
     int 21h

     mov ah,10h
     int 16h

     int 20h

String db 80h,81h,82h,'привет...$'
;CSEG end
;end Start