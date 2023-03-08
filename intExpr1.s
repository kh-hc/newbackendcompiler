.data
  .word 8
.L.str0:
    .asciz "Correct"
  .word 6
.L.str1:
    .asciz "Wrong"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#20
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #10
mov r4, r1
mov r1, #1
mov r10, r1
mov r1, r4
mov r2, r10
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
mov r1, #2
mov r9, r1
mov r1, #15
mov r7, r1
mov r1, r9
mov r2, r7
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r1, r4
mov r2, r9
adds r4, r1, r2
blvs _errOverflow
mov r1, r4
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, #40
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L0
ldr r1, =.L.str0
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
str r4, [fp, #-8]
ldr r4, [fp, #-4]
str r5, [fp, #-12]
str r6, [fp, #-16]
b .L1
.L0:
ldr r1, =.L.str1
mov r6, r1
mov r0, r6
bl _prints
str r6, [fp, #-20]
.L1:
mov r0, #0
ldr r12, =#20
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
