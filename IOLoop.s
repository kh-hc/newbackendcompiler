.data
  .word 26
.L.str0:
    .asciz "Please input an integer: "
  .word 40
.L.str2:
    .asciz "Do you want to continue entering input?"
  .word 13
.L.str1:
    .asciz "echo input: "
  .word 39
.L.str3:
    .asciz "(enter Y for \'yes\' and N for \'no\')"
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
mov r1, #89
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, #78
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movne r8, #1
moveq r8, #0
cmp r8, #1
bne .L1
.L0:
ldr r1, =.L.str0
mov r5, r1
mov r0, r5
bl _prints
bl _readi
mov r7, r0
ldr r1, =.L.str1
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _printi
ldr r1, =.L.str2
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str3
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
str r8, [fp, #-20]
ldr r8, [fp, #-8]
bl _readc
mov r8, r0
mov r1, r8
str r6, [fp, #-24]
ldr r6, [fp, #-20]
mov r6, r1
mov r1, #78
str r5, [fp, #-28]
ldr r5, [fp, #-24]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movne r6, #1
moveq r6, #0
cmp r6, #1
str r10, [fp, #-32]
mov r10, r8
str r4, [fp, #-36]
ldr r4, [fp, #-4]
mov r1, r6
mov r6, r5
mov r5, r1
str r7, [fp, #-40]
ldr r7, [fp, #-16]
mov r1, r8
mov r8, r5
mov r5, r1
str r9, [fp, #-44]
ldr r9, [fp, #-12]
str r5, [fp, #-8]
beq .L0
.L1:
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
b 1f
.ltorg
1:
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
	.word 3
.L._readc_str0:
	.asciz " %c"
.text
_readc:
	push {lr}
	strb r0, [sp, #-1]!
	mov r1, sp
	ldr r0, =.L._readc_str0
	bl scanf
	ldrsb r0, [sp, #0]
	add sp, sp, #1
	pop {pc}
    .ltorg
