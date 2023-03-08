.data
  .word 3
.L.str0:
    .asciz "go"
  .word 2
.L.str2:
    .asciz "b"
  .word 2
.L.str1:
    .asciz "a"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r9}
bl wacc_f
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r0, r9
bl _printi
mov r0, #0
pop {r9}
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
ldr r12, =#20
subs sp, sp, r12
push {r10}
push {r4}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
mov r1, #1
mov r10, r1
mov r0, r10
b 0f
mov r1, #1
mov r9, r1
cmp r9, #1
bne .L0
ldr r1, =.L.str1
mov r7, r1
mov r0, r7
bl _prints
mov r1, #2
mov r8, r1
mov r0, r8
b 0f
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L1
.L0:
ldr r1, =.L.str2
mov r9, r1
mov r0, r9
bl _prints
mov r1, #3
mov r8, r1
mov r0, r8
b 0f
str r8, [fp, #-16]
str r9, [fp, #-20]
.L1:
0:
ldr r12, =#20
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
