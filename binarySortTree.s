.data
  .word 11
.L.str1:
    .asciz "There are "
  .word 11
.L.str2:
    .asciz " integers."
  .word 48
.L.str0:
    .asciz "Please enter the number of integers to insert: "
  .word 37
.L.str3:
    .asciz "Please enter the number at position "
  .word 1
.L.str6:
    .asciz ""
  .word 4
.L.str4:
    .asciz " : "
  .word 30
.L.str5:
    .asciz "Here are the numbers sorted: "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#92
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
ldr r1, =.L.str0
mov r9, r1
mov r0, r9
bl _prints
bl _readi
mov r10, r0
ldr r1, =.L.str1
mov r7, r1
mov r0, r7
bl _prints
mov r1, r10
mov r8, r1
mov r0, r8
bl _printi
ldr r1, =.L.str2
mov r6, r1
mov r0, r6
bl _prints
mov r1, #0
mov r5, r1
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, #0
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r1, r4
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
bne .L1
.L0:
mov r1, #0
str r5, [fp, #-28]
mov r5, r1
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
ldr r1, =.L.str3
str r10, [fp, #-36]
mov r10, r1
mov r0, r10
bl _prints
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-32]
str r7, [fp, #-44]
mov r7, r1
mov r1, #1
str r8, [fp, #-8]
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r0, r7
bl _printi
ldr r1, =.L.str4
str r6, [fp, #-48]
mov r6, r1
mov r0, r6
bl _prints
bl _readi
mov r4, r0
mov r1, r5
str r5, [fp, #-52]
ldr r5, [fp, #-40]
str r4, [fp, #-56]
mov r4, r1
mov r1, r10
str r10, [fp, #-60]
ldr r10, [fp, #-56]
str r9, [fp, #-32]
mov r9, r1
b 1f
.ltorg
1:
mov r0, r4
mov r1, r9
bl wacc_insert
str r7, [fp, #-64]
mov r7, r0
mov r1, r7
mov r5, r1
mov r1, r8
str r8, [fp, #-68]
ldr r8, [fp, #-32]
str r6, [fp, #-72]
mov r6, r1
mov r1, #1
str r5, [fp, #-40]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r8, r1
mov r1, r8
str r4, [fp, #-76]
ldr r4, [fp, #-44]
mov r4, r1
mov r1, r10
str r10, [fp, #-56]
ldr r10, [fp, #-8]
str r9, [fp, #-80]
ldr r9, [fp, #-48]
mov r9, r1
mov r1, r4
mov r2, r9
cmp r1, r2
movlt r4, #1
movge r4, #0
cmp r4, #1
str r10, [fp, #-8]
ldr r10, [fp, #-36]
mov r1, r4
mov r4, r8
mov r8, r1
str r5, [fp, #-84]
ldr r5, [fp, #-28]
str r6, [fp, #-88]
mov r6, r9
str r7, [fp, #-92]
mov r7, r8
str r8, [fp, #-44]
ldr r8, [fp, #-8]
str r9, [fp, #-48]
ldr r9, [fp, #-40]
beq .L0
.L1:
ldr r1, =.L.str5
mov r9, r1
mov r0, r9
bl _prints
mov r1, r9
mov r8, r1
mov r0, r8
bl wacc_printTree
mov r7, r0
mov r1, r7
mov r4, r1
ldr r1, =.L.str6
mov r6, r1
mov r0, r6
bl _prints
mov r0, #0
ldr r12, =#92
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

wacc_createNewNode:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
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
mov r9, r2
mov r0, #8
bl malloc
mov r7, r0
mov r1, r10
cmp r7, #0
bleq _errNull
mov r8, r1
str r8, [r7, #0]
mov r1, r9
cmp r7, #0
bleq _errNull
mov r6, r1
str r6, [r7, #4]
mov r1, r7
mov r5, r1
str r4, [fp, #-4]
mov r0, #8
bl malloc
mov r4, r0
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
cmp r4, #0
bleq _errNull
str r9, [fp, #-12]
mov r9, r1
str r9, [r4, #0]
mov r1, r5
cmp r4, #0
bleq _errNull
str r7, [fp, #-16]
mov r7, r1
str r7, [r4, #4]
mov r1, r4
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
b 0f
0:
ldr r12, =#16
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

wacc_insert:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#80
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
mov r1, #0
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L4
mov r1, r10
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, #0
mov r5, r1
mov r0, r8
mov r1, r6
mov r2, r5
bl wacc_createNewNode
str r4, [fp, #-4]
mov r4, r0
mov r1, r4
str r10, [fp, #-8]
ldr r10, [fp, #-4]
mov r10, r1
str r10, [fp, #-4]
ldr r10, [fp, #-8]
str r4, [fp, #-12]
ldr r4, [fp, #-4]
str r5, [fp, #-16]
str r6, [fp, #-20]
str r7, [fp, #-24]
str r8, [fp, #-28]
str r9, [fp, #-32]
b .L5
.L4:
ldr r9, [r4, #4]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
mov r4, r1
mov r1, r10
mov r10, r1
mov r1, r6
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movlt r10, #1
movge r10, #0
cmp r10, #1
bne .L2
ldr r7, [r8, #0]
mov r1, r7
cmp r8, #0
bleq _errNull
mov r4, r1
mov r1, r4
str r6, [fp, #-36]
mov r6, r1
mov r1, r10
str r5, [fp, #-40]
mov r5, r1
mov r0, r6
mov r1, r5
bl wacc_insert
str r4, [fp, #-44]
mov r4, r0
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-48]
mov r10, r1
str r10, [r8, #0]
ldr r10, [fp, #0]
str r4, [fp, #-52]
ldr r4, [fp, #-44]
str r5, [fp, #-56]
ldr r5, [fp, #-40]
str r6, [fp, #-60]
b 1f
.ltorg
1:
ldr r6, [fp, #-36]
str r9, [fp, #-64]
b .L3
.L2:
ldr r9, [r8, #4]
mov r1, r9
cmp r8, #0
bleq _errNull
mov r4, r1
mov r1, r4
mov r6, r1
mov r1, r10
mov r5, r1
mov r0, r6
mov r1, r5
bl wacc_insert
mov r4, r0
mov r1, r4
cmp r8, #0
bleq _errNull
mov r10, r1
str r10, [r8, #4]
str r4, [fp, #-68]
ldr r4, [fp, #0]
str r5, [fp, #-72]
ldr r5, [fp, #0]
str r6, [fp, #-76]
ldr r6, [fp, #0]
.L3:
str r4, [fp, #-44]
ldr r4, [fp, #0]
str r5, [fp, #-40]
str r6, [fp, #-36]
str r8, [fp, #-80]
.L5:
mov r1, r4
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#80
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

wacc_printTree:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#56
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L6
mov r1, #0
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-4]
str r7, [fp, #-8]
str r9, [fp, #-12]
b .L7
.L6:
ldr r9, [r4, #4]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r10, [r7, #0]
mov r1, r10
cmp r7, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
bl wacc_printTree
mov r5, r0
mov r1, r5
str r4, [fp, #-16]
mov r4, r1
str r7, [fp, #-20]
ldr r7, [r9, #0]
mov r1, r7
ldr r9, [fp, #-16]
cmp r9, #0
bleq _errNull
mov r4, r1
mov r1, r4
mov r10, r1
mov r0, r10
bl _printi
mov r1, #32
str r8, [fp, #-24]
mov r8, r1
mov r0, r8
bl _printc
str r5, [fp, #-32]
ldr r5, [r6, #4]
mov r1, r5
str r6, [fp, #-28]
ldr r6, [fp, #-20]
cmp r6, #0
bleq _errNull
str r4, [fp, #-36]
ldr r4, [fp, #-24]
mov r4, r1
mov r1, r4
str r9, [fp, #-16]
mov r9, r1
mov r0, r9
bl wacc_printTree
mov r7, r0
mov r1, r7
str r10, [fp, #-40]
ldr r10, [fp, #-36]
mov r10, r1
mov r1, #0
str r8, [fp, #-44]
mov r8, r1
mov r0, r8
b 0f
str r4, [fp, #-24]
ldr r4, [fp, #-16]
str r10, [fp, #-36]
str r6, [fp, #-20]
str r7, [fp, #-48]
str r8, [fp, #-52]
str r9, [fp, #-56]
.L7:
0:
ldr r12, =#56
adds sp, sp, r12
b 1f
.ltorg
1:
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
    
