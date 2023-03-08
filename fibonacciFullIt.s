.data
  .word 62
.L.str0:
    .asciz "This program calculates the nth fibonacci number iteratively."
  .word 16
.L.str2:
    .asciz "The input n is "
  .word 43
.L.str1:
    .asciz "Please enter n (should not be too large): "
  .word 29
.L.str3:
    .asciz "The nth fibonacci number is "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#76
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str1
mov r10, r1
mov r0, r10
bl _prints
mov r1, #0
mov r9, r1
mov r1, r9
mov r7, r1
bl _readi
mov r7, r0
ldr r1, =.L.str2
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
mov r6, r1
mov r0, r6
bl _printi
ldr r1, =.L.str3
mov r5, r1
mov r0, r5
bl _prints
mov r1, #0
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
mov r1, #1
str r9, [fp, #-12]
mov r9, r1
mov r1, r9
str r7, [fp, #-16]
mov r7, r1
mov r1, #0
str r8, [fp, #-20]
mov r8, r1
mov r1, r8
str r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-28]
ldr r5, [fp, #-16]
str r4, [fp, #-32]
mov r4, r1
mov r1, #0
str r10, [fp, #-36]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movgt r4, #1
movle r4, #0
cmp r4, #1
bne .L1
.L0:
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-36]
mov r6, r1
mov r1, r7
mov r9, r1
mov r1, r6
str r7, [fp, #-44]
mov r7, r1
mov r1, r8
str r8, [fp, #-48]
ldr r8, [fp, #-44]
str r6, [fp, #-52]
mov r6, r1
mov r1, r7
mov r2, r6
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r8, r1
mov r1, r5
str r5, [fp, #-16]
mov r5, r1
mov r1, #1
str r4, [fp, #-56]
mov r4, r1
mov r1, r5
mov r2, r4
subs r5, r1, r2
blvs _errOverflow
mov r1, r5
b 1f
.ltorg
1:
str r10, [fp, #-60]
ldr r10, [fp, #-16]
mov r10, r1
mov r1, r10
str r9, [fp, #-36]
ldr r9, [fp, #-56]
mov r9, r1
mov r1, #0
str r7, [fp, #-64]
ldr r7, [fp, #-60]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movgt r9, #1
movle r9, #0
cmp r9, #1
mov r1, r10
mov r10, r7
mov r7, r1
str r4, [fp, #-68]
mov r4, r9
str r5, [fp, #-72]
mov r5, r7
str r6, [fp, #-76]
ldr r6, [fp, #-52]
mov r1, r7
mov r7, r8
mov r8, r1
str r8, [fp, #-16]
ldr r8, [fp, #-48]
str r9, [fp, #-56]
ldr r9, [fp, #-40]
beq .L0
.L1:
mov r1, r9
ldr r9, [fp, #-36]
mov r8, r1
mov r0, r8
bl _printi
mov r0, #0
ldr r12, =#76
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
@ length of .L._errOverflow_str0
    .word 52
.L._errOverflow_str0:
    .asciz "#runtime_error#\n"
.text
_errOverflow:
    ldr r0, =.L._errOverflow_str0
    bl _prints
    mov r0, #255
    bl exit
    .ltorg
.data
	.word 2
.L._readi_str0:
	.asciz "%d"
.text
_readi:
    push {lr}
    str r0, [sp, #-4]!
    mov r1, sp
    ldr r0, =.L._readi_str0
    bl scanf
    ldr r0, [sp, #0]
	add sp, sp, #4
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