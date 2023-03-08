.data
.text
.global main
main:
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
mov r1, #3
mov r4, r1
mov r1, #5
mov r10, r1
mov r1, #1
mov r9, r1
mov r1, #3
mov r7, r1
mov r1, #97
mov r8, r1
mov r1, #1
mov r6, r1
mov r0, r4
mov r1, r10
mov r2, r9
mov r3, r7
push {r8}
push {r6}
bl wacc_f
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _printc
mov r1, #3
str r9, [fp, #-12]
mov r9, r1
mov r1, #5
str r7, [fp, #-16]
mov r7, r1
mov r1, #1
str r8, [fp, #-20]
mov r8, r1
mov r1, #3
str r6, [fp, #-24]
mov r6, r1
mov r1, #98
str r5, [fp, #-28]
mov r5, r1
mov r1, #0
str r4, [fp, #-32]
mov r4, r1
mov r0, r9
mov r1, r7
mov r2, r8
mov r3, r6
push {r5}
push {r4}
bl wacc_f
str r10, [fp, #-36]
mov r10, r0
mov r1, r10
str r9, [fp, #-40]
mov r9, r1
mov r1, r9
str r7, [fp, #-44]
mov r7, r1
mov r0, r7
bl _printc
mov r0, #0
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

wacc_f:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#68
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r9, r2
mov r7, r3
ldr r8, [fp, #12]
ldr r6, [fp, #8]
mov r1, r4
mov r5, r1
mov r1, r10
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
adds r5, r1, r2
blvs _errOverflow
mov r1, r5
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
str r9, [fp, #-12]
mov r9, r1
mov r1, r7
str r7, [fp, #-16]
mov r7, r1
mov r1, r9
mov r2, r7
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
str r8, [fp, #-20]
mov r8, r1
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #8]
str r5, [fp, #-28]
mov r5, r1
cmp r5, #1
bne .L0
mov r1, r4
str r4, [fp, #-32]
ldr r4, [fp, #-20]
str r10, [fp, #-36]
mov r10, r1
mov r1, r10
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-36]
str r7, [fp, #-44]
mov r7, r1
mov r1, r8
str r8, [fp, #-48]
mov r8, r1
mov r1, r7
mov r2, r8
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
mov r1, r10
mov r2, r7
subs r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r10, r1
mov r0, r10
b 0f
str r10, [fp, #-52]
mov r10, r9
str r4, [fp, #-20]
ldr r4, [fp, #-32]
str r5, [fp, #-56]
ldr r5, [fp, #-28]
str r7, [fp, #-60]
ldr r7, [fp, #-44]
str r8, [fp, #-64]
ldr r8, [fp, #-48]
str r9, [fp, #-36]
ldr r9, [fp, #-40]
b .L1
.L0:
mov r1, r9
ldr r9, [fp, #-20]
mov r8, r1
mov r0, r8
b 0f
str r8, [fp, #-68]
ldr r8, [fp, #0]
str r9, [fp, #-20]
ldr r9, [fp, #0]
b 1f
.ltorg
1:
.L1:
0:
ldr r12, =#68
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
