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

