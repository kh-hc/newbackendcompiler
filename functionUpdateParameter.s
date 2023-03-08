.data
  .word 6
.L.str0:
    .asciz "y is "
  .word 6
.L.str2:
    .asciz "x is "
  .word 12
.L.str1:
    .asciz "y is still "
  .word 10
.L.str3:
    .asciz "x is now "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#8
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #1
mov r4, r1
mov r1, r4
mov r10, r1
ldr r1, =.L.str0
mov r9, r1
mov r0, r9
bl _prints
mov r1, r10
mov r7, r1
mov r0, r7
bl _printi
mov r1, r10
mov r8, r1
mov r0, r8
bl wacc_f
mov r6, r0
mov r1, r6
mov r5, r1
ldr r1, =.L.str1
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _printi
mov r0, #0
ldr r12, =#8
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

wacc_f:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r1, =.L.str2
mov r10, r1
mov r0, r10
bl _prints
mov r1, r4
mov r9, r1
mov r0, r9
bl _printi
mov r1, #5
mov r7, r1
mov r1, r7
mov r4, r1
ldr r1, =.L.str3
mov r8, r1
mov r0, r8
bl _prints
mov r1, r4
mov r6, r1
mov r0, r6
bl _printi
mov r1, r4
mov r5, r1
mov r0, r5
b 0f
0:
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
