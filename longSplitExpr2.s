.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#232
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
mov r1, #2
mov r10, r1
mov r1, r4
mov r2, r10
adds r4, r1, r2
blvs _errOverflow
mov r1, #3
mov r9, r1
mov r1, r4
mov r2, r9
adds r4, r1, r2
blvs _errOverflow
mov r1, #4
mov r7, r1
mov r1, r4
mov r2, r7
adds r4, r1, r2
blvs _errOverflow
mov r1, #5
mov r8, r1
mov r1, r4
mov r2, r8
adds r4, r1, r2
blvs _errOverflow
mov r1, #6
mov r6, r1
mov r1, r4
mov r2, r6
adds r4, r1, r2
blvs _errOverflow
mov r1, #7
mov r5, r1
mov r1, r4
mov r2, r5
adds r4, r1, r2
blvs _errOverflow
mov r1, #8
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
mov r2, r4
adds r10, r1, r2
blvs _errOverflow
mov r1, #9
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, #10
str r7, [fp, #-16]
mov r7, r1
mov r1, r10
mov r2, r7
adds r10, r1, r2
blvs _errOverflow
mov r1, #11
str r8, [fp, #-20]
mov r8, r1
mov r1, r10
mov r2, r8
adds r10, r1, r2
blvs _errOverflow
mov r1, #12
str r6, [fp, #-24]
mov r6, r1
mov r1, r10
mov r2, r6
adds r10, r1, r2
blvs _errOverflow
mov r1, #13
str r5, [fp, #-28]
mov r5, r1
mov r1, r10
mov r2, r5
adds r10, r1, r2
blvs _errOverflow
mov r1, #14
str r4, [fp, #-32]
mov r4, r1
mov r1, r10
mov r2, r4
adds r10, r1, r2
blvs _errOverflow
b 1f
.ltorg
1:
mov r1, #15
str r10, [fp, #-4]
mov r10, r1
mov r1, r9
str r9, [fp, #-36]
ldr r9, [fp, #-4]
mov r2, r10
adds r9, r1, r2
blvs _errOverflow
mov r1, #16
str r7, [fp, #-40]
mov r7, r1
mov r1, r9
mov r2, r7
adds r9, r1, r2
blvs _errOverflow
mov r1, #17
str r8, [fp, #-44]
mov r8, r1
mov r1, r9
mov r2, r8
adds r9, r1, r2
blvs _errOverflow
mov r1, r9
str r6, [fp, #-48]
mov r6, r1
mov r1, #-1
str r5, [fp, #-52]
mov r5, r1
mov r1, #2
str r4, [fp, #-56]
mov r4, r1
mov r1, r5
mov r2, r4
subs r5, r1, r2
blvs _errOverflow
mov r1, #3
str r10, [fp, #-60]
mov r10, r1
mov r1, r5
mov r2, r10
subs r5, r1, r2
blvs _errOverflow
mov r1, #4
str r9, [fp, #-4]
mov r9, r1
mov r1, r5
mov r2, r9
subs r5, r1, r2
blvs _errOverflow
mov r1, #5
str r7, [fp, #-64]
mov r7, r1
mov r1, r5
mov r2, r7
subs r5, r1, r2
blvs _errOverflow
mov r1, #6
str r8, [fp, #-68]
mov r8, r1
mov r1, r5
mov r2, r8
subs r5, r1, r2
blvs _errOverflow
mov r1, #7
str r6, [fp, #-72]
mov r6, r1
mov r1, r5
mov r2, r6
subs r5, r1, r2
blvs _errOverflow
mov r1, #8
str r5, [fp, #-76]
mov r5, r1
mov r1, r4
str r4, [fp, #-80]
ldr r4, [fp, #-76]
mov r2, r5
subs r4, r1, r2
blvs _errOverflow
mov r1, #9
str r10, [fp, #-84]
mov r10, r1
mov r1, r4
mov r2, r10
subs r4, r1, r2
blvs _errOverflow
mov r1, #10
str r9, [fp, #-88]
mov r9, r1
mov r1, r4
mov r2, r9
subs r4, r1, r2
blvs _errOverflow
mov r1, #11
str r7, [fp, #-92]
mov r7, r1
mov r1, r4
mov r2, r7
subs r4, r1, r2
blvs _errOverflow
mov r1, #12
b 1f
.ltorg
1:
str r8, [fp, #-96]
mov r8, r1
mov r1, r4
mov r2, r8
subs r4, r1, r2
blvs _errOverflow
mov r1, #13
str r6, [fp, #-100]
mov r6, r1
mov r1, r4
mov r2, r6
subs r4, r1, r2
blvs _errOverflow
mov r1, #14
str r5, [fp, #-104]
mov r5, r1
mov r1, r4
mov r2, r5
subs r4, r1, r2
blvs _errOverflow
mov r1, #15
str r4, [fp, #-76]
mov r4, r1
mov r1, r10
str r10, [fp, #-108]
ldr r10, [fp, #-76]
mov r2, r4
subs r10, r1, r2
blvs _errOverflow
mov r1, #16
str r9, [fp, #-112]
mov r9, r1
mov r1, r10
mov r2, r9
subs r10, r1, r2
blvs _errOverflow
mov r1, #17
str r7, [fp, #-116]
mov r7, r1
mov r1, r10
mov r2, r7
subs r10, r1, r2
blvs _errOverflow
mov r1, r10
str r8, [fp, #-120]
mov r8, r1
mov r1, #1
str r6, [fp, #-124]
mov r6, r1
mov r1, #2
str r5, [fp, #-128]
mov r5, r1
mov r1, r6
mov r2, r5
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #3
str r4, [fp, #-132]
mov r4, r1
mov r1, r6
mov r2, r4
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #4
str r10, [fp, #-76]
mov r10, r1
mov r1, r6
mov r2, r10
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #5
str r9, [fp, #-136]
mov r9, r1
mov r1, r6
mov r2, r9
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #6
str r7, [fp, #-140]
mov r7, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #7
str r8, [fp, #-144]
mov r8, r1
mov r1, r6
mov r2, r8
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #8
str r6, [fp, #-148]
mov r6, r1
mov r1, r5
str r5, [fp, #-152]
b 1f
.ltorg
1:
ldr r5, [fp, #-148]
mov r2, r6
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, #9
str r4, [fp, #-156]
mov r4, r1
mov r1, r5
mov r2, r4
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, #10
str r10, [fp, #-160]
mov r10, r1
mov r1, r5
mov r2, r10
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
mov r1, r5
str r9, [fp, #-164]
mov r9, r1
mov r1, #10
str r7, [fp, #-168]
mov r7, r1
mov r1, r7
str r8, [fp, #-172]
mov r8, r1
mov r1, r6
str r6, [fp, #-176]
ldr r6, [fp, #-72]
str r5, [fp, #-148]
mov r5, r1
mov r1, r4
str r4, [fp, #-180]
ldr r4, [fp, #-144]
str r10, [fp, #-184]
mov r10, r1
mov r1, r5
mov r2, r10
adds r5, r1, r2
blvs _errOverflow
mov r1, r9
str r9, [fp, #-188]
mov r9, r1
mov r1, r8
str r7, [fp, #-192]
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
mov r1, r5
mov r2, r9
adds r5, r1, r2
blvs _errOverflow
mov r0, r5
bl _printi
mov r1, r6
str r8, [fp, #-196]
mov r8, r1
mov r1, r4
str r6, [fp, #-72]
mov r6, r1
mov r1, r8
mov r2, r6
adds r8, r1, r2
blvs _errOverflow
mov r1, r5
str r5, [fp, #-200]
ldr r5, [fp, #-188]
str r4, [fp, #-144]
mov r4, r1
mov r1, r10
str r10, [fp, #-204]
ldr r10, [fp, #-196]
str r9, [fp, #-208]
mov r9, r1
mov r1, r4
mov r2, r9
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r4, r0
pop {r1}
mov r1, r8
mov r2, r4
adds r8, r1, r2
blvs _errOverflow
ldr r1, =#256
str r7, [fp, #-212]
b 1f
.ltorg
1:
mov r7, r1
mov r1, r8
mov r2, r7
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r8, r1
pop {r1}
mov r0, r8
bl _printi
mov r1, r8
str r8, [fp, #-216]
ldr r8, [fp, #-72]
str r6, [fp, #-220]
mov r6, r1
mov r1, r5
str r5, [fp, #-188]
ldr r5, [fp, #-144]
str r4, [fp, #-224]
mov r4, r1
mov r1, r6
mov r2, r4
adds r6, r1, r2
blvs _errOverflow
mov r1, r10
str r10, [fp, #-196]
ldr r10, [fp, #-188]
str r9, [fp, #-228]
mov r9, r1
mov r1, r7
str r7, [fp, #-232]
ldr r7, [fp, #-196]
str r8, [fp, #-72]
mov r8, r1
mov r1, r9
mov r2, r8
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r9, r0
pop {r1}
mov r1, r6
mov r2, r9
adds r6, r1, r2
blvs _errOverflow
mov r0, r6
bl exit
mov r0, #0
ldr r12, =#232
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

