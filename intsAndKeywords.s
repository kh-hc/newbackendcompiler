.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#8
subs sp, sp, r12
push {r10}
push {r4}
mov r1, #125
mov r4, r1
mov r1, r4
mov r10, r1
str r10, [fp, #-4]
str r4, [fp, #-8]
mov r0, #0
ldr r12, =#8
adds sp, sp, r12
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

