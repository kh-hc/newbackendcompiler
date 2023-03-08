.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#116
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #4
mov r0, r1
bl malloc
mov r4, r0
mov r1, #0
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
mov r1, r4
mov r9, r1
mov r1, #12
mov r0, r1
bl malloc
mov r7, r0
mov r1, #2
mov r8, r1
str r8, [r7, #0]
mov r1, r7
mov r2, #4
adds r7, r1, r2
blvs _errOverflow
mov r1, r9
mov r6, r1
str r6, [r7, #0]
mov r1, r9
mov r5, r1
str r5, [r7, #4]
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r1, #0
mov r10, r1
mov r1, r10
str r9, [fp, #-8]
mov r9, r1
mov r1, r9
str r7, [fp, #-12]
mov r7, r1
mov r1, #2
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
bne .L1
.L0:
mov r1, #8
mov r0, r1
bl malloc
mov r6, r0
mov r1, #1
mov r5, r1
str r5, [r6, #0]
mov r1, r6
mov r2, #4
adds r6, r1, r2
blvs _errOverflow
mov r1, r9
str r4, [fp, #-16]
mov r4, r1
str r4, [r6, #0]
mov r1, r6
str r10, [fp, #-20]
mov r10, r1
mov r1, #4
str r9, [fp, #-24]
mov r9, r1
mov r1, r7
str r7, [fp, #-28]
ldr r7, [fp, #-16]
str r8, [fp, #-32]
mov r8, r1
mov r1, r6
str r6, [fp, #-36]
ldr r6, [fp, #-24]
mov r5, r1
mov r1, r5
mov r2, r9
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, r10
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
b 1f
.ltorg
1:
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r4, r1
str r4, [r8, r5]
mov r1, r6
str r10, [fp, #-40]
mov r10, r1
mov r1, #1
str r9, [fp, #-44]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r6, r1
mov r1, r6
str r7, [fp, #-16]
ldr r7, [fp, #-28]
mov r7, r1
mov r1, #2
str r8, [fp, #-48]
ldr r8, [fp, #-32]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
str r10, [fp, #-52]
ldr r10, [fp, #-20]
ldr r4, [fp, #-16]
str r9, [fp, #-56]
mov r9, r6
str r5, [fp, #-60]
str r6, [fp, #-24]
beq .L0
.L1:
mov r1, #4
mov r6, r1
mov r1, r4
mov r5, r1
mov r1, #0
mov r9, r1
mov r1, r9
mov r2, r6
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
ldr r4, [r5, r9]
mov r1, r4
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r5, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r10, r1
mov r1, #4
str r7, [fp, #-28]
mov r7, r1
mov r1, r4
str r8, [fp, #-32]
mov r8, r1
mov r1, #1
str r6, [fp, #-64]
mov r6, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r5, [fp, #-68]
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
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-72]
b 1f
.ltorg
1:
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
mov r0, r10
bl _printb
mov r1, #4
str r4, [fp, #-16]
mov r4, r1
mov r1, r10
str r10, [fp, #-76]
ldr r10, [fp, #-16]
str r7, [fp, #-80]
mov r7, r1
mov r1, #0
str r8, [fp, #-84]
mov r8, r1
mov r1, r8
mov r2, r4
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-88]
ldr r6, [r7, r8]
mov r1, r6
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r5, r1
mov r1, r5
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
mov r2, r4
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r9, [fp, #-92]
ldr r9, [r7, r8]
mov r1, r9
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r4, [fp, #-96]
mov r4, r1
mov r0, r4
bl _printi
mov r1, #4
str r10, [fp, #-16]
mov r10, r1
mov r1, r7
str r7, [fp, #-100]
ldr r7, [fp, #-16]
str r8, [fp, #-104]
mov r8, r1
mov r1, #1
mov r6, r1
mov r1, r6
mov r2, r10
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r5, [fp, #-108]
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
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r9, r1
mov r1, r9
mov r8, r1
b 1f
.ltorg
1:
mov r1, #0
mov r6, r1
mov r1, r6
mov r2, r10
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r4, [fp, #-112]
ldr r4, [r8, r6]
mov r1, r4
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
str r10, [fp, #-116]
mov r10, r1
mov r0, r10
bl _printi
mov r0, #0
ldr r12, =#116
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
    .word 5
.L._printb_str0:
    .asciz "false"
    .word 4
.L._printb_str1:
    .asciz "true"
    .word 4
.L._printb_str2:
    .asciz "%.*s"
.text
_printb:
    push {lr}
    push {r1, r2}
    cmp r0, #0
    bne .L_printb0
    ldr r2, =.L._printb_str0
    b .L_printb1
    .ltorg
.L_printb0:
    ldr r2, =.L._printb_str1
.L_printb1:
    ldr r1, [r2, #-4]
    ldr r0, =.L._printb_str2
    bl printf
    mov r0, #0
    bl fflush
    pop {r1, r2}
    pop {pc}
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
 
