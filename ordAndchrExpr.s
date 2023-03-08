.data
  .word 5
.L.str0:
    .asciz " is "
  .word 5
.L.str1:
    .asciz " is "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#12
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #97
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #99
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r10
mov r8, r1
mov r0, r8
bl _printc
ldr r1, =.L.str0
mov r6, r1
mov r0, r6
bl _prints
mov r1, r10
mov r5, r1
mov r1, r5
mov r5, r1
mov r0, r5
bl _printi
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _printi
ldr r1, =.L.str1
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
mov r1, r7
str r9, [fp, #-12]
mov r9, r1
mov r1, r9
mov r9, r1
mov r0, r9
bl _printc
mov r0, #0
ldr r12, =#12
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
pop {r4}
pop {r10}
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
.data
    .word 4
.L._prints_str0:
    .asciz "%.*s"
.text
_prints:
	push {lr}
    push {r1, r2}
	mov r2, r0
	ldr r1, [r0, #-4]
	ldr r0, =.L._prints_str0
	bl printf
	mov r0, #0
	bl fflush
    pop {r1, r2}
	pop {pc}
    .ltorg
.data
    .word 2
.L._printc_str0:
	.asciz "%c"
.text
_printc:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printc_str0
	bl printf
	mov r0, #0
	bl fflush
    pop {r1}
	pop {pc}
    .ltorg
