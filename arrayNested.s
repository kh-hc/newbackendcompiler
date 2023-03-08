.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#48
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
mov r1, #1
mov r9, r1
str r9, [r4, #0]
mov r1, #2
mov r7, r1
str r7, [r4, #4]
mov r1, #3
mov r8, r1
str r8, [r4, #8]
mov r1, r4
mov r6, r1
mov r1, #12
mov r0, r1
bl malloc
mov r5, r0
mov r1, #2
str r4, [fp, #-4]
mov r4, r1
str r4, [r5, #0]
mov r1, r5
mov r2, #4
adds r5, r1, r2
blvs _errOverflow
mov r1, #3
mov r10, r1
str r10, [r5, #0]
mov r1, #4
mov r9, r1
str r9, [r5, #4]
mov r1, r5
mov r7, r1
mov r1, #12
mov r0, r1
bl malloc
mov r8, r0
mov r1, #2
str r6, [fp, #-8]
mov r6, r1
str r6, [r8, #0]
mov r1, r8
mov r2, #4
adds r8, r1, r2
blvs _errOverflow
mov r1, r5
str r5, [fp, #-12]
ldr r5, [fp, #-8]
mov r4, r1
str r4, [r8, #0]
mov r1, r7
mov r10, r1
str r10, [r8, #4]
mov r1, r8
mov r9, r1
mov r1, #4
str r7, [fp, #-16]
mov r7, r1
mov r1, r9
str r8, [fp, #-20]
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r5, [fp, #-8]
ldr r5, [r8, r6]
mov r1, r5
push {r1}
mov r3, r6
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r6
b 1f
.ltorg
1:
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r4, r1
mov r1, r4
mov r8, r1
mov r1, #2
mov r6, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
ldr r10, [r8, r6]
mov r1, r10
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
str r9, [fp, #-24]
mov r9, r1
mov r0, r9
bl _printi
mov r1, #4
str r7, [fp, #-28]
mov r7, r1
mov r1, r8
str r8, [fp, #-32]
ldr r8, [fp, #-24]
str r6, [fp, #-36]
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r4, [fp, #-40]
ldr r4, [r6, r5]
mov r1, r4
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
mov r10, r1
mov r1, r10
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r9, [fp, #-44]
ldr r9, [r6, r5]
mov r1, r9
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
str r7, [fp, #-48]
mov r7, r1
mov r0, r7
bl _printi
mov r0, #0
ldr r12, =#48
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
b 1f
.ltorg
1:
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
 