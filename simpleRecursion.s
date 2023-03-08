.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #8
mov r9, r1
mov r0, r9
bl wacc_rec
mov r7, r0
mov r1, r7
mov r10, r1
mov r0, #0
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_rec:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L0
str r10, [fp, #-4]
str r9, [fp, #-8]
b .L1
.L0:
mov r1, r4
mov r9, r1
mov r1, #1
mov r10, r1
mov r1, r9
mov r2, r10
subs r9, r1, r2
blvs _errOverflow
mov r0, r9
bl wacc_rec
mov r7, r0
mov r1, r7
mov r8, r1
str r10, [fp, #-12]
str r7, [fp, #-16]
str r8, [fp, #-20]
str r9, [fp, #-24]
.L1:
mov r1, #42
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#24
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
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
