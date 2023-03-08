.data
  .word 5
.L.str0:
    .asciz " = ("
  .word 2
.L.str2:
    .asciz ")"
  .word 2
.L.str1:
    .asciz ","
.text
.global main
main:
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
mov r1, r7
mov r8, r1
mov r0, r8
bl _printp
ldr r1, =.L.str0
mov r6, r1
mov r0, r6
bl _prints
ldr r5, [r7, #0]
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r0, r10
bl _printp
ldr r1, =.L.str1
mov r9, r1
mov r0, r9
bl _prints
str r8, [fp, #-8]
ldr r8, [r7, #4]
mov r1, r8
cmp r7, #0
bleq _errNull
str r6, [fp, #-12]
mov r6, r1
mov r1, r6
mov r5, r1
mov r0, r5
bl _printp
ldr r1, =.L.str2
str r4, [fp, #-16]
mov r4, r1
mov r0, r4
bl _prints
mov r0, #0
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
