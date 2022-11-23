;Find the mark average
;Date: 16/May/2022
;©Copyright: Faisal Ahmad Dawod

org 100h

.stack 120

.data

;Message for User
msg db "Enter a Grade:$"

;Graph Strings
gMsg db "Fail$", "Fair$", "Good$", "Very Good$", "Excellent$"
nxt db "next$"
avg db "The Grade average: $" 

;Grade Var.
grade db 0
sum dw 0   ;sum
res db 0
mod db 0

;Mouse Flag
flag db 0
flago db 0

;Counters:
fail db 0
fair db 0
good db 0
very db 0
excellent db 0 
cnt db 0 ;CNT HOW MANY MARK
;-------------------------------------------------------------------------------------------------------------------- 

.code
mov ax, @data
mov ds, ax

;Calling Function to dispaly to user prompt message, graph Box, and next box
call msgg
call graph
call nxxtG

buff:      ;Buffur
mov ah, 0bh
int 21h
cmp al, 0ffh
je lol

call mouseInput ;Mouse Input
cmp flago, 1    ;Flag to stop the program when user click NEXT button
je endd         ;JUMP to endd label to stop program
jmp buff        ;JUMP to buff label to continue RUN program

lol: call cur   ;Cursor

;Calling Function to prompt user 
call KEY
call comp       ;Compare function
call clear      ;Clear function to return cursor and delete number in terminal
  
jmp buff        ;JUMP to buff label for looping

endd:ret        ;STOP! the program
;---------------------------------------------Function Section-------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------
;Function For Prompt Message
msgg proc
    
;Display Message For user
mov dx, offset msg
mov ah, 09h
int 21h
    
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function For Input
KEY proc
        
mov ah,1
int 21h
cmp al,0dh
je end
sub al,30h
mov grade,al

inc cnt   ;Increment the counter to know how many input

mov cx,3

;----Mul----
mult:int 21h
cmp al,0dh
je end
sub al,30h
mov dl,al
mov al,10
mov bl,grade
mul bl
mov ah,0
mov grade,al
add grade,dl
mov ah,1
loop mult

end:          ;Addition grade to sum
mov dh, 0
mov dl, grade
add sum, dx

ret    
endp
;--------------------------------------------------------------------------------------------------------------------
;-----------------------------------------Counter sections-----------------------------------------------------------
;Function For Fail
faill proc
inc fail

mov ah,2
mov dl,8  ;col
mov dh,18 ;row
mov bh,0
int 10h

cmp fail, 10
jb L9

cmp fail, 100
jb L10
jmp L11

L9:mov dl, fail  ;1-Digit
add dl, 30h
int 21h
jmp foo

L10: ;2-Digit
mov ah, 0
mov al, fail
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h
jmp foo

L11: ;3-Digits
mov ax, 0
mov al, fail
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21

foo:ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function For Fair
fairr proc
inc fair      ;Increment fair counter 
mov ah,2
mov dl,23 ;row
mov dh,18 ;col
mov bh,0
int 10h

cmp fair, 10
jb L66

cmp fair, 100
jb L45
jmp L22

L66:mov dl, fair
add dl, 30h
int 21h
jmp boo

L45: ;2-Digit
mov ah, 0
mov al, fair
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h
jmp boo

L22: ;3-Digit
mov ax, 0
mov al, fair
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21

boo:ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function For Good
goodd proc
inc good      ;Increment good counter
mov ah,2
mov dl,38 ;row
mov dh,18 ;col
mov bh,0
int 10h

cmp good, 10
jb Lo9

cmp good, 100
jb Lo10
jmp Lo11

Lo9:mov dl, good  ;1-Digtit
add dl, 30h
int 21h
jmp koo

Lo10: ;2-Digit
mov ah, 0
mov al, good
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h
jmp koo

Lo11: ;3-Digit
mov ax, 0
mov al, good
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21

koo:ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function For Very Good
veryy proc
inc very      ;Increment very good counter
mov ah,2
mov dl,53 ;col
mov dh,18 ;row
mov bh,0
int 10h

cmp very, 10
jb Lr66

cmp very, 100
jb Lr45
jmp Lr22

Lr66:mov dl, very ;1-Digit
add dl, 30h
int 21h
jmp soo

Lr45: ;2-Digit
mov ah, 0
mov al, very
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h
jmp soo

Lr22: ;3-Digit
mov ax, 0
mov al, very
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21

soo:ret

ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function For Exc.
excellentt proc
inc excellent ;Increment excellent counter
mov ah,2
mov dl,70 ;row
mov dh,18 ;col
mov bh,0
int 10h
 
cmp excellent, 10
jb L660

cmp excellent, 100
jb L450
jmp L220

L660:mov dl, excellent  ;1-Digit
add dl, 30h
int 21h
jmp noo

L450: ;2-Digit
mov ah, 0
mov al, excellent
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h
jmp noo

L220: ;3-Digit
mov ax, 0
mov al, excellent
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21

noo:ret 
  
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function to make Graph
graph proc

call pGrade  ;Calling pGrade Function to display grade names  
    
mov ah,2
mov dl,0 ;row
mov dh,15;col
mov bh,0
int 10h

call line

call vertical

mov ah,2
mov dl,15
mov dh,16
mov bh,0
int 10h

call vertical 

mov ah,2
mov dl,30
mov dh,16
mov bh,0
int 10h

call vertical

mov ah,2
mov dl,45
mov dh,16
mov bh,0
int 10h

call vertical

mov ah,2
mov dl,60
mov dh,16
mov bh,0
int 10h

call vertical

