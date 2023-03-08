.data
.text
.global main
main:
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
mov r0, #8
bl malloc
mov r4, r0
mov r1, #2
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #3
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #4]
mov r1, r4
mov r7, r1
mov r0, #8
bl malloc
mov r8, r0
mov r1, #1
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
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
str r7, [fp, #-8]
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
str r8, [fp, #-12]
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
bl _printi
mov r0, #0
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
