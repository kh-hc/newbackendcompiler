.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r4}
mov r1, #0
mov r4, r1
mov r0, r4
bl _printp
mov r0, #0
pop {r4}
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
