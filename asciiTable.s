.data
  .word 2
.L.str1:
    .asciz "-"
  .word 1
.L.str2:
    .asciz ""
  .word 30
.L.str0:
    .asciz "Ascii character lookup table:"
  .word 4
.L.str3:
    .asciz "|  "
  .word 4
.L.str6:
    .asciz "  |"
  .word 2
.L.str4:
    .asciz " "
  .word 4
.L.str5:
    .asciz " = "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#36
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
mov r1, #13
mov r10, r1
mov r0, r10
bl wacc_printLine
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, #32
mov r8, r1
mov r1, r8
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, #127
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
bne .L1
.L0:
mov r1, r6
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl wacc_printMap
str r9, [fp, #-12]
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r6
str r7, [fp, #-16]
mov r7, r1
mov r1, #1
str r8, [fp, #-20]
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, #127
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
str r10, [fp, #-24]
ldr r10, [fp, #-8]
str r7, [fp, #-28]
ldr r7, [fp, #-16]
str r8, [fp, #-32]
ldr r8, [fp, #-20]
str r9, [fp, #-36]
ldr r9, [fp, #-12]
beq .L0
.L1:
mov r1, #13
mov r9, r1
mov r0, r9
bl wacc_printLine
mov r8, r0
mov r1, r8
mov r7, r1
mov r0, #0
ldr r12, =#36
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

wacc_printLine:
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
mov r4, r0
mov r1, #0
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
bne .L3
.L2:
ldr r1, =.L.str1
mov r6, r1
mov r0, r6
bl _prints
mov r1, r9
mov r5, r1
mov r1, #1
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
adds r5, r1, r2
blvs _errOverflow
mov r1, r5
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
str r10, [fp, #-4]
ldr r10, [fp, #-8]
str r4, [fp, #-12]
ldr r4, [fp, #-4]
str r5, [fp, #-16]
str r6, [fp, #-20]
beq .L2
.L3:
ldr r1, =.L.str2
mov r6, r1
mov r0, r6
bl _prints
mov r1, #1
mov r5, r1
mov r0, r5
b 0f
0:
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

wacc_printMap:
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
mov r4, r0
ldr r1, =.L.str3
mov r10, r1
mov r0, r10
bl _prints
mov r1, r4
mov r9, r1
mov r1, #100
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movlt r9, #1
movge r9, #0
cmp r9, #1
bne .L4
ldr r1, =.L.str4
mov r8, r1
mov r0, r8
bl _prints
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L5
.L4:
.L5:
mov r1, r4
mov r9, r1
mov r0, r9
bl _printi
ldr r1, =.L.str5
mov r8, r1
mov r0, r8
bl _prints
mov r1, r4
mov r7, r1
mov r1, r7
mov r7, r1
mov r0, r7
bl _printc
ldr r1, =.L.str6
mov r6, r1
mov r0, r6
bl _prints
mov r1, #1
mov r5, r1
mov r0, r5
b 0f
0:
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
