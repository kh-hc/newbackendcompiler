.data
  .word 5
.L.str0:
    .asciz "here"
  .word 9
.L.str1:
    .asciz "not here"
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
mov r1, #1
mov r4, r1
cmp r4, #1
bne .L0
ldr r1, =.L.str0
mov r10, r1
mov r0, r10
bl _prints
str r10, [fp, #-4]
str r4, [fp, #-8]
b .L1
.L0:
ldr r1, =.L.str1
mov r4, r1
mov r0, r4
bl _prints
str r4, [fp, #-12]
.L1:
mov r0, #0
ldr r12, =#12
adds sp, sp, r12
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
