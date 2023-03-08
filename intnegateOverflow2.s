.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =#-2147483648
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r0, r9
bl _printi
mov r1, r10
mov r7, r1
mov r1, #10
mov r8, r1
mov r1, r7
mov r2, r8
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
mov r1, r7
mov r10, r1
mov r1, r10
mov r6, r1
mov r0, r6
bl _printi
mov r0, #0
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
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
