.data
  .word 10
.L.str0:
    .asciz "incorrect"
  .word 8
.L.str1:
    .asciz "correct"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
subs sp, sp, r12
push {r10}
push {r4}
push {r7}
push {r8}
push {r9}
mov r1, #13
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, #13
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
bne .L0
ldr r1, =.L.str0
mov r8, r1
mov r0, r8
bl _prints
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L1
.L0:
ldr r1, =.L.str1
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-16]
.L1:
mov r0, #0
ldr r12, =#16
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
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