mov ah,2
mov dl,0
mov dh,21
mov bh,0
int 10h
call line    
ret
endp
;--------------------------------------------------------------------------------------------------------------------
proc line uses ax, cx, dx  ;Not change register addresses
mov cx, 80
mov dl, '_'
mov ah, 2
;----Looping----
lines:int 21h
loop lines  
ret
endp
;--------------------------------------------------------------------------------------------------------------------
proc vertical uses ax, cx, dx
mov cx, 5
mov ah, 2
;----Looping----
verticals: mov dl, '|'
int 21h
mov dl, 0ah
int 21h
mov dl, 8
int 21h
loop verticals
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function to Compare(if-else) to sort marks and calling other functions to increment
comp proc
mov al, grade

cmp al, 50    ;grade<50 
jb call faill

cmp al, 60    ;50<grade<60
jb call fairr

cmp al, 75    ;60<grade<75
jb call goodd

cmp al, 90    ;75<grade<90
jb call veryy

cmp al, 101   ;90<grade<100  Q: Why here 101? Because if I but Grade 100 when the emu compare it the 100 not include it to include JUST 100 I but it 101
jb call excellentt  
    
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Clear_up Function to clear screen and update
clear_up proc
mov ax,0003h
int 10h
mov dh, 0
mov dl, 0
 mov bh, 2
mov ah, 2
int 10h

call avgGrade
   
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function Know mouse click or no
proc mouseInput 
    
mov ax, 3
int 33h
cmp bx,1
je clear_up

cmp bx,1
jne endmouse
je clear_up

cmp dx,7
jb  endmouse
je clear_up

cmp dx,31
ja endmouse
je clear_up

cmp cx,584
jb endmouse
je clear_up

cmp cx,631
ja endmouse

call clear_up
mov flag,1

endmouse:ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function Cursur
cur proc
mov dh, 0
mov dl, 14
mov bh, 0
mov ah, 2
int 10h    
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function to print Grade Message
pGrade proc

mov dl, 0
mov dh, 14
mov ah, 02h
int 10h

mov cx, 5
mov si, 0

pG:
    push dx
    gN:
    
        mov ah, 2
        mov dl, gMsg[si]
        int 21h
        inc si
        cmp gMsg[si], '$'
        jne gN
    pop dx
    moveNext:
        mov ah, 2
        mov dh, 14
        add dl, 16
        int 10h
        inc si
Loop pG
        

ret    
endp
;--------------------------------------------------------------------------------------------------------------------
;Clear cursor
clear proc
mov dh, 0
mov dl, 14
mov bh, 0
mov ah, 2
int 10h
 
mov cx, 3

llo:
mov ah, 02h
mov dl, 0
int 21h
loop llo
    
ret
endp
;-------------------------------------------------------------------------------------------------------------------- 
;Function to Display NEXT Graph 
nxxtG proc
    
mov ah,2
mov dl,65 ;col
mov dh,2  ;row
mov bh,0
int 10h
;----LINE----   
mov cx, 10
mov dl, '_'
mov ah, 2
;----Looping----
lineO:int 21h
loop lineO

mov ah,2
mov dl,65 ;col
mov dh,3  ;row
mov bh,0
int 10h

;vertical Line
mov cx, 2
mov ah, 2
;----Looping----
verticalO: mov dl, '|'
int 21h
mov dl, 0ah
int 21h
mov dl, 8
int 21h
loop verticalO

mov ah,2
mov dl,74 ;col
mov dh,3;row
mov bh,0
int 10h

;vertical
mov cx, 2
mov ah, 2
;----Looping----
verticalOs: mov dl, '|'
int 21h
mov dl, 0ah
int 21h
mov dl, 8
int 21h
loop verticalOs

mov ah,2
mov dl,65 ;col
mov dh,5  ;row
mov bh,0
int 10h 

;----LINE----   
mov cx, 10
mov dl, '_'
mov ah, 2
;----Looping----
lineOs:int 21h
loop lineOs

mov ah,2
mov dl,68 ;col
mov dh,4  ;row
mov bh,0
int 10h 

mov dx, offset nxt
mov ah, 09h
int 21h
   
ret
endp
;--------------------------------------------------------------------------------------------------------------------
;Function to calculate avgerage and display
;-------------Result Section---------------
avgGrade proc

mov dx, offset avg
mov ah, 09h
int 21h

mov ax, sum
cmp sum, 0
je L0
mov bl, cnt
div bl
mov res, al
mov mod, ah
cmp res, 10
jb L55

cmp res, 100
jb L25
jmp L15

L55:mov dl, res  ;1-Digit
add dl, 30h
int 21h 
mov flago,1
jmp moo

L25: ;2-Digit
mov ah, 0
mov al, res
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h  
mov flago,1
jmp moo

L15: ;3-Digit
mov ax, 0
mov al, res
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
mov flago,1
int 21     
;--------------------------------------------------------------------------------------------------------------------
;------------------Mod (%) Section------------------------
moo:
mov dl, "."
mov ah, 2
int 21h

cmp mod, 10
jb L99

cmp mod, 100
jb L98
jmp L97

L99:mov dl, mod
add dl, 30h
int 21h 
mov flago,1
jmp av 

L98: ;2-Digit
mov ah, 0
mov al, mod
mov bx, 10
div bl

mov cl, ah
mov dl, al
mov ah, 2
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21h 
mov flago,1
jmp av

L97: ;3-Digits
mov ax, 0
mov al, mod
mov bx, 100
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dh, 30h
int 21h
mov bx, 10
mov ax, 0
mov al, cl
div bl
mov cl, ah
mov ah, 2
mov dl, al
add dl, 30h
int 21h
mov dl, cl
add dl, 30h
int 21
mov flago,1
jmp av

L0:
mov ah, 2
mov dl, "0"
int 21h

mov flago,1
    
av:ret
endp  