extern printf					; external C-function print



section .data					; intializing section

msg: db " %d ", 10,0				; printing out values
msg2: db "Fizz" , 10, 0				; replacing divisible by 5 out with  fizz or if there is a 5 any where 	



section .text					; section where the code goes
global main					; glibc function for the start of the program for gcc


main:						; pushing ebx to the stack
	mov ebx, 1
	


FizzCase:					; Test case to check value in the stack if it is divisible by 5 with a remainder of 0 or if the quotient is 10 or 11
	cmp ebx, 100				; compare value in ebx is 100 if it is exit the program
	jg exit					; jump to the exit function of the program
	mov eax, ebx				; copying value from ebx into eax 
	mov edx, 0				; initializing edx to 0
	mov ecx, 5				; copy 5 into ecx so ecx would be our devisor
	div ecx					;; div the value from ebx with ecx (5) which stores the Quotient into EAX and the Remainder into EDX
	cmp edx, 0				; comparing edx (the remainder) with 0 if a value is divisble by 5 the remainder should be zero so the value should be replaced with "Fizz"
	je printfizz				; Jump to printfizz function if equal to 0	
	cmp eax, 10				; condition 2 check if there are any values with 5 in it which leaves 51-54 and 56-59 comparing EAX (The Quotient) with 10
	je printfizz				; If it is equal to 10 then jump to the printfizz function to replace 51-54 with fizz
	cmp eax, 11				; condition 2 continued , compare eax with 11 this sataisfies values 56-59
	je printfizz				; if equal jump to printfizz function
	jmp printnum				; jump to the print num after all cases



printfizz:					; printfizz function
				
	push msg2				; pushes the db Fizz to the stack
	call printf				; call the print function to print out fizz
	add esp, 4				; clear stack
	inc ebx					; increment value in ebx
	jmp FizzCase				; jump to fizzcase

printnum:					; print num function

	push ebx				; push value in ebx into the stack
	push msg				; pushes the msg the holds the integer value %d into the stack
	call printf
	add esp, 8				; clear stack
	inc ebx					; inc ebx
	cmp ebx,100				; cmp if value is 100 
	jle FizzCase 				; if it is less jump to FizzCase
exit: 						; exit program
	mov ebx, 0				; syscall to exit
	mov eax, 1
					; syscall number 
	int 80h					; call to kernal	
	
