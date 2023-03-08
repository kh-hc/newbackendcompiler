.data
  .word 9
.L.str0:
    .asciz "True is "
  .word 10
.L.str1:
    .asciz "False is "
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
ldr r1, =.L.str0
mov r4, r1
mov r0, r4
bl _prints
mov r1, #1
mov r10, r1
mov r0, r10
bl _printb
ldr r1, =.L.str1
mov r9, r1
mov r0, r9
bl _prints
mov r1, #0
mov r7, r1
mov r0, r7
bl _printb
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
