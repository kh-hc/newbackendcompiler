.data
  .word 23
.L.str0:
    .asciz "Should not print this."
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
mov r1, #42
mov r4, r1
mov r0, r4
bl exit
ldr r1, =.L.str0
mov r10, r1
mov r0, r10
bl _prints
mov r0, #0
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
