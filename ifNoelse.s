.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
subs sp, sp, r12
push {r4}
mov r1, #1
mov r4, r1
cmp r4, #1
bne .L0
str r4, [fp, #-4]
b .L1
.L0:
.L1:
mov r0, #0
ldr r12, =#4
adds sp, sp, r12
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

