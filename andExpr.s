.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#12
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
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, r7
mov r6, r1
mov r1, r8
mov r2, r6
and r8, r1, r2
mov r0, r8
bl _printb
mov r1, r10
mov r5, r1
mov r1, #1
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
and r5, r1, r2
mov r0, r5
bl _printb
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, #0
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
and r10, r1, r2
mov r0, r10
bl _printb
mov r0, #0
ldr r12, =#12
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
