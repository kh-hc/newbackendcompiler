.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#64
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #2
mov r4, r1
mov r1, #3
mov r10, r1
mov r1, r4
mov r2, r10
adds r4, r1, r2
blvs _errOverflow
mov r1, #2
mov r9, r1
mov r1, r4
mov r2, r9
adds r4, r1, r2
blvs _errOverflow
mov r1, #1
mov r7, r1
mov r1, r4
mov r2, r7
adds r4, r1, r2
blvs _errOverflow
mov r1, #1
mov r8, r1
mov r1, r4
mov r2, r8
adds r4, r1, r2
blvs _errOverflow
mov r1, #1
mov r6, r1
mov r1, r4
mov r2, r6
adds r4, r1, r2
blvs _errOverflow
mov r1, #1
mov r5, r1
mov r1, #2
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
adds r5, r1, r2
blvs _errOverflow
mov r1, #3
str r10, [fp, #-8]
mov r10, r1
mov r1, #4
str r9, [fp, #-12]
mov r9, r1
mov r1, #6
str r7, [fp, #-16]
mov r7, r1
mov r1, r9
mov r2, r7
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r9, r0
pop {r1}
mov r1, r10
mov r2, r9
subs r10, r1, r2
blvs _errOverflow
mov r1, r5
mov r2, r10
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, #2
str r8, [fp, #-20]
mov r8, r1
mov r1, #18
str r6, [fp, #-24]
mov r6, r1
mov r1, #17
str r5, [fp, #-28]
mov r5, r1
mov r1, r6
mov r2, r5
subs r6, r1, r2
blvs _errOverflow
mov r1, r8
mov r2, r6
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, #3
str r4, [fp, #-32]
b 1f
.ltorg
1:
mov r4, r1
mov r1, #4
str r10, [fp, #-36]
mov r10, r1
mov r1, r4
mov r2, r10
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
mov r1, #4
str r9, [fp, #-40]
mov r9, r1
mov r1, r4
mov r2, r9
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r4, r0
pop {r1}
mov r1, #6
str r7, [fp, #-44]
mov r7, r1
mov r1, r4
mov r2, r7
adds r4, r1, r2
blvs _errOverflow
mov r1, r8
mov r2, r4
adds r8, r1, r2
blvs _errOverflow
mov r1, r8
str r8, [fp, #-48]
ldr r8, [fp, #-28]
mov r2, r6
str r6, [fp, #-52]
ldr r6, [fp, #-48]
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r8, r0
pop {r1}
mov r1, r5
str r5, [fp, #-56]
ldr r5, [fp, #-4]
mov r2, r8
subs r5, r1, r2
blvs _errOverflow
mov r1, r5
str r4, [fp, #-60]
mov r4, r1
mov r1, r4
str r10, [fp, #-64]
mov r10, r1
mov r0, r10
bl exit
mov r0, #0
ldr r12, =#64
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
	@ length of .L._errDivZero_str0
		.word 40
.L._errDivZero_str0:
	.asciz "#runtime_error#\n"
.text
_errDivZero:
	ldr r0, =.L._errDivZero_str0
	bl _prints
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
