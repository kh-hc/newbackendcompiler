.data
  .word 9
.L.str0:
    .asciz "list = {"
  .word 2
.L.str2:
    .asciz "}"
  .word 3
.L.str1:
    .asciz ", "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#68
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r0, #8
bl malloc
mov r4, r0
mov r1, #11
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #0
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #4]
mov r1, r4
mov r7, r1
mov r0, #8
bl malloc
mov r8, r0
mov r1, #4
cmp r8, #0
bleq _errNull
mov r6, r1
str r6, [r8, #0]
mov r1, r7
cmp r8, #0
bleq _errNull
mov r5, r1
str r5, [r8, #4]
mov r1, r8
str r4, [fp, #-4]
mov r4, r1
mov r0, #8
bl malloc
mov r10, r0
mov r1, #2
cmp r10, #0
bleq _errNull
mov r9, r1
str r9, [r10, #0]
mov r1, r4
cmp r10, #0
bleq _errNull
str r7, [fp, #-8]
mov r7, r1
str r7, [r10, #4]
mov r1, r10
str r8, [fp, #-12]
mov r8, r1
mov r0, #8
bl malloc
mov r6, r0
mov r1, #1
cmp r6, #0
bleq _errNull
mov r5, r1
str r5, [r6, #0]
mov r1, r8
cmp r6, #0
bleq _errNull
str r4, [fp, #-16]
mov r4, r1
str r4, [r6, #4]
mov r1, r6
str r10, [fp, #-20]
mov r10, r1
ldr r1, =.L.str0
mov r9, r1
mov r0, r9
bl _prints
mov r1, r10
mov r7, r1
str r8, [fp, #-24]
ldr r8, [r7, #4]
mov r1, r8
cmp r7, #0
bleq _errNull
str r6, [fp, #-28]
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
mov r4, r1
mov r1, r6
str r10, [fp, #-32]
mov r10, r1
mov r1, #0
str r9, [fp, #-36]
mov r9, r1
mov r1, r10
b 1f
.ltorg
1:
mov r2, r9
cmp r1, r2
movne r10, #1
moveq r10, #0
cmp r10, #1
bne .L1
.L0:
ldr r8, [r7, #0]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r4, r1
mov r1, r4
str r6, [fp, #-40]
mov r6, r1
mov r0, r6
bl _printi
ldr r1, =.L.str1
str r5, [fp, #-44]
mov r5, r1
mov r0, r5
bl _prints
mov r1, r4
str r4, [fp, #-48]
ldr r4, [fp, #-40]
mov r7, r1
str r10, [fp, #-52]
ldr r10, [r7, #4]
mov r1, r10
cmp r7, #0
bleq _errNull
mov r4, r1
mov r1, r4
str r9, [fp, #-56]
ldr r9, [fp, #-52]
mov r9, r1
mov r1, #0
str r7, [fp, #-60]
ldr r7, [fp, #-56]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
mov r10, r9
str r4, [fp, #-40]
ldr r4, [fp, #-48]
str r5, [fp, #-64]
ldr r5, [fp, #-44]
str r6, [fp, #-68]
ldr r6, [fp, #-40]
str r7, [fp, #-56]
ldr r7, [fp, #-60]
str r9, [fp, #-52]
ldr r9, [fp, #-56]
beq .L0
.L1:
ldr r9, [r7, #0]
mov r1, r9
cmp r7, #0
bleq _errNull
mov r4, r1
mov r1, r4
mov r7, r1
mov r0, r7
bl _printi
ldr r1, =.L.str2
mov r6, r1
mov r0, r6
bl _prints
mov r0, #0
ldr r12, =#68
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
    .word 45
.L._errNull_str0:
	.asciz "fatal error: null pair dereferenced or freed\n"
.text
_errNull:
    ldr r0, =.L._errNull_str0
    bl _prints
    mov r0, #255
    bl exit
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
