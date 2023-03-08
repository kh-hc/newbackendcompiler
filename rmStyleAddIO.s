.data
  .word 26
.L.str1:
    .asciz "Enter the second number: "
  .word 21
.L.str2:
    .asciz "Initial value of x: "
  .word 25
.L.str0:
    .asciz "Enter the first number: "
  .word 4
.L.str3:
    .asciz "(+)"
  .word 1
.L.str4:
    .asciz ""
  .word 19
.L.str5:
    .asciz "final value of x: "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#60
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r9
mov r7, r1
ldr r1, =.L.str0
mov r8, r1
mov r0, r8
bl _prints
bl _readi
mov r10, r0
ldr r1, =.L.str1
mov r6, r1
mov r0, r6
bl _prints
bl _readi
mov r7, r0
ldr r1, =.L.str2
mov r5, r1
mov r0, r5
bl _prints
mov r1, r10
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _printi
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, #0
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movgt r10, #1
movle r10, #0
cmp r10, #1
bne .L1
.L0:
ldr r1, =.L.str3
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r1, #1
str r5, [fp, #-28]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r8, r1
mov r1, r4
str r4, [fp, #-32]
ldr r4, [fp, #-16]
str r10, [fp, #-36]
mov r10, r1
mov r1, #1
str r9, [fp, #-40]
mov r9, r1
mov r1, r10
mov r2, r9
subs r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r4, r1
mov r1, r4
str r7, [fp, #-44]
ldr r7, [fp, #-36]
mov r7, r1
mov r1, #0
str r8, [fp, #-8]
ldr r8, [fp, #-40]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movgt r7, #1
movle r7, #0
cmp r7, #1
str r10, [fp, #-48]
mov r10, r7
str r4, [fp, #-16]
b 1f
.ltorg
1:
ldr r4, [fp, #-32]
str r5, [fp, #-52]
ldr r5, [fp, #-28]
str r6, [fp, #-56]
ldr r6, [fp, #-24]
str r7, [fp, #-36]
ldr r7, [fp, #-16]
str r8, [fp, #-40]
ldr r8, [fp, #-20]
str r9, [fp, #-60]
ldr r9, [fp, #-40]
beq .L0
.L1:
ldr r1, =.L.str4
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str5
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
ldr r7, [fp, #-8]
mov r6, r1
mov r0, r6
bl _printi
mov r0, #0
ldr r12, =#60
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
