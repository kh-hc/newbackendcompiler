.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
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
mov r1, #104
mov r9, r1
str r9, [r4, #0]
mov r1, #105
mov r7, r1
str r7, [r4, #4]
mov r1, #33
mov r8, r1
str r8, [r4, #8]
mov r1, r4
mov r6, r1
mov r1, r6
mov r5, r1
mov r0, r5
bl wacc_f
str r4, [fp, #-4]
mov r4, r0
mov r1, r4
mov r10, r1
mov r0, #0
ldr r12, =#4
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
ldr r12, =#44
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, #0
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r8
ldr r6, [r1, #-4]
mov r8, r6
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
bne .L1
.L0:
mov r1, #4
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r9
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-12]
ldr r9, [r4, r10]
mov r1, r9
push {r1}
mov r3, r10
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r10
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _printc
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-12]
mov r6, r1
mov r1, #1
str r5, [fp, #-24]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r8, r1
mov r1, r8
str r4, [fp, #-28]
ldr r4, [fp, #-16]
mov r4, r1
mov r1, r10
str r10, [fp, #-32]
ldr r10, [fp, #-4]
ldr r9, [fp, #-20]
mov r9, r1
mov r1, r9
str r7, [fp, #-36]
ldr r7, [r1, #-4]
mov r9, r7
mov r1, r4
mov r2, r9
cmp r1, r2
movlt r4, #1
movge r4, #0
cmp r4, #1
str r10, [fp, #-4]
ldr r10, [fp, #-8]
str r4, [fp, #-16]
ldr r4, [fp, #-4]
ldr r7, [fp, #-16]
mov r1, r8
mov r8, r9
mov r9, r1
b 1f
.ltorg
1:
str r5, [fp, #-40]
str r6, [fp, #-44]
beq .L0
.L1:
mov r1, #0
mov r6, r1
mov r0, r6
b 0f
0:
ldr r12, =#44
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
