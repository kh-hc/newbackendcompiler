.data
  .word 36
.L.str0:
    .asciz "The first 20 fibonacci numbers are:"
  .word 4
.L.str2:
    .asciz "..."
  .word 4
.L.str1:
    .asciz "0, "
  .word 3
.L.str3:
    .asciz ", "
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
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str1
mov r10, r1
mov r0, r10
bl _prints
mov r1, #19
mov r9, r1
mov r1, #1
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_fibonacci
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r0, r5
bl _printi
ldr r1, =.L.str2
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
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

wacc_fibonacci:
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
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, #1
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movle r9, #1
movgt r9, #0
cmp r9, #1
bne .L0
mov r1, r4
mov r8, r1
mov r0, r8
b 0f
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L1
.L0:
.L1:
mov r1, r4
mov r9, r1
mov r1, #1
mov r8, r1
mov r1, r9
mov r2, r8
subs r9, r1, r2
blvs _errOverflow
mov r1, r10
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_fibonacci
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, r10
str r4, [fp, #-16]
mov r4, r1
cmp r4, #1
bne .L2
mov r1, r5
str r10, [fp, #-20]
mov r10, r1
mov r0, r10
bl _printi
ldr r1, =.L.str3
str r9, [fp, #-24]
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-28]
ldr r10, [fp, #-20]
str r4, [fp, #-32]
ldr r4, [fp, #-16]
str r9, [fp, #-36]
ldr r9, [fp, #-24]
b .L3
.L2:
.L3:
mov r1, r4
mov r9, r1
mov r1, #2
mov r4, r1
mov r1, r9
mov r2, r4
subs r9, r1, r2
blvs _errOverflow
mov r1, #0
mov r10, r1
mov r0, r9
mov r1, r10
bl wacc_fibonacci
str r8, [fp, #-40]
mov r8, r0
mov r1, r8
str r7, [fp, #-44]
mov r7, r1
mov r1, r5
str r6, [fp, #-48]
mov r6, r1
mov r1, r7
str r5, [fp, #-52]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
b 1f
.ltorg
1:
mov r0, r6
b 0f
0:
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
