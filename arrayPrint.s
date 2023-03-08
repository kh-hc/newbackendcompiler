.data
  .word 5
.L.str0:
    .asciz " = {"
  .word 2
.L.str2:
    .asciz "}"
  .word 3
.L.str1:
    .asciz ", "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#72
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #44
mov r0, r1
bl malloc
mov r4, r0
mov r1, #10
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
mov r1, #0
mov r9, r1
str r9, [r4, #0]
mov r1, #1
mov r7, r1
str r7, [r4, #4]
mov r1, #2
mov r8, r1
str r8, [r4, #8]
mov r1, #3
mov r6, r1
str r6, [r4, #12]
mov r1, #4
mov r5, r1
str r5, [r4, #16]
mov r1, #5
mov r10, r1
str r10, [r4, #20]
mov r1, #6
mov r9, r1
str r9, [r4, #24]
mov r1, #7
mov r7, r1
str r7, [r4, #28]
mov r1, #8
mov r8, r1
str r8, [r4, #32]
mov r1, #9
mov r6, r1
str r6, [r4, #36]
mov r1, r4
mov r5, r1
mov r1, #0
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r5
mov r9, r1
mov r0, r9
bl _printp
ldr r1, =.L.str0
mov r7, r1
mov r0, r7
bl _prints
mov r1, #0
mov r8, r1
mov r1, r8
mov r10, r1
mov r1, r10
mov r6, r1
mov r1, #10
str r5, [fp, #-8]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movlt r6, #1
movge r6, #0
cmp r6, #1
bne .L1
.L0:
mov r1, #4
str r4, [fp, #-12]
mov r4, r1
mov r1, r10
str r10, [fp, #-16]
ldr r10, [fp, #-8]
str r9, [fp, #-20]
mov r9, r1
mov r1, r7
str r7, [fp, #-24]
ldr r7, [fp, #-16]
str r8, [fp, #-28]
mov r8, r1
mov r1, r8
mov r2, r4
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
b 1f
.ltorg
1:
str r6, [fp, #-32]
ldr r6, [r9, r8]
mov r1, r6
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r9, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-36]
mov r5, r1
mov r0, r5
bl _printi
mov r1, r7
str r4, [fp, #-40]
mov r4, r1
mov r1, #9
str r10, [fp, #-8]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movlt r4, #1
movge r4, #0
cmp r4, #1
bne .L2
ldr r1, =.L.str1
str r9, [fp, #-44]
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-48]
ldr r10, [fp, #-8]
str r4, [fp, #-52]
ldr r4, [fp, #-40]
str r9, [fp, #-56]
ldr r9, [fp, #-44]
b .L3
.L2:
.L3:
mov r1, r7
mov r9, r1
mov r1, #1
mov r4, r1
mov r1, r9
mov r2, r4
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
mov r7, r1
mov r1, r7
ldr r10, [fp, #-32]
mov r10, r1
mov r1, #10
str r7, [fp, #-16]
ldr r7, [fp, #-36]
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movlt r10, #1
movge r10, #0
cmp r10, #1
str r10, [fp, #-32]
ldr r10, [fp, #-16]
str r4, [fp, #-60]
ldr r4, [fp, #-12]
str r5, [fp, #-64]
mov r5, r7
ldr r6, [fp, #-32]
str r7, [fp, #-36]
ldr r7, [fp, #-24]
str r8, [fp, #-68]
ldr r8, [fp, #-28]
str r9, [fp, #-72]
ldr r9, [fp, #-20]
beq .L0
.L1:
ldr r1, =.L.str2
mov r9, r1
mov r0, r9
bl _prints
mov r0, #0
ldr r12, =#72
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
    .word 2
.L._printp_str0:
	.asciz "%p"
.text
_printp:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printp_str0
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
    .word 42
.L._errOutOfBounds_str0:
	.asciz "fatal error: array index %d out of bounds\n"
.text
_errOutOfBounds:
    ldr r0, =.L._errOutOfBounds_str0
    bl printf
    mov r0, #0
    bl fflush
    mov r0, #255
    bl exit
.ltorg
 
