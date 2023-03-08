.data
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
mov r1, #10
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #20
mov r9, r1
mov r1, r9
mov r10, r1
mov r1, r10
mov r7, r1
mov r0, r7
bl exit
mov r0, #0
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

