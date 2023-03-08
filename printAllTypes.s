.data
  .word 17
.L.str1:
    .asciz "this is a string"
  .word 6
.L.str2:
    .asciz "array"
  .word 4
.L.str12:
    .asciz ") ]"
  .word 3
.L.str0:
    .asciz ", "
  .word 3
.L.str3:
    .asciz "of"
  .word 4
.L.str7:
    .asciz "] )"
  .word 5
.L.str11:
    .asciz " = ("
  .word 3
.L.str8:
    .asciz "[ "
  .word 6
.L.str6:
    .asciz "] , ["
  .word 5
.L.str9:
    .asciz " = ("
  .word 4
.L.str10:
    .asciz "), "
  .word 8
.L.str4:
    .asciz "strings"
  .word 4
.L.str5:
    .asciz "( ["
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#580
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
mov r1, #5
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, #120
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
ldr r1, =.L.str1
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r1, #16
str r7, [fp, #-16]
mov r0, r1
bl malloc
mov r7, r0
mov r1, #3
str r8, [fp, #-20]
mov r8, r1
str r8, [r7, #0]
mov r1, r7
mov r2, #4
adds r7, r1, r2
blvs _errOverflow
mov r1, #1
str r6, [fp, #-24]
mov r6, r1
str r6, [r7, #0]
mov r1, #2
str r5, [fp, #-28]
mov r5, r1
str r5, [r7, #4]
mov r1, #3
str r4, [fp, #-32]
mov r4, r1
str r4, [r7, #8]
mov r1, r7
str r10, [fp, #-36]
mov r10, r1
mov r1, #16
str r9, [fp, #-40]
mov r0, r1
bl malloc
mov r9, r0
mov r1, #3
str r7, [fp, #-44]
mov r7, r1
str r7, [r9, #0]
mov r1, r9
mov r2, #4
adds r9, r1, r2
blvs _errOverflow
mov r1, #120
mov r8, r1
str r8, [r9, #0]
mov r1, #121
mov r6, r1
str r6, [r9, #4]
mov r1, #122
mov r5, r1
str r5, [r9, #8]
mov r1, r9
mov r4, r1
mov r1, #16
str r10, [fp, #-48]
mov r0, r1
bl malloc
mov r10, r0
mov r1, #3
str r9, [fp, #-52]
mov r9, r1
str r9, [r10, #0]
mov r1, r10
mov r2, #4
adds r10, r1, r2
blvs _errOverflow
mov r1, #1
b 1f
.ltorg
1:
mov r7, r1
str r7, [r10, #0]
mov r1, #0
mov r8, r1
str r8, [r10, #4]
mov r1, #1
mov r6, r1
str r6, [r10, #8]
mov r1, r10
mov r5, r1
mov r1, #16
str r4, [fp, #-56]
mov r0, r1
bl malloc
mov r4, r0
mov r1, #3
str r10, [fp, #-60]
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
ldr r1, =.L.str2
mov r9, r1
str r9, [r4, #0]
ldr r1, =.L.str3
mov r7, r1
str r7, [r4, #4]
ldr r1, =.L.str4
mov r8, r1
str r8, [r4, #8]
mov r1, r4
mov r6, r1
str r5, [fp, #-64]
mov r0, #8
bl malloc
mov r5, r0
mov r1, #1
cmp r5, #0
bleq _errNull
str r4, [fp, #-68]
mov r4, r1
str r4, [r5, #0]
mov r1, #2
cmp r5, #0
bleq _errNull
mov r10, r1
str r10, [r5, #4]
mov r1, r5
mov r9, r1
mov r0, #8
bl malloc
mov r7, r0
mov r1, #97
cmp r7, #0
bleq _errNull
mov r8, r1
str r8, [r7, #0]
mov r1, #1
cmp r7, #0
bleq _errNull
str r6, [fp, #-72]
mov r6, r1
str r6, [r7, #4]
mov r1, r7
str r5, [fp, #-76]
mov r5, r1
mov r0, #8
bl malloc
mov r4, r0
mov r1, #98
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #0
cmp r4, #0
bleq _errNull
str r9, [fp, #-80]
mov r9, r1
str r9, [r4, #4]
mov r1, r4
str r7, [fp, #-84]
mov r7, r1
mov r1, #12
mov r0, r1
bl malloc
mov r8, r0
mov r1, #2
mov r6, r1
str r6, [r8, #0]
mov r1, r8
mov r2, #4
adds r8, r1, r2
blvs _errOverflow
mov r1, r5
str r5, [fp, #-88]
mov r5, r1
str r5, [r8, #0]
mov r1, r7
str r4, [fp, #-92]
b 1f
.ltorg
1:
mov r4, r1
str r4, [r8, #4]
mov r1, r8
mov r10, r1
mov r1, #16
mov r0, r1
bl malloc
mov r9, r0
mov r1, #3
str r7, [fp, #-96]
mov r7, r1
str r7, [r9, #0]
mov r1, r9
mov r2, #4
adds r9, r1, r2
blvs _errOverflow
mov r1, #1
str r8, [fp, #-100]
mov r8, r1
str r8, [r9, #0]
mov r1, #2
mov r6, r1
str r6, [r9, #4]
mov r1, #3
mov r5, r1
str r5, [r9, #8]
mov r1, r9
mov r4, r1
mov r1, #16
str r10, [fp, #-104]
mov r0, r1
bl malloc
mov r10, r0
mov r1, #3
str r9, [fp, #-108]
mov r9, r1
str r9, [r10, #0]
mov r1, r10
mov r2, #4
adds r10, r1, r2
blvs _errOverflow
mov r1, #97
mov r7, r1
str r7, [r10, #0]
mov r1, #98
mov r8, r1
str r8, [r10, #4]
mov r1, #99
mov r6, r1
str r6, [r10, #8]
mov r1, r10
mov r5, r1
str r4, [fp, #-112]
mov r0, #8
bl malloc
mov r4, r0
mov r1, r10
str r10, [fp, #-116]
ldr r10, [fp, #-112]
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #0]
mov r1, r5
cmp r4, #0
bleq _errNull
mov r7, r1
str r7, [r4, #4]
mov r1, r4
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
str r5, [fp, #-120]
mov r5, r1
str r4, [fp, #-124]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-112]
mov r10, r1
ldr r1, =.L.str5
mov r9, r1
mov r0, r9
bl _prints
mov r1, #4
mov r7, r1
mov r1, r5
str r8, [fp, #-128]
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, r6
mov r2, r7
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
str r5, [fp, #-132]
ldr r5, [r8, r6]
mov r1, r5
b 1f
.ltorg
1:
push {r1}
mov r3, r6
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r6
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r4, r1
mov r0, r4
bl _printi
mov r1, r10
str r10, [fp, #-136]
ldr r10, [fp, #-8]
str r9, [fp, #-140]
mov r9, r1
mov r0, r9
bl _prints
mov r1, #4
str r7, [fp, #-144]
mov r7, r1
mov r1, r8
str r8, [fp, #-148]
ldr r8, [fp, #-132]
str r6, [fp, #-152]
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r4, [fp, #-156]
ldr r4, [r6, r5]
mov r1, r4
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _printi
mov r1, r9
str r9, [fp, #-160]
ldr r9, [fp, #-8]
str r7, [fp, #-164]
mov r7, r1
mov r0, r7
bl _prints
mov r1, #4
str r8, [fp, #-132]
mov r8, r1
mov r1, r6
str r6, [fp, #-168]
ldr r6, [fp, #-132]
str r5, [fp, #-172]
mov r5, r1
mov r1, #2
mov r4, r1
mov r1, r4
mov r2, r8
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
str r10, [fp, #-176]
ldr r10, [r5, r4]
mov r1, r10
push {r1}
mov r3, r4
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r5, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r4
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-8]
mov r9, r1
mov r0, r9
bl _printi
ldr r1, =.L.str6
str r7, [fp, #-180]
b 1f
.ltorg
1:
mov r7, r1
mov r0, r7
bl _prints
mov r1, #4
str r8, [fp, #-184]
mov r8, r1
mov r1, r6
str r6, [fp, #-132]
ldr r6, [fp, #-136]
str r5, [fp, #-188]
mov r5, r1
mov r1, #0
str r4, [fp, #-192]
mov r4, r1
mov r1, r4
mov r2, r8
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
ldr r10, [r5, r4]
mov r1, r10
push {r1}
mov r3, r4
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r5, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r4
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-196]
mov r9, r1
mov r0, r9
bl _printc
mov r1, r7
str r7, [fp, #-200]
ldr r7, [fp, #-8]
str r8, [fp, #-204]
mov r8, r1
mov r0, r8
bl _prints
mov r1, #4
str r6, [fp, #-136]
mov r6, r1
mov r1, r5
str r5, [fp, #-208]
ldr r5, [fp, #-136]
str r4, [fp, #-212]
mov r4, r1
mov r1, #1
mov r10, r1
mov r1, r10
mov r2, r6
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-216]
ldr r9, [r4, r10]
mov r1, r9
push {r1}
mov r3, r10
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r10
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-8]
mov r7, r1
mov r0, r7
bl _printc
mov r1, r8
str r8, [fp, #-220]
ldr r8, [fp, #-8]
str r6, [fp, #-224]
mov r6, r1
mov r0, r6
bl _prints
mov r1, #4
str r5, [fp, #-136]
mov r5, r1
mov r1, r4
str r4, [fp, #-228]
ldr r4, [fp, #-136]
str r10, [fp, #-232]
mov r10, r1
mov r1, #2
mov r9, r1
mov r1, r9
mov r2, r5
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
b 1f
.ltorg
1:
str r7, [fp, #-236]
ldr r7, [r10, r9]
mov r1, r7
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r10, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r8, [fp, #-8]
mov r8, r1
mov r0, r8
bl _printc
ldr r1, =.L.str7
str r6, [fp, #-240]
mov r6, r1
mov r0, r6
bl _prints
str r10, [fp, #-244]
ldr r10, [fp, #-104]
ldr r7, [fp, #-96]
str r8, [fp, #-248]
ldr r8, [fp, #-100]
str r4, [fp, #-136]
str r5, [fp, #-252]
str r6, [fp, #-256]
str r9, [fp, #-260]
mov r1, #4
mov r9, r1
mov r1, r10
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
mov r2, r9
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
ldr r4, [r6, r5]
mov r1, r4
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r8, r1
ldr r7, [r8, #0]
mov r1, r7
cmp r8, #0
bleq _errNull
mov r10, r1
str r9, [fp, #-264]
ldr r9, [r8, #4]
mov r1, r9
cmp r8, #0
bleq _errNull
str r6, [fp, #-268]
mov r6, r1
mov r1, #4
str r5, [fp, #-272]
mov r5, r1
mov r1, r10
mov r4, r1
mov r1, #1
str r8, [fp, #-276]
mov r8, r1
mov r1, r8
mov r2, r5
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r7, [fp, #-96]
ldr r7, [r4, r8]
mov r1, r7
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
b 1f
.ltorg
1:
str r10, [fp, #-280]
mov r10, r1
ldr r9, [r10, #0]
mov r1, r9
cmp r10, #0
bleq _errNull
str r6, [fp, #-284]
mov r6, r1
str r5, [fp, #-288]
ldr r5, [r10, #4]
mov r1, r5
cmp r10, #0
bleq _errNull
str r4, [fp, #-292]
mov r4, r1
ldr r1, =.L.str8
str r8, [fp, #-296]
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
ldr r7, [fp, #-276]
str r10, [fp, #-300]
mov r10, r1
mov r0, r10
bl _printp
ldr r1, =.L.str9
mov r9, r1
mov r0, r9
bl _prints
mov r1, r6
str r6, [fp, #-304]
ldr r6, [fp, #-280]
mov r5, r1
mov r0, r5
bl _printc
mov r1, r4
str r4, [fp, #-308]
ldr r4, [fp, #-8]
str r8, [fp, #-312]
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
str r7, [fp, #-276]
ldr r7, [fp, #-284]
str r10, [fp, #-316]
mov r10, r1
mov r0, r10
bl _printb
ldr r1, =.L.str10
str r9, [fp, #-320]
mov r9, r1
mov r0, r9
bl _prints
mov r1, r6
str r6, [fp, #-280]
ldr r6, [fp, #-300]
str r5, [fp, #-324]
mov r5, r1
mov r0, r5
bl _printp
ldr r1, =.L.str11
str r4, [fp, #-8]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r8
str r8, [fp, #-328]
ldr r8, [fp, #-304]
str r7, [fp, #-284]
mov r7, r1
mov r0, r7
bl _printc
mov r1, r10
str r10, [fp, #-332]
ldr r10, [fp, #-8]
str r9, [fp, #-336]
mov r9, r1
mov r0, r9
bl _prints
mov r1, r6
str r6, [fp, #-300]
ldr r6, [fp, #-308]
str r5, [fp, #-340]
mov r5, r1
mov r0, r5
bl _printb
ldr r1, =.L.str12
str r4, [fp, #-344]
mov r4, r1
mov r0, r4
bl _prints
str r5, [fp, #-348]
ldr r5, [fp, #-76]
str r6, [fp, #-308]
ldr r6, [fp, #-72]
str r9, [fp, #-352]
ldr r9, [fp, #-80]
str r10, [fp, #-8]
str r4, [fp, #-356]
str r7, [fp, #-360]
b 1f
.ltorg
1:
str r8, [fp, #-304]
ldr r8, [r9, #0]
mov r1, r8
cmp r9, #0
bleq _errNull
mov r7, r1
ldr r4, [r9, #4]
mov r1, r4
cmp r9, #0
bleq _errNull
mov r10, r1
mov r1, r7
mov r9, r1
mov r0, r9
bl _printi
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl _prints
mov r1, r10
mov r8, r1
mov r0, r8
bl _printi
ldr r4, [fp, #-68]
str r5, [fp, #-364]
ldr r5, [fp, #-64]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r10, [fp, #-368]
str r7, [fp, #-372]
str r8, [fp, #-376]
str r9, [fp, #-380]
mov r1, #4
mov r9, r1
mov r1, r6
mov r8, r1
mov r1, #0
mov r7, r1
mov r1, r7
mov r2, r9
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
ldr r10, [r8, r7]
mov r1, r10
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r6, r1
mov r1, #4
mov r5, r1
mov r1, r6
mov r4, r1
mov r1, #1
str r9, [fp, #-384]
mov r9, r1
mov r1, r9
mov r2, r5
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
str r8, [fp, #-388]
ldr r8, [r4, r9]
mov r1, r8
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-392]
mov r7, r1
mov r1, #4
mov r10, r1
mov r1, r6
str r6, [fp, #-396]
mov r6, r1
mov r1, #2
str r5, [fp, #-400]
mov r5, r1
mov r1, r5
mov r2, r10
smull r5, r3, r1, r2
cmp r3, r5, asr #31
b 1f
.ltorg
1:
blne _errOverflow
str r4, [fp, #-404]
ldr r4, [r6, r5]
mov r1, r4
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r9, [fp, #-408]
mov r9, r1
mov r1, r8
ldr r8, [fp, #-396]
str r7, [fp, #-412]
mov r7, r1
mov r0, r7
bl _prints
mov r1, r10
str r10, [fp, #-416]
ldr r10, [fp, #-8]
str r6, [fp, #-420]
mov r6, r1
mov r0, r6
bl _prints
mov r1, r5
str r5, [fp, #-424]
ldr r5, [fp, #-412]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r9, [fp, #-428]
mov r9, r1
mov r0, r9
bl _prints
mov r1, r8
str r8, [fp, #-396]
ldr r8, [fp, #-428]
str r7, [fp, #-432]
mov r7, r1
mov r0, r7
bl _prints
str r10, [fp, #-8]
ldr r10, [fp, #-60]
str r4, [fp, #-436]
ldr r4, [fp, #-56]
str r5, [fp, #-412]
ldr r5, [fp, #0]
str r6, [fp, #-440]
str r7, [fp, #-444]
str r8, [fp, #-428]
str r9, [fp, #-448]
mov r1, #4
mov r9, r1
mov r1, r5
mov r8, r1
mov r1, #0
mov r7, r1
mov r1, r7
mov r2, r9
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
ldr r6, [r8, r7]
mov r1, r6
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r5, r1
mov r0, r5
bl _printb
mov r1, r4
ldr r4, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
mov r1, #4
str r9, [fp, #-452]
mov r9, r1
mov r1, r5
str r8, [fp, #-456]
mov r8, r1
mov r1, #1
str r7, [fp, #-460]
b 1f
.ltorg
1:
mov r7, r1
mov r1, r7
mov r2, r9
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
ldr r6, [r8, r7]
mov r1, r6
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r8, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-464]
mov r5, r1
mov r0, r5
bl _printb
mov r1, r4
str r4, [fp, #-8]
mov r4, r1
mov r0, r4
bl _prints
mov r1, #4
str r10, [fp, #-468]
mov r10, r1
mov r1, r5
str r9, [fp, #-472]
mov r9, r1
mov r1, #2
str r8, [fp, #-476]
mov r8, r1
mov r1, r8
mov r2, r10
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r7, [fp, #-480]
ldr r7, [r9, r8]
mov r1, r7
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r9, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r6, r1
mov r0, r6
bl _printb
str r10, [fp, #-484]
ldr r10, [fp, #-48]
str r4, [fp, #-488]
ldr r4, [fp, #0]
str r9, [fp, #-492]
ldr r9, [fp, #-52]
str r5, [fp, #-496]
str r6, [fp, #-500]
str r8, [fp, #-504]
mov r1, r4
mov r8, r1
mov r0, r8
bl _printi
ldr r7, [fp, #-44]
str r9, [fp, #-52]
ldr r9, [fp, #-40]
str r4, [fp, #-56]
str r8, [fp, #-508]
mov r1, #4
mov r8, r1
mov r1, r10
mov r4, r1
mov r1, #0
mov r9, r1
mov r1, r9
mov r2, r8
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
ldr r7, [r4, r9]
mov r1, r7
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
b 1f
.ltorg
1:
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r6, r1
mov r1, #4
mov r5, r1
mov r1, r10
mov r9, r1
mov r1, #1
mov r4, r1
mov r1, r4
mov r2, r5
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
ldr r10, [r9, r4]
mov r1, r10
push {r1}
mov r3, r4
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r9, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r4
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r8, [fp, #-512]
mov r8, r1
mov r1, #4
str r4, [fp, #-516]
mov r4, r1
mov r1, r10
str r9, [fp, #-520]
mov r9, r1
mov r1, #2
str r7, [fp, #-44]
mov r7, r1
mov r1, r7
mov r2, r4
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
str r6, [fp, #-524]
ldr r6, [r9, r7]
mov r1, r6
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r9, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-528]
mov r5, r1
mov r1, r10
str r10, [fp, #-48]
ldr r10, [fp, #-524]
str r8, [fp, #-532]
mov r8, r1
mov r0, r8
bl _printi
mov r1, r4
str r4, [fp, #-536]
ldr r4, [fp, #-8]
str r9, [fp, #-540]
mov r9, r1
mov r0, r9
bl _prints
mov r1, r7
str r7, [fp, #-544]
ldr r7, [fp, #-532]
mov r6, r1
mov r0, r6
bl _printi
mov r1, r4
str r5, [fp, #-548]
mov r5, r1
mov r0, r5
bl _prints
mov r1, r10
str r10, [fp, #-524]
ldr r10, [fp, #-548]
str r8, [fp, #-552]
mov r8, r1
mov r0, r8
bl _printi
str r10, [fp, #-548]
ldr r10, [fp, #-36]
str r4, [fp, #-8]
ldr r4, [fp, #-32]
b 1f
.ltorg
1:
str r5, [fp, #-556]
ldr r5, [fp, #-28]
str r6, [fp, #-560]
ldr r6, [fp, #-24]
str r7, [fp, #-532]
ldr r7, [fp, #-16]
str r8, [fp, #-564]
ldr r8, [fp, #-20]
str r9, [fp, #-568]
ldr r9, [fp, #0]
mov r1, r9
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-36]
ldr r10, [fp, #-8]
str r9, [fp, #-572]
ldr r9, [fp, #-12]
mov r1, r4
mov r9, r1
mov r0, r9
bl _printb
str r4, [fp, #-32]
ldr r4, [fp, #-4]
str r9, [fp, #-576]
ldr r9, [fp, #0]
str r5, [fp, #-28]
mov r1, r6
mov r5, r1
mov r0, r5
bl _printc
str r5, [fp, #-580]
str r6, [fp, #-24]
str r8, [fp, #-20]
mov r1, r7
mov r8, r1
mov r0, r8
bl _printi
mov r0, #0
ldr r12, =#580
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
    .word 5
.L._printb_str0:
    .asciz "false"
    .word 4
.L._printb_str1:
    .asciz "true"
    .word 4
.L._printb_str2:
    .asciz "%.*s"
.text
_printb:
    push {lr}
    push {r1, r2}
    cmp r0, #0
    bne .L_printb0
    ldr r2, =.L._printb_str0
    b .L_printb1
    .ltorg
.L_printb0:
    ldr r2, =.L._printb_str1
.L_printb1:
    ldr r1, [r2, #-4]
    ldr r0, =.L._printb_str2
    bl printf
    mov r0, #0
    bl fflush
    pop {r1, r2}
    pop {pc}
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
.data
    .word 2
.L._printi_str0:		
    .asciz "%d"
.text
_printi:
    push {lr}
    push {r1}
    mov r1, r0
    ldr r0, =.L._printi_str0
    bl printf
    mov r0, #0
    bl fflush
    pop {r1}
    pop {pc}
.ltorg
.data
    .word 2
.L._printp_str0:
	.asciz "%p"
.text
_printp:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printp_str0
	bl printf
	mov r0, #0
	bl fflush
    pop {r1}
	pop {pc}
    .ltorg

.data
@ length of .L._errOverflow_str0
    .word 52
.L._errOverflow_str0:
    .asciz "#runtime_error#\n"
.text
_errOverflow:
    ldr r0, =.L._errOverflow_str0
    bl _prints
    mov r0, #255
    bl exit
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
    .word 2
.L._printc_str0:
	.asciz "%c"
.text
_printc:
	push {lr}
    push {r1}
	mov r1, r0
	ldr r0, =.L._printc_str0
	bl printf
	mov r0, #0
	bl fflush
    pop {r1}
	pop {pc}
    .ltorg

.data
    .word 42
.L._errOutOfBounds_str0:
	.asciz "fatal error: array index %d out of bounds\n"
.text
_errOutOfBounds:
    ldr r0, =.L._errOutOfBounds_str0
    bl printf
    mov r0, #0
    bl fflush
    mov r0, #255
    bl exit
.ltorg
 
.data
    .word 45
.L._errNull_str0:
	.asciz "fatal error: null pair dereferenced or freed\n"
.text
_errNull:
    ldr r0, =.L._errNull_str0
    bl _prints
    mov r0, #255
    bl exit
.ltorg
    
