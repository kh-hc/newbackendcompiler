.data
.text
.global main
main:
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
mov r0, #8
bl malloc
mov r4, r0
mov r1, #10
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #97
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #4]
mov r1, r4
mov r7, r1
mov r1, r7
mov r8, r1
mov r1, r7
mov r6, r1
mov r0, r6
bl _printp
mov r1, r8
mov r5, r1
mov r0, r5
bl _printp
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r1, r8
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r0, r4
bl _printb
ldr r9, [r7, #0]
mov r1, r9
cmp r7, #0
bleq _errNull
str r7, [fp, #-8]
mov r7, r1
str r6, [fp, #-12]
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
str r5, [fp, #-16]
mov r5, r1
mov r1, r7
str r4, [fp, #-20]
mov r4, r1
mov r0, r4
bl _printi
mov r1, r5
str r10, [fp, #-24]
mov r10, r1
mov r0, r10
bl _printi
mov r1, r7
mov r9, r1
mov r1, r5
str r7, [fp, #-28]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
mov r0, r9
bl _printb
ldr r6, [r8, #4]
mov r1, r6
str r8, [fp, #-32]
ldr r8, [fp, #-8]
cmp r8, #0
bleq _errNull
str r5, [fp, #-36]
mov r5, r1
str r10, [fp, #-44]
ldr r10, [r4, #4]
mov r1, r10
str r4, [fp, #-40]
ldr r4, [fp, #-32]
cmp r4, #0
bleq _errNull
str r9, [fp, #-48]
mov r9, r1
mov r1, r5
str r7, [fp, #-52]
mov r7, r1
mov r0, r7
b 1f
.ltorg
1:
bl _printc
mov r1, r9
str r8, [fp, #-8]
mov r8, r1
mov r0, r8
bl _printc
mov r1, r5
mov r6, r1
mov r1, r9
str r5, [fp, #-56]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r0, r6
bl _printb
mov r0, #0
ldr r12, =#56
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
    
