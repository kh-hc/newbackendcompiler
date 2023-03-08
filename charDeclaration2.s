.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
mov r1, #122
mov r4, r1
mov r1, r4
mov r10, r1
mov r0, #0
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

