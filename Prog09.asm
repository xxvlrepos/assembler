;Программа выполняет запись самой себя в то место памяти, куда она
;уже загружена
;CSEG segment
;assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG
org 100h

; -------------- Начало -------------
Begin:
;Открываем файл с помощью спецпроцедуры
;        mov dx,offset File_name
	call Open_file	       ;Открываем файл с именем Prog09.com
	jc Error_file	       ;Переходим на метку Error_file при неудаче
; -------------- Открыли файл -----------
 
	mov bx,ax	       ;Сохраняем идентификатор файла
			       ;Чтение файла
	mov ah,3Fh	       ;Загружаем длину нашей программы (количество читаемых байтов) в регистр cx...
;        mov cx,offset Finish-100h
;        mov dx,offset Begin    ;И читаем файл в память,
	int 21h 	       ;начиная с метки Begin.
; ------------- Прочитали файл ----------------
 
	call Close_file        ;Закрываем файл с помощью спецпроцедуры
 
; ------------ Выводим сообщение --------------
	mov ah,9	       ;Выводим сообщение об удачном завершении
;        mov dx,offset Mess_ok
	int 21h
	ret
				;Если файл с указанным именем не нашли (File_name db 'Prog09.com',0),
				;то выдаем звуковой сигнал и выходим
; ---------- Не смогли найти файл -----------------
Error_file:
	mov ah,2
	mov dl,7
	int 21h
	ret
 
; Процедуры
; --- Открытие файла ---
Open_file:
;          cmp Handle,0FFFFh      ;Выясняем, открыт ли файл
	  jne Quit_open 	 ;И если не открыт — открываем его
	  mov ax,3D00h
	  int 21h
;          mov Handle,ax
	  ret
Quit_open:
	stc			 ;Устанавливаем флаг переноса в 1, необходимый
	ret			 ;для подтверждения факта открытия файла (для jc)
	Handle dw 0FFFFh
;Open_file endp
 
; --- Закрытие файла ---
Close_file:
	   mov ah,3Eh
	   mov bx,Handle
	   int 21h
	   ret
;Close_file endp
 
; Данные
File_name db 'Prog09.com',0	 ;0Ah,0Dh — переход в начало следующей строки
Mess_ok db 'Все нормально!', 0Ah, 0Dh, '$'
 
Finish equ $ 
				 ;Признак (адрес) конца кода программы
;CSEG ends
;end Begin