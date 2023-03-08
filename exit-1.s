.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
push {r4}
mov r1, #-1
mov r4, r1
mov r0, r4
bl exit
mov r0, #0
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

