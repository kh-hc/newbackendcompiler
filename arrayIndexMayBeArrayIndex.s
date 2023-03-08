.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#168
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #16
mov r0, r1
bl malloc
mov r4, r0
mov r1, #3
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
mov r1, #2
mov r9, r1
str r9, [r4, #0]
mov r1, #0
mov r7, r1
str r7, [r4, #4]
mov r1, #1
mov r8, r1
str r8, [r4, #8]
mov r1, r4
mov r6, r1
mov r1, #16
mov r0, r1
bl malloc
mov r5, r0
mov r1, #3
str r4, [fp, #-4]
mov r4, r1
str r4, [r5, #0]
mov r1, r5
mov r2, #4
adds r5, r1, r2
blvs _errOverflow
mov r1, #1
mov r10, r1
str r10, [r5, #0]
mov r1, #2
mov r9, r1
str r9, [r5, #4]
mov r1, #0
mov r7, r1
str r7, [r5, #8]
mov r1, r5
mov r8, r1
mov r1, #16
str r6, [fp, #-8]
mov r0, r1
bl malloc
mov r6, r0
mov r1, #3
str r5, [fp, #-12]
mov r5, r1
str r5, [r6, #0]
mov r1, r6
mov r2, #4
adds r6, r1, r2
blvs _errOverflow
mov r1, #5
mov r4, r1
str r4, [r6, #0]
mov r1, #6
mov r10, r1
str r10, [r6, #4]
mov r1, #7
mov r9, r1
str r9, [r6, #8]
mov r1, r6
mov r7, r1
mov r1, #0
str r8, [fp, #-16]
mov r8, r1
mov r1, r8
str r6, [fp, #-20]
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, #3
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movne r5, #1
moveq r5, #0
cmp r5, #1
bne .L1
.L0:
mov r1, #4
mov r10, r1
mov r1, r7
mov r9, r1
b 1f
.ltorg
1:
mov r1, #4
str r7, [fp, #-24]
mov r7, r1
mov r1, r8
str r8, [fp, #-28]
ldr r8, [fp, #-8]
str r6, [fp, #-32]
mov r6, r1
mov r1, #4
str r5, [fp, #-36]
mov r5, r1
mov r1, r4
str r4, [fp, #-40]
ldr r4, [fp, #-16]
str r10, [fp, #-44]
mov r10, r1
mov r1, r9
str r9, [fp, #-48]
ldr r9, [fp, #-32]
str r7, [fp, #-52]
mov r7, r1
mov r1, r7
mov r2, r5
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
str r8, [fp, #-8]
ldr r8, [r10, r7]
mov r1, r8
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r10, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r6, [fp, #-56]
mov r6, r1
mov r1, r6
mov r2, r5
str r5, [fp, #-60]
ldr r5, [fp, #-52]
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r10, [fp, #-64]
ldr r10, [r4, r6]
mov r1, r10
str r4, [fp, #-16]
ldr r4, [fp, #-56]
push {r1}
mov r3, r6
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r6
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-32]
mov r9, r1
mov r1, r9
mov r2, r7
str r7, [fp, #-68]
ldr r7, [fp, #-44]
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r1, #4
mov r8, r1
mov r1, r6
str r6, [fp, #-72]
ldr r6, [fp, #-24]
str r5, [fp, #-52]
mov r5, r1
mov r1, #4
str r4, [fp, #-56]
mov r4, r1
mov r1, r10
ldr r10, [fp, #-8]
str r9, [fp, #-76]
mov r9, r1
mov r1, #4
str r7, [fp, #-44]
mov r7, r1
mov r1, r8
str r8, [fp, #-80]
ldr r8, [fp, #-16]
str r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-84]
b 1f
.ltorg
1:
ldr r5, [fp, #-32]
str r4, [fp, #-88]
mov r4, r1
mov r1, r4
mov r2, r7
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
str r10, [fp, #-8]
ldr r10, [r6, r4]
mov r1, r10
push {r1}
mov r3, r4
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r4
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-92]
mov r9, r1
mov r1, r9
mov r2, r7
str r7, [fp, #-96]
ldr r7, [fp, #-88]
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
str r6, [fp, #-100]
ldr r6, [r8, r9]
mov r1, r6
str r8, [fp, #-16]
ldr r8, [fp, #-92]
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-32]
mov r5, r1
mov r1, r5
mov r2, r4
str r4, [fp, #-104]
ldr r4, [fp, #-80]
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r9, [fp, #-108]
ldr r9, [r10, r5]
mov r1, r9
ldr r10, [fp, #-84]
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r10, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-88]
mov r7, r1
mov r1, #1
str r8, [fp, #-92]
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
ldr r6, [fp, #-48]
str r5, [fp, #-112]
ldr r5, [fp, #-76]
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
b 1f
.ltorg
1:
pop {r1}
str r4, [fp, #-80]
mov r4, r1
str r4, [r6, r5]
mov r1, #4
str r10, [fp, #-84]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-24]
str r7, [fp, #-116]
mov r7, r1
mov r1, #4
str r8, [fp, #-120]
mov r8, r1
mov r1, r6
str r6, [fp, #-48]
ldr r6, [fp, #-8]
str r5, [fp, #-76]
mov r5, r1
mov r1, #4
mov r4, r1
mov r1, r10
str r10, [fp, #-124]
ldr r10, [fp, #-16]
str r9, [fp, #-24]
mov r9, r1
mov r1, r7
str r7, [fp, #-128]
ldr r7, [fp, #-32]
str r8, [fp, #-132]
mov r8, r1
mov r1, r8
mov r2, r4
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-8]
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
str r5, [fp, #-136]
mov r5, r1
mov r1, r5
mov r2, r4
str r4, [fp, #-140]
ldr r4, [fp, #-132]
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r9, [fp, #-144]
ldr r9, [r10, r5]
mov r1, r9
str r10, [fp, #-16]
ldr r10, [fp, #-136]
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r10, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-32]
mov r7, r1
mov r1, r7
mov r2, r8
str r8, [fp, #-148]
ldr r8, [fp, #-124]
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
str r5, [fp, #-152]
ldr r5, [r6, r7]
mov r1, r5
ldr r6, [fp, #-128]
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
b 1f
.ltorg
1:
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r4, [fp, #-132]
mov r4, r1
mov r0, r4
bl _printi
mov r1, r10
str r10, [fp, #-136]
ldr r10, [fp, #-32]
mov r9, r1
mov r1, #1
str r7, [fp, #-156]
mov r7, r1
mov r1, r9
mov r2, r7
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
mov r10, r1
mov r1, r10
str r8, [fp, #-124]
ldr r8, [fp, #-36]
mov r8, r1
mov r1, #3
str r6, [fp, #-128]
ldr r6, [fp, #-40]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movne r8, #1
moveq r8, #0
cmp r8, #1
str r4, [fp, #-160]
mov r4, r6
mov r5, r8
mov r1, r6
mov r6, r10
mov r10, r1
str r7, [fp, #-164]
ldr r7, [fp, #-24]
str r8, [fp, #-36]
ldr r8, [fp, #-28]
str r10, [fp, #-40]
str r9, [fp, #-168]
beq .L0
.L1:
mov r0, #0
ldr r12, =#168
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
 
