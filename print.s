.data
  .word 13
.L.str0:
    .asciz "Hello World!"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r4}
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
mov r0, #0
pop {r4}
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
