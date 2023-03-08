.data
  .word 6
.L.str1:
    .asciz "Hello"
  .word 7
.L.str2:
    .asciz "s1 is "
  .word 3
.L.str0:
    .asciz "Hi"
  .word 7
.L.str3:
    .asciz "s2 is "
  .word 7
.L.str7:
    .asciz "s1 is "
  .word 7
.L.str8:
    .asciz "s2 is "
  .word 17
.L.str6:
    .asciz "Now make s1 = s2"
  .word 26
.L.str9:
    .asciz "They are the same string."
  .word 30
.L.str10:
    .asciz "They are not the same string."
  .word 26
.L.str4:
    .asciz "They are the same string."
  .word 30
.L.str5:
    .asciz "They are not the same string."
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#68
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str0
mov r4, r1
mov r1, r4
mov r10, r1
ldr r1, =.L.str1
mov r9, r1
mov r1, r9
mov r7, r1
ldr r1, =.L.str2
mov r8, r1
mov r0, r8
bl _prints
mov r1, r10
mov r6, r1
mov r0, r6
bl _prints
ldr r1, =.L.str3
mov r5, r1
mov r0, r5
bl _prints
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r1, r7
str r9, [fp, #-12]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L0
ldr r1, =.L.str4
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
str r10, [fp, #-20]
ldr r10, [fp, #-8]
str r7, [fp, #-24]
ldr r7, [fp, #-16]
str r9, [fp, #-28]
ldr r9, [fp, #-12]
b .L1
.L0:
ldr r1, =.L.str5
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-32]
ldr r9, [fp, #0]
.L1:
ldr r1, =.L.str6
mov r9, r1
mov r0, r9
bl _prints
mov r1, r7
mov r10, r1
ldr r1, =.L.str7
mov r7, r1
mov r0, r7
bl _prints
mov r1, r10
mov r10, r1
mov r0, r10
bl _prints
ldr r1, =.L.str8
str r8, [fp, #-36]
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
str r6, [fp, #-40]
mov r6, r1
mov r0, r6
bl _prints
mov r1, r10
str r5, [fp, #-44]
mov r5, r1
mov r1, r7
str r4, [fp, #-48]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
b 1f
.ltorg
1:
cmp r5, #1
bne .L2
ldr r1, =.L.str9
str r9, [fp, #-52]
mov r9, r1
mov r0, r9
bl _prints
str r4, [fp, #-56]
ldr r4, [fp, #-48]
str r5, [fp, #-60]
ldr r5, [fp, #-44]
str r9, [fp, #-64]
ldr r9, [fp, #-52]
b .L3
.L2:
ldr r1, =.L.str10
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-68]
ldr r9, [fp, #0]
.L3:
mov r0, #0
ldr r12, =#68
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
