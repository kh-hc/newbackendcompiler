.data
  .word 10
.L.str1:
    .asciz "incorrect"
  .word 8
.L.str2:
    .asciz "correct"
  .word 10
.L.str0:
    .asciz "incorrect"
  .word 10
.L.str3:
    .asciz "incorrect"
  .word 10
.L.str4:
    .asciz "incorrect"
  .word 10
.L.str5:
    .asciz "incorrect"
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#72
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #13
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, #13
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L8
mov r1, r10
mov r8, r1
mov r1, #5
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movgt r8, #1
movle r8, #0
cmp r8, #1
bne .L6
mov r1, r10
mov r5, r1
mov r1, #10
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
bne .L4
ldr r1, =.L.str0
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
str r10, [fp, #-12]
ldr r10, [fp, #-8]
str r4, [fp, #-16]
ldr r4, [fp, #-4]
str r5, [fp, #-20]
b .L5
.L4:
mov r1, r10
mov r5, r1
mov r1, #12
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movgt r5, #1
movle r5, #0
cmp r5, #1
bne .L2
mov r1, r10
mov r10, r1
mov r1, #13
str r9, [fp, #-24]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movgt r10, #1
movle r10, #0
cmp r10, #1
bne .L0
ldr r1, =.L.str1
str r7, [fp, #-28]
mov r7, r1
mov r0, r7
bl _prints
str r10, [fp, #-32]
ldr r10, [fp, #0]
str r7, [fp, #-36]
ldr r7, [fp, #-28]
str r9, [fp, #-40]
ldr r9, [fp, #-24]
b .L1
.L0:
ldr r1, =.L.str2
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-44]
ldr r9, [fp, #0]
.L1:
str r4, [fp, #-48]
ldr r4, [fp, #0]
str r5, [fp, #-52]
b .L3
.L2:
ldr r1, =.L.str3
b 1f
.ltorg
1:
mov r5, r1
mov r0, r5
bl _prints
str r5, [fp, #-56]
.L3:
.L5:
str r6, [fp, #-60]
str r8, [fp, #-64]
b .L7
.L6:
ldr r1, =.L.str4
mov r8, r1
mov r0, r8
bl _prints
str r8, [fp, #-68]
.L7:
str r7, [fp, #-28]
str r9, [fp, #-24]
b .L9
.L8:
ldr r1, =.L.str5
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-72]
.L9:
mov r0, #0
ldr r12, =#72
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
