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
ldr r12, =#100
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
mov r1, #0
mov r7, r1
str r7, [r4, #4]
mov r1, #0
mov r8, r1
str r8, [r4, #8]
mov r1, #0
mov r6, r1
str r6, [r4, #12]
mov r1, #0
mov r5, r1
str r5, [r4, #16]
mov r1, #0
mov r10, r1
str r10, [r4, #20]
mov r1, #0
mov r9, r1
str r9, [r4, #24]
mov r1, #0
mov r7, r1
str r7, [r4, #28]
mov r1, #0
mov r8, r1
str r8, [r4, #32]
mov r1, #0
mov r6, r1
str r6, [r4, #36]
mov r1, r4
mov r5, r1
mov r1, #0
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, #10
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movlt r9, #1
movge r9, #0
cmp r9, #1
bne .L1
.L0:
mov r1, #4
mov r8, r1
mov r1, r5
mov r6, r1
mov r1, r10
str r5, [fp, #-8]
mov r5, r1
mov r1, r5
mov r2, r8
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, r10
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r4, [fp, #-12]
mov r4, r1
str r4, [r6, r5]
mov r1, r10
str r10, [fp, #-16]
b 1f
.ltorg
1:
mov r10, r1
mov r1, #1
str r9, [fp, #-20]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
str r7, [fp, #-24]
ldr r7, [fp, #-16]
mov r7, r1
mov r1, r7
str r8, [fp, #-28]
ldr r8, [fp, #-20]
mov r8, r1
mov r1, #10
str r6, [fp, #-32]
ldr r6, [fp, #-24]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movlt r8, #1
movge r8, #0
cmp r8, #1
str r10, [fp, #-36]
mov r10, r7
ldr r4, [fp, #-12]
str r5, [fp, #-40]
ldr r5, [fp, #-8]
mov r1, r7
mov r7, r6
mov r6, r1
str r9, [fp, #-44]
mov r9, r8
str r6, [fp, #-16]
str r8, [fp, #-20]
beq .L0
.L1:
mov r1, r5
mov r8, r1
mov r0, r8
bl _printp
ldr r1, =.L.str0
mov r6, r1
mov r0, r6
bl _prints
mov r1, #0
mov r9, r1
mov r1, r9
ldr r5, [fp, #-16]
mov r5, r1
mov r1, r5
mov r4, r1
mov r1, #10
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movlt r4, #1
movge r4, #0
cmp r4, #1
bne .L3
.L2:
mov r1, #4
str r7, [fp, #-24]
mov r7, r1
mov r1, r5
str r8, [fp, #-48]
mov r8, r1
mov r1, r5
str r6, [fp, #-52]
mov r6, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r9, [fp, #-56]
ldr r9, [r8, r6]
mov r1, r9
push {r1}
mov r3, r6
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r6
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-16]
mov r5, r1
mov r0, r5
bl _printi
mov r1, r4
str r4, [fp, #-60]
ldr r4, [fp, #-16]
str r10, [fp, #-64]
mov r10, r1
mov r1, #9
str r7, [fp, #-68]
b 1f
.ltorg
1:
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movlt r10, #1
movge r10, #0
cmp r10, #1
bne .L4
ldr r1, =.L.str1
str r8, [fp, #-72]
mov r8, r1
mov r0, r8
bl _prints
str r10, [fp, #-76]
ldr r10, [fp, #-64]
str r4, [fp, #-16]
ldr r4, [fp, #-60]
str r7, [fp, #-80]
ldr r7, [fp, #-68]
str r8, [fp, #-84]
ldr r8, [fp, #-72]
b .L5
.L4:
.L5:
mov r1, r8
ldr r8, [fp, #-16]
mov r7, r1
mov r1, #1
mov r4, r1
mov r1, r7
mov r2, r4
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r8, r1
mov r1, r8
mov r4, r1
mov r1, #10
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movlt r4, #1
movge r4, #0
cmp r4, #1
str r4, [fp, #-88]
ldr r4, [fp, #0]
str r5, [fp, #-92]
mov r5, r8
str r6, [fp, #-96]
ldr r6, [fp, #-52]
str r7, [fp, #-100]
ldr r7, [fp, #-24]
str r8, [fp, #-16]
ldr r8, [fp, #-48]
ldr r9, [fp, #-56]
beq .L2
.L3:
ldr r1, =.L.str2
mov r9, r1
mov r0, r9
bl _prints
mov r0, #0
ldr r12, =#100
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
 
