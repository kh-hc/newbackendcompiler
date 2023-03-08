.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#128
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
adds r4, r1, r2
blvs _errOverflow
mov r1, r4
mov r9, r1
mov r1, #3
mov r7, r1
mov r1, #4
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r6, r1
mov r1, #5
mov r5, r1
mov r1, #6
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
adds r5, r1, r2
blvs _errOverflow
mov r1, r5
str r10, [fp, #-8]
mov r10, r1
mov r1, #7
str r9, [fp, #-12]
mov r9, r1
mov r1, #8
str r7, [fp, #-16]
mov r7, r1
mov r1, r9
mov r2, r7
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
str r8, [fp, #-20]
mov r8, r1
mov r1, #9
str r6, [fp, #-24]
mov r6, r1
mov r1, #10
str r5, [fp, #-28]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
str r4, [fp, #-32]
mov r4, r1
mov r1, #11
str r10, [fp, #-36]
mov r10, r1
mov r1, #12
str r9, [fp, #-40]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
str r7, [fp, #-44]
mov r7, r1
mov r1, #13
str r8, [fp, #-48]
mov r8, r1
mov r1, #14
str r6, [fp, #-52]
mov r6, r1
mov r1, r8
mov r2, r6
adds r8, r1, r2
blvs _errOverflow
mov r1, r8
str r5, [fp, #-56]
mov r5, r1
mov r1, #15
str r4, [fp, #-60]
mov r4, r1
mov r1, #16
str r10, [fp, #-64]
b 1f
.ltorg
1:
mov r10, r1
mov r1, r4
mov r2, r10
adds r4, r1, r2
blvs _errOverflow
mov r1, r4
str r9, [fp, #-68]
mov r9, r1
mov r1, #17
str r7, [fp, #-72]
mov r7, r1
mov r1, r7
str r8, [fp, #-76]
mov r8, r1
mov r1, r6
str r6, [fp, #-80]
ldr r6, [fp, #-12]
str r5, [fp, #-84]
mov r5, r1
mov r1, r4
str r4, [fp, #-88]
ldr r4, [fp, #-24]
str r10, [fp, #-92]
mov r10, r1
mov r1, r5
mov r2, r10
adds r5, r1, r2
blvs _errOverflow
mov r1, r9
str r9, [fp, #-96]
ldr r9, [fp, #-36]
str r7, [fp, #-100]
mov r7, r1
mov r1, r5
mov r2, r7
adds r5, r1, r2
blvs _errOverflow
mov r1, r8
str r8, [fp, #-104]
ldr r8, [fp, #-48]
str r6, [fp, #-12]
mov r6, r1
mov r1, r5
mov r2, r6
adds r5, r1, r2
blvs _errOverflow
mov r1, r5
str r5, [fp, #-108]
ldr r5, [fp, #-60]
str r4, [fp, #-24]
mov r4, r1
mov r1, r10
str r10, [fp, #-112]
ldr r10, [fp, #-108]
mov r2, r4
adds r10, r1, r2
blvs _errOverflow
mov r1, r9
str r9, [fp, #-36]
ldr r9, [fp, #-72]
str r7, [fp, #-116]
mov r7, r1
mov r1, r10
mov r2, r7
adds r10, r1, r2
blvs _errOverflow
mov r1, r8
str r8, [fp, #-48]
ldr r8, [fp, #-84]
str r6, [fp, #-120]
mov r6, r1
mov r1, r10
mov r2, r6
adds r10, r1, r2
blvs _errOverflow
mov r1, r5
str r5, [fp, #-60]
ldr r5, [fp, #-96]
str r4, [fp, #-124]
mov r4, r1
mov r1, r10
mov r2, r4
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
str r10, [fp, #-108]
ldr r10, [fp, #-104]
str r9, [fp, #-72]
mov r9, r1
mov r1, r7
str r7, [fp, #-128]
ldr r7, [fp, #-108]
mov r2, r9
adds r7, r1, r2
blvs _errOverflow
mov r0, r7
bl exit
mov r0, #0
ldr r12, =#128
adds sp, sp, r12
pop {r9}
pop {r8}
b 1f
.ltorg
1:
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
