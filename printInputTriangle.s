.data
  .word 48
.L.str0:
    .asciz "Please enter the size of the triangle to print:"
  .word 1
.L.str2:
    .asciz ""
  .word 2
.L.str1:
    .asciz "-"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
mov r1, #0
mov r10, r1
mov r1, r10
mov r9, r1
bl _readi
mov r9, r0
mov r1, r9
mov r7, r1
mov r0, r7
bl wacc_f
mov r8, r0
mov r1, r8
mov r6, r1
mov r0, #0
pop {r9}
pop {r8}
pop {r7}
pop {r6}
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
ldr r12, =#56
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
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
bne .L2
str r10, [fp, #-4]
str r9, [fp, #-8]
b .L3
.L2:
mov r1, r4
mov r9, r1
mov r1, r9
mov r10, r1
mov r1, #0
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movgt r10, #1
movle r10, #0
cmp r10, #1
bne .L1
.L0:
ldr r1, =.L.str1
mov r8, r1
mov r0, r8
bl _prints
mov r1, r9
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r6
mov r2, r5
subs r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r9, r1
mov r1, r9
mov r10, r1
mov r1, #0
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movgt r10, #1
movle r10, #0
cmp r10, #1
str r5, [fp, #-12]
str r6, [fp, #-16]
str r8, [fp, #-20]
beq .L0
.L1:
ldr r1, =.L.str2
mov r8, r1
mov r0, r8
bl _prints
mov r1, r4
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r6
mov r2, r5
subs r6, r1, r2
blvs _errOverflow
mov r0, r6
bl wacc_f
str r4, [fp, #-24]
mov r4, r0
mov r1, r4
str r9, [fp, #-28]
mov r9, r1
str r4, [fp, #-32]
ldr r4, [fp, #-24]
str r10, [fp, #-36]
str r5, [fp, #-40]
str r6, [fp, #-44]
str r7, [fp, #-48]
str r8, [fp, #-52]
str r9, [fp, #-56]
.L3:
mov r1, #0
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#56
adds sp, sp, r12
pop {r9}
b 1f
.ltorg
1:
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
	.word 2
.L._readi_str0:
	.asciz "%d"
.text
_readi:
    push {lr}
    str r0, [sp, #-4]!
    mov r1, sp
    ldr r0, =.L._readi_str0
    bl scanf
    ldr r0, [sp, #0]
	add sp, sp, #4
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
