.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#52
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #1
mov r4, r1
mov r1, #2
mov r10, r1
mov r1, r4
mov r2, r10
subs r4, r1, r2
blvs _errOverflow
mov r1, #3
mov r9, r1
mov r1, r4
mov r2, r9
adds r4, r1, r2
blvs _errOverflow
mov r1, #4
mov r7, r1
mov r1, r4
mov r2, r7
subs r4, r1, r2
blvs _errOverflow
mov r1, #5
mov r8, r1
mov r1, r4
mov r2, r8
adds r4, r1, r2
blvs _errOverflow
mov r1, #6
mov r6, r1
mov r1, r4
mov r2, r6
subs r4, r1, r2
blvs _errOverflow
mov r1, #7
mov r5, r1
mov r1, r4
mov r2, r5
adds r4, r1, r2
blvs _errOverflow
mov r1, #8
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
mov r2, r4
subs r10, r1, r2
blvs _errOverflow
mov r1, #9
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, #10
str r7, [fp, #-16]
mov r7, r1
mov r1, r10
mov r2, r7
subs r10, r1, r2
blvs _errOverflow
mov r1, #11
str r8, [fp, #-20]
mov r8, r1
mov r1, r10
mov r2, r8
adds r10, r1, r2
blvs _errOverflow
mov r1, #12
str r6, [fp, #-24]
mov r6, r1
mov r1, r10
mov r2, r6
subs r10, r1, r2
blvs _errOverflow
mov r1, #13
str r5, [fp, #-28]
mov r5, r1
mov r1, r10
mov r2, r5
adds r10, r1, r2
blvs _errOverflow
mov r1, #14
str r4, [fp, #-32]
mov r4, r1
mov r1, r10
mov r2, r4
subs r10, r1, r2
blvs _errOverflow
b 1f
.ltorg
1:
mov r1, #15
str r10, [fp, #-4]
mov r10, r1
mov r1, r9
str r9, [fp, #-36]
ldr r9, [fp, #-4]
mov r2, r10
adds r9, r1, r2
blvs _errOverflow
mov r1, #16
str r7, [fp, #-40]
mov r7, r1
mov r1, r9
mov r2, r7
subs r9, r1, r2
blvs _errOverflow
mov r1, #17
str r8, [fp, #-44]
mov r8, r1
mov r1, r9
mov r2, r8
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
str r6, [fp, #-48]
mov r6, r1
mov r1, r6
str r5, [fp, #-52]
mov r5, r1
mov r0, r5
bl exit
mov r0, #0
ldr r12, =#52
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