.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r9}
bl wacc_f
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r0, r9
bl _printi
mov r0, #0
pop {r9}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_f:
push {lr}
push {fp}
mov fp, sp
push {r4}
mov r1, #0
mov r4, r1
mov r0, r4
b 0f
0:
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

.data
    .word 2
.L._printi_str0:		
    .asciz "%d"
.text
_printi:
    push {lr}
    push {r1}
    mov r1, r0
    ldr r0, =.L._printi_str0
    bl printf
    mov r0, #0
    bl fflush
    pop {r1}
    pop {pc}
.ltorg
.data
    .word 0
.L._println_str0:
	.asciz ""
.text
_println:
	push {lr}
    push {r1}
	ldr r0, =.L._println_str0
	bl puts
	mov r0, #0
	bl fflush
    pop {r1}
	pop {pc}
    .ltorg
