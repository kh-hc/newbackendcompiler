.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
mov r0, #0
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_f:
push {lr}
push {fp}
mov fp, sp
push {r4}
mov r1, #0
mov r4, r1
mov r0, r4
b 0f
0:
pop {r4}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

