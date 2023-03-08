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
cmp r4, #1
bne .L1
.L0:
mov r1, #0
mov r4, r1
cmp r4, #1
beq .L0
.L1:
mov r0, #0
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

