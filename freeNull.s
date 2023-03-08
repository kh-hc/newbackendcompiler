.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r9}
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r0, r9
bl _freepair
mov r0, #0
pop {r9}
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
.text
_freepair:
    push {lr}
    push {r8}
    mov r8, r0
    cmp r8, #0
    bleq _errNull
    mov r0, r8
    bl free
    pop {r8}
    pop {pc}
.ltorg

