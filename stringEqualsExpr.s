.data
  .word 6
.L.str0:
    .asciz "Hello"
  .word 4
.L.str2:
    .asciz "bar"
  .word 4
.L.str1:
    .asciz "foo"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#40
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
mov r1, r4
mov r10, r1
ldr r1, =.L.str1
mov r9, r1
mov r1, r9
mov r7, r1
ldr r1, =.L.str2
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r10
mov r5, r1
mov r1, r10
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
mov r1, r5
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _printb
mov r1, r7
str r7, [fp, #-16]
ldr r7, [fp, #-8]
str r8, [fp, #-20]
mov r8, r1
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-16]
str r5, [fp, #-28]
mov r5, r1
mov r1, r8
mov r2, r5
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r0, r8
bl _printb
mov r1, r6
str r4, [fp, #-32]
mov r4, r1
mov r1, r10
str r10, [fp, #-36]
ldr r10, [fp, #-24]
str r9, [fp, #-40]
mov r9, r1
mov r1, r4
mov r2, r9
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r0, r4
bl _printb
mov r0, #0
ldr r12, =#40
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