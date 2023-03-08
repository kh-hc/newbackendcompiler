.data
  .word 25
.L.str0:
    .asciz "Using fixed-point real: "
  .word 4
.L.str2:
    .asciz " * "
  .word 4
.L.str1:
    .asciz " / "
  .word 4
.L.str3:
    .asciz " = "
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#72
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
mov r1, r4
mov r10, r1
mov r1, #3
mov r9, r1
mov r1, r9
mov r7, r1
ldr r1, =.L.str0
mov r8, r1
mov r0, r8
bl _prints
mov r1, r10
mov r6, r1
mov r0, r6
bl _printi
ldr r1, =.L.str1
mov r5, r1
mov r0, r5
bl _prints
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _printi
ldr r1, =.L.str2
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
mov r1, r7
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _printi
ldr r1, =.L.str3
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r0, r6
bl wacc_intToFixedPoint
str r5, [fp, #-28]
mov r5, r0
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
mov r1, r4
str r10, [fp, #-36]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-16]
str r7, [fp, #-44]
mov r7, r1
mov r0, r10
mov r1, r7
bl wacc_divideByInt
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r4, r1
mov r1, r4
str r6, [fp, #-48]
mov r6, r1
mov r1, r9
str r5, [fp, #-52]
mov r5, r1
mov r0, r6
mov r1, r5
bl wacc_multiplyByInt
str r4, [fp, #-56]
mov r4, r0
mov r1, r4
str r10, [fp, #-60]
ldr r10, [fp, #-56]
mov r10, r1
mov r1, r10
str r9, [fp, #-16]
mov r9, r1
mov r0, r9
bl wacc_fixedPointToIntRoundNear
str r7, [fp, #-64]
mov r7, r0
b 1f
.ltorg
1:
mov r1, r7
str r8, [fp, #-68]
mov r8, r1
mov r1, r8
str r6, [fp, #-72]
mov r6, r1
mov r0, r6
bl _printi
mov r0, #0
ldr r12, =#72
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

wacc_q:
push {lr}
push {fp}
mov fp, sp
push {r4}
mov r1, #14
mov r4, r1
mov r0, r4
b 0f
0:
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_power:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#32
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
mov r1, #1
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movgt r8, #1
movle r8, #0
cmp r8, #1
bne .L1
.L0:
mov r1, r7
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, r5
mov r7, r1
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r1, #1
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
subs r10, r1, r2
blvs _errOverflow
mov r1, r10
str r7, [fp, #-16]
ldr r7, [fp, #-8]
mov r7, r1
mov r1, r7
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movgt r8, #1
movle r8, #0
cmp r8, #1
str r10, [fp, #-20]
mov r10, r7
str r4, [fp, #-24]
ldr r4, [fp, #-4]
str r7, [fp, #-8]
ldr r7, [fp, #-16]
str r9, [fp, #-28]
ldr r9, [fp, #-12]
str r5, [fp, #-32]
beq .L0
.L1:
mov r1, r7
mov r5, r1
mov r0, r5
b 0f
0:
ldr r12, =#32
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

wacc_f:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
bl wacc_q
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #2
mov r9, r1
mov r1, r10
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_power
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r0, r5
b 0f
0:
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

wacc_intToFixedPoint:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r8}
push {r9}
mov r4, r0
bl wacc_f
mov r10, r0
mov r1, r10
mov r9, r1
mov r1, r4
mov r7, r1
mov r1, r9
mov r8, r1
mov r1, r7
mov r2, r8
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
mov r0, r7
b 0f
0:
pop {r9}
pop {r8}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_fixedPointToIntRoundDown:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r8}
push {r9}
mov r4, r0
bl wacc_f
mov r10, r0
mov r1, r10
mov r9, r1
mov r1, r4
mov r7, r1
mov r1, r9
mov r8, r1
mov r1, r7
mov r2, r8
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r7, r0
pop {r1}
mov r0, r7
b 0f
0:
pop {r9}
pop {r8}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_fixedPointToIntRoundNear:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#48
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
bl wacc_f
mov r10, r0
mov r1, r10
mov r9, r1
mov r1, r4
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movge r7, #1
movlt r7, #0
cmp r7, #1
bne .L2
mov r1, r4
mov r6, r1
mov r1, r9
mov r5, r1
mov r1, #2
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r5, r0
pop {r1}
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r9
str r10, [fp, #-8]
mov r10, r1
mov r1, r6
mov r2, r10
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r6, r0
pop {r1}
mov r0, r6
b 0f
str r10, [fp, #-12]
ldr r10, [fp, #-8]
str r4, [fp, #-16]
ldr r4, [fp, #-4]
str r5, [fp, #-20]
str r6, [fp, #-24]
str r7, [fp, #-28]
str r8, [fp, #-32]
b .L3
.L2:
mov r1, r4
mov r8, r1
mov r1, r9
mov r7, r1
mov r1, #2
mov r6, r1
mov r1, r7
mov r2, r6
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r7, r0
pop {r1}
mov r1, r8
mov r2, r7
subs r8, r1, r2
blvs _errOverflow
mov r1, r9
mov r5, r1
mov r1, r8
mov r2, r5
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
b 1f
.ltorg
1:
bl __aeabi_idivmod
mov r8, r0
pop {r1}
mov r0, r8
b 0f
str r5, [fp, #-36]
str r6, [fp, #-40]
str r7, [fp, #-44]
str r8, [fp, #-48]
.L3:
0:
ldr r12, =#48
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

wacc_add:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r1, r9
mov r2, r7
adds r9, r1, r2
blvs _errOverflow
mov r0, r9
b 0f
0:
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_subtract:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r1, r9
mov r2, r7
subs r9, r1, r2
blvs _errOverflow
mov r0, r9
b 0f
0:
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_addByInt:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
bl wacc_f
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r10
mov r6, r1
mov r1, r7
mov r5, r1
mov r1, r6
mov r2, r5
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, r8
mov r2, r6
adds r8, r1, r2
blvs _errOverflow
mov r0, r8
b 0f
0:
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

wacc_subtractByInt:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
bl wacc_f
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r10
mov r6, r1
mov r1, r7
mov r5, r1
mov r1, r6
mov r2, r5
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, r8
mov r2, r6
subs r8, r1, r2
blvs _errOverflow
mov r0, r8
b 0f
0:
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

wacc_multiply:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
bl wacc_f
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r10
mov r6, r1
mov r1, r8
mov r2, r6
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, r7
mov r5, r1
mov r1, r8
mov r2, r5
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r8, r0
pop {r1}
mov r0, r8
b 0f
0:
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

wacc_multiplyByInt:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r1, r9
mov r2, r7
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r0, r9
b 0f
0:
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_divide:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
bl wacc_f
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r7
mov r6, r1
mov r1, r8
mov r2, r6
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, r10
mov r5, r1
mov r1, r8
mov r2, r5
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r8, r0
pop {r1}
mov r0, r8
b 0f
0:
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

wacc_divideByInt:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r1, r9
mov r2, r7
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r9, r0
pop {r1}
mov r0, r9
b 0f
0:
pop {r9}
pop {r7}
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
	@ length of .L._errDivZero_str0
		.word 40
.L._errDivZero_str0:
	.asciz "#runtime_error#\n"
.text
_errDivZero:
	ldr r0, =.L._errDivZero_str0
	bl _prints
	mov r0, #255
	bl exit
.ltorg

