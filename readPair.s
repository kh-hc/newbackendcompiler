.data
  .word 40
.L.str0:
    .asciz "Please enter the first element (char): "
  .word 23
.L.str2:
    .asciz "The first element was "
  .word 40
.L.str1:
    .asciz "Please enter the second element (int): "
  .word 24
.L.str3:
    .asciz "The second element was "
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
mov r0, #8
bl malloc
mov r4, r0
mov r1, #0
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
ldr r1, =.L.str0
mov r8, r1
mov r0, r8
bl _prints
mov r1, #48
mov r6, r1
mov r1, r6
mov r5, r1
bl _readc
mov r5, r0
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
str r4, [r7, #0]
ldr r1, =.L.str1
mov r10, r1
mov r0, r10
bl _prints
mov r1, #0
mov r9, r1
mov r1, r9
str r7, [fp, #-8]
mov r7, r1
bl _readi
mov r7, r0
mov r1, r7
str r8, [fp, #-12]
ldr r8, [fp, #-8]
cmp r8, #0
bleq _errNull
str r6, [fp, #-16]
mov r6, r1
str r6, [r8, #4]
mov r1, #0
str r5, [fp, #-20]
mov r5, r1
mov r1, r5
ldr r4, [fp, #-20]
mov r4, r1
mov r1, #-1
str r10, [fp, #-24]
mov r10, r1
mov r1, r10
mov r7, r1
ldr r1, =.L.str2
str r9, [fp, #-28]
mov r9, r1
mov r0, r9
bl _prints
str r7, [fp, #-32]
ldr r7, [r8, #0]
mov r1, r7
cmp r8, #0
bleq _errNull
mov r4, r1
mov r1, r4
str r8, [fp, #-8]
mov r8, r1
mov r0, r8
bl _printc
ldr r1, =.L.str3
mov r6, r1
mov r0, r6
bl _prints
str r4, [fp, #-20]
ldr r4, [r5, #4]
mov r1, r4
str r5, [fp, #-36]
ldr r5, [fp, #-8]
cmp r5, #0
bleq _errNull
str r10, [fp, #-40]
b 1f
.ltorg
1:
ldr r10, [fp, #-32]
mov r10, r1
mov r1, r10
str r9, [fp, #-44]
mov r9, r1
mov r0, r9
bl _printi
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
    .word 2
.L._printc_str0:
	.asciz "%c"
.text
_printc:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printc_str0
	bl printf
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
    
