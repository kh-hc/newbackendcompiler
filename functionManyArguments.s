.data
  .word 11
.L.str1:
    .asciz "answer is "
  .word 6
.L.str2:
    .asciz "a is "
  .word 6
.L.str0:
    .asciz "hello"
  .word 6
.L.str3:
    .asciz "b is "
  .word 6
.L.str7:
    .asciz "f is "
  .word 6
.L.str6:
    .asciz "e is "
  .word 6
.L.str4:
    .asciz "c is "
  .word 6
.L.str5:
    .asciz "d is "
.text
.global main
main:
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
mov r1, #12
mov r0, r1
bl malloc
mov r4, r0
mov r1, #2
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
mov r1, #0
mov r9, r1
str r9, [r4, #0]
mov r1, #1
mov r7, r1
str r7, [r4, #4]
mov r1, r4
mov r8, r1
mov r1, #12
mov r0, r1
bl malloc
mov r6, r0
mov r1, #2
mov r5, r1
str r5, [r6, #0]
mov r1, r6
mov r2, #4
adds r6, r1, r2
blvs _errOverflow
mov r1, #1
str r4, [fp, #-4]
mov r4, r1
str r4, [r6, #0]
mov r1, #2
mov r10, r1
str r10, [r6, #4]
mov r1, r6
mov r9, r1
mov r1, #42
mov r7, r1
mov r1, #1
str r8, [fp, #-8]
mov r8, r1
mov r1, #117
str r6, [fp, #-12]
mov r6, r1
ldr r1, =.L.str0
mov r5, r1
mov r1, r4
ldr r4, [fp, #-8]
mov r10, r1
mov r1, r9
str r9, [fp, #-16]
mov r9, r1
mov r0, r7
mov r1, r8
mov r2, r6
mov r3, r5
push {r10}
push {r9}
bl wacc_doSomething
str r7, [fp, #-20]
mov r7, r0
mov r1, r7
str r8, [fp, #-24]
mov r8, r1
ldr r1, =.L.str1
str r6, [fp, #-28]
mov r6, r1
mov r0, r6
bl _prints
mov r1, r8
str r5, [fp, #-32]
mov r5, r1
mov r0, r5
bl _printc
mov r0, #0
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
b 1f
.ltorg
1:
pop {pc}
.ltorg

wacc_doSomething:
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
mov r10, r1
mov r9, r2
mov r7, r3
ldr r8, [fp, #12]
ldr r6, [fp, #8]
ldr r1, =.L.str2
mov r5, r1
mov r0, r5
bl _prints
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _printi
ldr r1, =.L.str3
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
mov r1, r9
str r9, [fp, #-12]
ldr r9, [fp, #-8]
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _printb
ldr r1, =.L.str4
str r8, [fp, #-20]
mov r8, r1
mov r0, r8
bl _prints
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-12]
str r5, [fp, #-28]
mov r5, r1
mov r0, r5
bl _printc
ldr r1, =.L.str5
str r4, [fp, #-32]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r10, [fp, #-36]
ldr r10, [fp, #-16]
str r9, [fp, #-8]
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str6
str r7, [fp, #-40]
mov r7, r1
mov r0, r7
bl _prints
mov r1, r8
str r8, [fp, #-44]
ldr r8, [fp, #-20]
str r6, [fp, #-12]
mov r6, r1
mov r0, r6
bl _printp
ldr r1, =.L.str7
str r5, [fp, #-48]
mov r5, r1
mov r0, r5
bl _prints
mov r1, r4
str r4, [fp, #-52]
ldr r4, [fp, #-24]
str r10, [fp, #-16]
mov r10, r1
mov r0, r10
bl _printp
mov r1, #103
str r9, [fp, #-56]
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#56
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
pop {r4}
b 1f
.ltorg
1:
pop {r10}
mov sp, fp
pop {fp}
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
.L._printp_str0:
	.asciz "%p"
.text
_printp:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printp_str0
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
