.data
  .word 26
.L.str0:
    .asciz "enter a character to echo"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r7}
push {r9}
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
ldr r1, =.L.str0
mov r9, r1
mov r0, r9
bl _prints
bl _readc
mov r10, r0
mov r1, r10
mov r7, r1
mov r0, r7
bl _printc
mov r0, #0
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
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
