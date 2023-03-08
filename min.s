.data
  .word 13
.L.str0:
    .asciz "min value = "
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
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #10
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, #17
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, #0
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movgt r5, #1
movle r5, #0
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, #0
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movgt r10, #1
movle r10, #0
mov r1, r5
mov r2, r10
and r5, r1, r2
cmp r5, #1
bne .L1
.L0:
mov r1, r7
str r7, [fp, #-16]
mov r7, r1
mov r1, #1
str r8, [fp, #-20]
mov r8, r1
mov r1, r7
mov r2, r8
subs r7, r1, r2
blvs _errOverflow
mov r1, r7
str r6, [fp, #-24]
ldr r6, [fp, #-16]
mov r6, r1
mov r1, r5
str r5, [fp, #-28]
ldr r5, [fp, #-24]
str r4, [fp, #-32]
mov r4, r1
mov r1, #1
str r10, [fp, #-36]
mov r10, r1
mov r1, r4
mov r2, r10
subs r4, r1, r2
blvs _errOverflow
mov r1, r4
mov r5, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-8]
str r7, [fp, #-44]
mov r7, r1
mov r1, #1
str r8, [fp, #-48]
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r9, r1
mov r1, r5
str r6, [fp, #-16]
ldr r6, [fp, #-28]
mov r6, r1
mov r1, #0
str r5, [fp, #-24]
ldr r5, [fp, #-32]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movgt r6, #1
movle r6, #0
mov r1, r4
b 1f
.ltorg
1:
str r4, [fp, #-52]
ldr r4, [fp, #-16]
str r10, [fp, #-56]
ldr r10, [fp, #-36]
mov r10, r1
mov r1, #0
str r9, [fp, #-8]
ldr r9, [fp, #-40]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movgt r10, #1
movle r10, #0
mov r1, r6
mov r2, r10
and r6, r1, r2
cmp r6, #1
mov r1, r4
mov r4, r5
mov r5, r1
mov r1, r5
mov r5, r6
mov r6, r1
str r6, [fp, #-16]
ldr r6, [fp, #-24]
str r7, [fp, #-60]
ldr r7, [fp, #-16]
str r8, [fp, #-64]
ldr r8, [fp, #-20]
beq .L0
.L1:
ldr r1, =.L.str0
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
ldr r7, [fp, #-8]
mov r6, r1
mov r0, r6
bl _printi
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
