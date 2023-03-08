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
mov r1, #97
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #90
mov r9, r1
mov r1, r9
mov r10, r1
mov r0, #0
pop {r9}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

