.data
  .word 26
.L.str28:
    .asciz "The integer is not found."
  .word 44
.L.str17:
    .asciz "=                                         ="
  .word 2
.L.str2:
    .asciz ")"
  .word 14
.L.str0:
    .asciz "Goodbye Human"
  .word 36
.L.str23:
    .asciz "Please enter an integer to insert: "
  .word 30
.L.str34:
    .asciz "The integer has been removed."
  .word 16
.L.str19:
    .asciz "Your decision: "
  .word 44
.L.str11:
    .asciz "= b: find an integer                      ="
  .word 36
.L.str33:
    .asciz "Please enter an integer to remove: "
  .word 44
.L.str15:
    .asciz "= f: remove all integers                  ="
  .word 44
.L.str6:
    .asciz "==========================================="
  .word 25
.L.str29:
    .asciz "There is only 1 integer."
  .word 44
.L.str10:
    .asciz "= a: insert an integer                    ="
  .word 24
.L.str1:
    .asciz "Error: unknown choice ("
  .word 44
.L.str13:
    .asciz "= d: print all integers                   ="
  .word 26
.L.str35:
    .asciz "The integer is not found."
  .word 44
.L.str24:
    .asciz "Successfully insert it. The integer is new."
  .word 44
.L.str12:
    .asciz "= c: count the integers                   ="
  .word 11
.L.str30:
    .asciz "There are "
  .word 1
.L.str3:
    .asciz ""
  .word 18
.L.str27:
    .asciz "Find the integer."
  .word 44
.L.str16:
    .asciz "= g: exit                                 ="
  .word 44
.L.str7:
    .asciz "=                                         ="
  .word 19
.L.str22:
    .asciz "You have entered: "
  .word 19
.L.str20:
    .asciz "You have entered: "
  .word 44
.L.str8:
    .asciz "= Please choose the following options:    ="
  .word 34
.L.str26:
    .asciz "Please enter an integer to find: "
  .word 44
.L.str4:
    .asciz "==========================================="
  .word 44
.L.str5:
    .asciz "========== Hash Table Program ============="
  .word 37
.L.str21:
    .asciz " which is invalid, please try again."
  .word 32
.L.str36:
    .asciz "All integers have been removed."
  .word 52
.L.str25:
    .asciz "The integer is already there. No insertion is made."
  .word 44
.L.str14:
    .asciz "= e: remove an integer                    ="
  .word 24
.L.str32:
    .asciz "Here are the integers: "
  .word 44
.L.str18:
    .asciz "==========================================="
  .word 11
.L.str31:
    .asciz " integers."
  .word 44
.L.str9:
    .asciz "=                                         ="
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#192
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #56
mov r0, r1
bl malloc
mov r4, r0
mov r1, #13
mov r10, r1
str r10, [r4, #0]
mov r1, r4
mov r2, #4
adds r4, r1, r2
blvs _errOverflow
mov r1, #0
mov r9, r1
str r9, [r4, #0]
mov r1, #0
mov r7, r1
str r7, [r4, #4]
mov r1, #0
mov r8, r1
str r8, [r4, #8]
mov r1, #0
mov r6, r1
str r6, [r4, #12]
mov r1, #0
mov r5, r1
str r5, [r4, #16]
mov r1, #0
mov r10, r1
str r10, [r4, #20]
mov r1, #0
mov r9, r1
str r9, [r4, #24]
mov r1, #0
mov r7, r1
str r7, [r4, #28]
mov r1, #0
mov r8, r1
str r8, [r4, #32]
mov r1, #0
mov r6, r1
str r6, [r4, #36]
mov r1, #0
mov r5, r1
str r5, [r4, #40]
mov r1, #0
mov r10, r1
str r10, [r4, #44]
mov r1, #0
mov r9, r1
str r9, [r4, #48]
mov r1, r4
mov r7, r1
mov r1, r7
mov r8, r1
mov r0, r8
bl wacc_init
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, #1
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
cmp r9, #1
bne .L1
.L0:
bl wacc_printMenu
str r7, [fp, #-8]
mov r7, r0
mov r1, r7
str r8, [fp, #-12]
mov r8, r1
mov r1, r8
str r6, [fp, #-16]
mov r6, r1
mov r1, #97
str r5, [fp, #-20]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L14
mov r1, r4
str r4, [fp, #-24]
ldr r4, [fp, #-8]
b 1f
.ltorg
1:
str r10, [fp, #-28]
mov r10, r1
mov r0, r10
bl wacc_handleMenuInsert
str r9, [fp, #-32]
mov r9, r0
mov r1, r9
str r7, [fp, #-36]
mov r7, r1
str r10, [fp, #-40]
ldr r10, [fp, #-28]
str r4, [fp, #-8]
ldr r4, [fp, #-24]
str r5, [fp, #-44]
ldr r5, [fp, #-20]
str r6, [fp, #-48]
ldr r6, [fp, #-16]
str r7, [fp, #-52]
ldr r7, [fp, #-36]
str r9, [fp, #-56]
ldr r9, [fp, #-32]
b .L15
.L14:
mov r1, r8
mov r9, r1
mov r1, #98
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L12
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl wacc_handleMenuFind
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-60]
ldr r10, [fp, #0]
str r4, [fp, #-64]
ldr r4, [fp, #0]
str r5, [fp, #-68]
ldr r5, [fp, #0]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r7, [fp, #-72]
ldr r7, [fp, #0]
str r9, [fp, #-76]
ldr r9, [fp, #0]
b .L13
.L12:
mov r1, r8
mov r9, r1
mov r1, #99
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L10
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl wacc_handleMenuCount
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-80]
ldr r10, [fp, #0]
str r4, [fp, #-84]
ldr r4, [fp, #0]
str r5, [fp, #-88]
ldr r5, [fp, #0]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r7, [fp, #-92]
ldr r7, [fp, #0]
str r9, [fp, #-96]
ldr r9, [fp, #0]
b .L11
.L10:
mov r1, r8
mov r9, r1
mov r1, #100
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L8
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl wacc_handleMenuPrint
mov r4, r0
mov r1, r4
mov r10, r1
b 1f
.ltorg
1:
str r10, [fp, #-100]
ldr r10, [fp, #0]
str r4, [fp, #-104]
ldr r4, [fp, #0]
str r5, [fp, #-108]
ldr r5, [fp, #0]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r7, [fp, #-112]
ldr r7, [fp, #0]
str r9, [fp, #-116]
ldr r9, [fp, #0]
b .L9
.L8:
mov r1, r8
mov r9, r1
mov r1, #101
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L6
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl wacc_handleMenuRemove
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-120]
ldr r10, [fp, #0]
str r4, [fp, #-124]
ldr r4, [fp, #0]
str r5, [fp, #-128]
ldr r5, [fp, #0]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r7, [fp, #-132]
ldr r7, [fp, #0]
str r9, [fp, #-136]
ldr r9, [fp, #0]
b .L7
.L6:
mov r1, r8
mov r9, r1
mov r1, #102
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L4
mov r1, r6
ldr r6, [fp, #-8]
mov r5, r1
mov r0, r5
bl wacc_handleMenuRemoveAll
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-140]
ldr r10, [fp, #0]
str r4, [fp, #-144]
ldr r4, [fp, #0]
str r5, [fp, #-148]
ldr r5, [fp, #0]
str r6, [fp, #-8]
ldr r6, [fp, #0]
str r7, [fp, #-152]
ldr r7, [fp, #0]
str r9, [fp, #-156]
ldr r9, [fp, #0]
b .L5
.L4:
mov r1, r8
mov r9, r1
mov r1, #103
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L2
ldr r1, =.L.str0
mov r6, r1
mov r0, r6
bl _prints
mov r1, #0
mov r5, r1
mov r1, r5
mov r10, r1
str r5, [fp, #-160]
ldr r5, [fp, #0]
str r6, [fp, #-164]
ldr r6, [fp, #0]
str r7, [fp, #-168]
ldr r7, [fp, #0]
str r9, [fp, #-172]
ldr r9, [fp, #0]
b .L3
b 1f
.ltorg
1:
.L2:
ldr r1, =.L.str1
mov r9, r1
mov r0, r9
bl _prints
mov r1, r8
mov r7, r1
mov r0, r7
bl _printc
ldr r1, =.L.str2
mov r6, r1
mov r0, r6
bl _prints
mov r1, #-1
mov r5, r1
mov r0, r5
bl exit
str r5, [fp, #-176]
ldr r5, [fp, #0]
str r6, [fp, #-180]
ldr r6, [fp, #0]
str r7, [fp, #-184]
ldr r7, [fp, #0]
str r9, [fp, #-188]
ldr r9, [fp, #0]
.L3:
.L5:
.L7:
.L9:
.L11:
.L13:
.L15:
mov r1, r10
mov r9, r1
cmp r9, #1
str r7, [fp, #-36]
ldr r7, [fp, #-8]
str r8, [fp, #-192]
ldr r8, [fp, #-12]
beq .L0
.L1:
mov r0, #0
ldr r12, =#192
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

wacc_init:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#52
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
ldr r9, [r1, #-4]
mov r10, r9
mov r1, r10
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
bne .L17
.L16:
mov r1, #4
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-4]
str r7, [fp, #-12]
mov r7, r1
mov r1, r6
str r8, [fp, #-16]
mov r8, r1
mov r1, r8
mov r2, r10
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, #0
str r6, [fp, #-20]
mov r6, r1
mov r1, r6
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-24]
mov r5, r1
str r5, [r7, r8]
mov r1, r4
str r4, [fp, #-28]
ldr r4, [fp, #-20]
str r10, [fp, #-32]
mov r10, r1
mov r1, #1
str r9, [fp, #-4]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r4, r1
mov r1, r4
str r7, [fp, #-36]
ldr r7, [fp, #-24]
mov r7, r1
mov r1, r8
str r8, [fp, #-40]
ldr r8, [fp, #-12]
str r6, [fp, #-44]
ldr r6, [fp, #-28]
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
str r10, [fp, #-48]
ldr r10, [fp, #-8]
mov r1, r4
b 1f
.ltorg
1:
mov r4, r6
mov r6, r1
mov r5, r7
mov r1, r7
mov r7, r8
mov r8, r1
str r8, [fp, #-24]
ldr r8, [fp, #-16]
str r9, [fp, #-52]
beq .L16
.L17:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#52
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

wacc_contain:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#36
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_calculateIndex
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, #4
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r6
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-12]
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
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r0, r7
mov r1, r6
bl wacc_findNode
str r5, [fp, #-28]
mov r5, r0
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
mov r1, r4
str r10, [fp, #-36]
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movne r10, #1
moveq r10, #0
mov r0, r10
b 0f
0:
ldr r12, =#36
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

wacc_insertIfNotContain:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#100
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_calculateIndex
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, #4
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r6
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-12]
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
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r0, r7
mov r1, r6
bl wacc_findNode
str r5, [fp, #-28]
mov r5, r0
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
mov r1, r4
str r10, [fp, #-36]
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movne r10, #1
moveq r10, #0
cmp r10, #1
bne .L18
mov r1, #0
str r7, [fp, #-40]
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-44]
ldr r10, [fp, #-36]
str r7, [fp, #-48]
ldr r7, [fp, #-40]
str r9, [fp, #-52]
b .L19
.L18:
mov r0, #8
bl malloc
mov r9, r0
mov r1, r8
cmp r9, #0
bleq _errNull
mov r7, r1
str r7, [r9, #0]
mov r1, #4
mov r10, r1
mov r1, r8
b 1f
.ltorg
1:
str r8, [fp, #-8]
ldr r8, [fp, #-4]
str r6, [fp, #-56]
mov r6, r1
mov r1, r5
str r5, [fp, #-60]
ldr r5, [fp, #-24]
str r4, [fp, #-64]
mov r4, r1
mov r1, r4
mov r2, r10
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
str r9, [fp, #-68]
ldr r9, [r6, r4]
mov r1, r9
push {r1}
mov r3, r4
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r4
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r7, [fp, #-40]
ldr r7, [fp, #-68]
cmp r7, #0
bleq _errNull
str r10, [fp, #-72]
mov r10, r1
str r10, [r7, #4]
mov r1, r7
str r8, [fp, #-4]
mov r8, r1
mov r1, #4
str r6, [fp, #-76]
mov r6, r1
mov r1, r5
str r5, [fp, #-24]
ldr r5, [fp, #-4]
str r4, [fp, #-80]
mov r4, r1
mov r1, r9
ldr r9, [fp, #-24]
str r7, [fp, #-68]
mov r7, r1
mov r1, r7
mov r2, r6
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
mov r1, r8
push {r1}
mov r3, r7
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r4, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r7
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
mov r10, r1
str r10, [r4, r7]
mov r1, #1
str r8, [fp, #-84]
mov r8, r1
mov r0, r8
b 0f
ldr r10, [fp, #0]
str r4, [fp, #-88]
ldr r4, [fp, #-64]
str r5, [fp, #-4]
ldr r5, [fp, #-60]
str r6, [fp, #-92]
ldr r6, [fp, #-56]
str r7, [fp, #-96]
ldr r7, [fp, #-40]
str r8, [fp, #-100]
ldr r8, [fp, #-8]
str r9, [fp, #-24]
.L19:
0:
ldr r12, =#100
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
pop {r4}
pop {r10}
mov sp, fp
b 1f
.ltorg
1:
pop {fp}
pop {pc}
.ltorg

wacc_remove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#104
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r10
mov r7, r1
mov r0, r9
mov r1, r7
bl wacc_calculateIndex
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, #4
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r6
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-12]
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
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-8]
str r6, [fp, #-24]
mov r6, r1
mov r0, r7
mov r1, r6
bl wacc_findNode
str r5, [fp, #-28]
mov r5, r0
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
mov r1, r4
str r10, [fp, #-36]
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L20
mov r1, #0
str r7, [fp, #-40]
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-44]
ldr r10, [fp, #-36]
str r7, [fp, #-48]
ldr r7, [fp, #-40]
str r9, [fp, #-52]
b .L21
.L20:
mov r1, #4
mov r9, r1
mov r1, r7
ldr r7, [fp, #-4]
mov r10, r1
mov r1, r8
str r8, [fp, #-8]
ldr r8, [fp, #-24]
str r6, [fp, #-56]
mov r6, r1
mov r1, r6
b 1f
.ltorg
1:
mov r2, r9
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #4
str r5, [fp, #-60]
mov r5, r1
mov r1, r7
str r4, [fp, #-64]
mov r4, r1
mov r1, r8
str r9, [fp, #-68]
mov r9, r1
mov r1, r9
mov r2, r5
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
str r7, [fp, #-4]
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
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r10, [fp, #-72]
mov r10, r1
mov r1, r8
str r8, [fp, #-24]
ldr r8, [fp, #-64]
str r6, [fp, #-76]
mov r6, r1
mov r0, r10
mov r1, r6
bl wacc_removeNode
str r5, [fp, #-80]
mov r5, r0
mov r1, r5
str r4, [fp, #-84]
ldr r4, [fp, #-72]
str r9, [fp, #-88]
ldr r9, [fp, #-76]
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
mov r7, r1
str r7, [r4, r9]
mov r1, #1
str r10, [fp, #-92]
mov r10, r1
mov r0, r10
b 0f
str r10, [fp, #-96]
ldr r10, [fp, #0]
str r4, [fp, #-72]
mov r4, r8
str r5, [fp, #-100]
ldr r5, [fp, #-60]
str r6, [fp, #-104]
ldr r6, [fp, #-56]
ldr r7, [fp, #0]
str r8, [fp, #-64]
ldr r8, [fp, #-8]
str r9, [fp, #-76]
.L21:
0:
ldr r12, =#104
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

wacc_removeAll:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#84
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
ldr r9, [r1, #-4]
mov r10, r9
mov r1, r10
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
bne .L23
.L22:
mov r1, #4
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-4]
str r7, [fp, #-12]
mov r7, r1
mov r1, r6
str r8, [fp, #-16]
mov r8, r1
mov r1, r8
mov r2, r10
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-20]
ldr r6, [r7, r8]
mov r1, r6
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-24]
mov r5, r1
mov r1, r5
str r4, [fp, #-28]
mov r4, r1
mov r1, #0
str r10, [fp, #-32]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movne r4, #1
moveq r4, #0
cmp r4, #1
bne .L25
.L24:
str r9, [fp, #-4]
ldr r9, [r5, #4]
mov r1, r9
cmp r5, #0
bleq _errNull
str r7, [fp, #-36]
mov r7, r1
mov r1, r5
str r8, [fp, #-40]
mov r8, r1
mov r0, r8
bl _freepair
mov r1, r7
mov r5, r1
mov r1, r5
mov r4, r1
mov r1, #0
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movne r4, #1
moveq r4, #0
b 1f
.ltorg
1:
cmp r4, #1
str r7, [fp, #-44]
ldr r7, [fp, #-36]
str r8, [fp, #-48]
ldr r8, [fp, #-40]
ldr r9, [fp, #-4]
beq .L24
.L25:
mov r1, #4
mov r9, r1
mov r1, r9
mov r8, r1
mov r1, r7
ldr r7, [fp, #-20]
mov r6, r1
mov r1, r6
mov r2, r9
smull r6, r3, r1, r2
cmp r3, r6, asr #31
blne _errOverflow
mov r1, #0
str r5, [fp, #-52]
mov r5, r1
mov r1, r5
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
str r4, [fp, #-56]
mov r4, r1
str r4, [r8, r6]
mov r1, r7
str r10, [fp, #-60]
mov r10, r1
mov r1, #1
str r9, [fp, #-64]
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r7, r1
mov r1, r7
str r8, [fp, #-68]
ldr r8, [fp, #-24]
mov r8, r1
mov r1, r7
str r7, [fp, #-20]
ldr r7, [fp, #-12]
str r6, [fp, #-72]
ldr r6, [fp, #-28]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
movlt r8, #1
movge r8, #0
cmp r8, #1
str r10, [fp, #-76]
ldr r10, [fp, #-8]
mov r4, r6
str r5, [fp, #-80]
mov r5, r8
str r6, [fp, #-28]
ldr r6, [fp, #-20]
str r8, [fp, #-24]
ldr r8, [fp, #-16]
str r9, [fp, #-84]
beq .L22
.L23:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#84
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

wacc_count:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#76
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
ldr r9, [r1, #-4]
mov r10, r9
mov r1, r10
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
mov r1, r7
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movlt r10, #1
movge r10, #0
cmp r10, #1
bne .L27
.L26:
mov r1, #4
str r7, [fp, #-12]
mov r7, r1
mov r1, r8
str r8, [fp, #-16]
ldr r8, [fp, #-4]
str r6, [fp, #-20]
mov r6, r1
mov r1, r4
str r5, [fp, #-24]
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r4, [fp, #-28]
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
str r10, [fp, #-32]
mov r10, r1
mov r0, r10
bl wacc_countNodes
str r9, [fp, #-36]
mov r9, r0
mov r1, r9
str r7, [fp, #-40]
mov r7, r1
mov r1, r8
str r8, [fp, #-4]
ldr r8, [fp, #-20]
str r6, [fp, #-44]
mov r6, r1
mov r1, r7
str r5, [fp, #-48]
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r8, r1
mov r1, r4
ldr r4, [fp, #-28]
str r10, [fp, #-52]
mov r10, r1
mov r1, #1
str r9, [fp, #-56]
b 1f
.ltorg
1:
mov r9, r1
mov r1, r10
mov r2, r9
adds r10, r1, r2
blvs _errOverflow
mov r1, r10
mov r4, r1
mov r1, r4
str r7, [fp, #-60]
ldr r7, [fp, #-32]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-12]
str r6, [fp, #-64]
ldr r6, [fp, #-36]
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
str r10, [fp, #-68]
mov r10, r7
str r5, [fp, #-72]
ldr r5, [fp, #-24]
str r6, [fp, #-36]
ldr r6, [fp, #-20]
mov r1, r7
mov r7, r8
mov r8, r1
str r8, [fp, #-32]
ldr r8, [fp, #-16]
str r9, [fp, #-76]
ldr r9, [fp, #-36]
beq .L26
.L27:
mov r1, r6
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#76
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

wacc_printAll:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#60
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
ldr r9, [r1, #-4]
mov r10, r9
mov r1, r10
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, r7
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movlt r5, #1
movge r5, #0
cmp r5, #1
bne .L29
.L28:
mov r1, #4
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-4]
str r7, [fp, #-12]
mov r7, r1
mov r1, r6
str r8, [fp, #-16]
mov r8, r1
mov r1, r8
mov r2, r10
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-20]
ldr r6, [r7, r8]
mov r1, r6
push {r1}
mov r3, r8
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r8
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r5, [fp, #-24]
mov r5, r1
mov r0, r5
bl wacc_printAllNodes
str r4, [fp, #-28]
mov r4, r0
mov r1, r4
str r10, [fp, #-32]
mov r10, r1
mov r1, r9
str r9, [fp, #-4]
ldr r9, [fp, #-20]
str r7, [fp, #-36]
mov r7, r1
mov r1, #1
str r8, [fp, #-40]
mov r8, r1
mov r1, r7
mov r2, r8
adds r7, r1, r2
blvs _errOverflow
mov r1, r7
mov r9, r1
mov r1, r9
ldr r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-44]
ldr r5, [fp, #-12]
str r4, [fp, #-48]
ldr r4, [fp, #-28]
mov r4, r1
mov r1, r6
mov r2, r4
cmp r1, r2
movlt r6, #1
movge r6, #0
b 1f
.ltorg
1:
cmp r6, #1
str r10, [fp, #-52]
ldr r10, [fp, #-8]
mov r1, r5
mov r5, r6
mov r6, r1
mov r1, r6
mov r6, r9
mov r9, r1
str r7, [fp, #-56]
mov r7, r9
str r8, [fp, #-60]
ldr r8, [fp, #-16]
str r9, [fp, #-12]
beq .L28
.L29:
ldr r1, =.L.str3
mov r9, r1
mov r0, r9
bl _prints
mov r1, #1
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#60
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

wacc_calculateIndex:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r9
ldr r7, [r1, #-4]
mov r9, r7
mov r1, r9
mov r8, r1
mov r1, r10
mov r6, r1
mov r1, r8
mov r5, r1
mov r1, r6
mov r2, r5
push {r1}
mov r0, r1
mov r1, r2
cmp r1, #0
bleq _errDivZero
bl __aeabi_idivmod
mov r6, r1
pop {r1}
mov r0, r6
b 0f
0:
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

wacc_findNode:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#28
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, #0
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
bne .L31
.L30:
ldr r8, [r4, #0]
mov r1, r8
cmp r4, #0
bleq _errNull
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, r10
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
cmp r5, #1
bne .L32
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
b 0f
str r10, [fp, #-4]
ldr r10, [fp, #-8]
str r4, [fp, #-16]
ldr r4, [fp, #-4]
str r9, [fp, #-20]
ldr r9, [fp, #-12]
str r5, [fp, #-24]
b .L33
.L32:
ldr r5, [r4, #4]
mov r1, r5
cmp r4, #0
bleq _errNull
mov r4, r1
.L33:
mov r1, r4
mov r9, r1
mov r1, #0
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
str r6, [fp, #-28]
beq .L30
.L31:
mov r1, #0
mov r6, r1
mov r0, r6
b 0f
0:
ldr r12, =#28
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

wacc_removeNode:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#56
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, #0
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L36
mov r1, #0
mov r8, r1
mov r0, r8
b 0f
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L37
.L36:
mov r1, r4
mov r9, r1
mov r1, r10
mov r8, r1
mov r1, r9
mov r2, r8
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L34
ldr r7, [r4, #4]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r4, r1
mov r1, r10
mov r6, r1
mov r0, r6
bl _freepair
mov r1, r4
mov r5, r1
mov r0, r5
b 0f
str r5, [fp, #-16]
str r6, [fp, #-20]
str r8, [fp, #-24]
str r9, [fp, #-28]
b .L35
.L34:
ldr r9, [r4, #4]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r10
mov r5, r1
mov r0, r6
mov r1, r5
bl wacc_removeNode
str r4, [fp, #-32]
mov r4, r0
mov r1, r4
str r10, [fp, #-36]
ldr r10, [fp, #-32]
cmp r10, #0
bleq _errNull
mov r7, r1
str r7, [r10, #4]
mov r1, r10
mov r9, r1
mov r0, r9
b 0f
str r10, [fp, #-32]
ldr r10, [fp, #-36]
str r4, [fp, #-40]
ldr r4, [fp, #-32]
str r5, [fp, #-44]
str r6, [fp, #-48]
str r8, [fp, #-52]
str r9, [fp, #-56]
.L35:
.L37:
0:
ldr r12, =#56
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
b 1f
.ltorg
1:
pop {r6}
pop {r5}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_countNodes:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#12
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, #0
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, r4
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movne r7, #1
moveq r7, #0
cmp r7, #1
bne .L39
.L38:
mov r1, r9
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r6
mov r2, r5
adds r6, r1, r2
blvs _errOverflow
mov r1, r6
mov r9, r1
str r10, [fp, #-4]
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r4, r1
mov r1, r4
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movne r7, #1
moveq r7, #0
cmp r7, #1
ldr r10, [fp, #-4]
str r5, [fp, #-8]
str r6, [fp, #-12]
beq .L38
.L39:
mov r1, r9
mov r6, r1
mov r0, r6
b 0f
0:
ldr r12, =#12
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

wacc_printAllNodes:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#20
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
movne r10, #1
moveq r10, #0
cmp r10, #1
bne .L41
.L40:
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
bl _printi
mov r1, #32
mov r5, r1
mov r0, r5
bl _printc
str r10, [fp, #-4]
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r4, r1
mov r1, r4
str r9, [fp, #-8]
ldr r9, [fp, #-4]
mov r9, r1
mov r1, #0
ldr r7, [fp, #-8]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
mov r10, r9
mov r1, r9
mov r9, r7
mov r7, r1
str r5, [fp, #-12]
str r6, [fp, #-16]
str r7, [fp, #-4]
str r8, [fp, #-20]
beq .L40
.L41:
mov r1, #1
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#20
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

wacc_printMenu:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#132
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str4
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str5
mov r10, r1
mov r0, r10
bl _prints
ldr r1, =.L.str6
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str7
mov r7, r1
mov r0, r7
bl _prints
ldr r1, =.L.str8
mov r8, r1
mov r0, r8
bl _prints
ldr r1, =.L.str9
mov r6, r1
mov r0, r6
bl _prints
ldr r1, =.L.str10
mov r5, r1
mov r0, r5
bl _prints
ldr r1, =.L.str11
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str12
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
ldr r1, =.L.str13
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str14
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
ldr r1, =.L.str15
str r8, [fp, #-20]
mov r8, r1
mov r0, r8
bl _prints
ldr r1, =.L.str16
str r6, [fp, #-24]
mov r6, r1
mov r0, r6
bl _prints
ldr r1, =.L.str17
str r5, [fp, #-28]
mov r5, r1
mov r0, r5
bl _prints
ldr r1, =.L.str18
str r4, [fp, #-32]
mov r4, r1
mov r0, r4
bl _prints
mov r1, #97
str r10, [fp, #-36]
mov r10, r1
mov r1, r10
mov r10, r1
mov r1, r10
str r9, [fp, #-40]
mov r9, r1
mov r1, #103
str r7, [fp, #-44]
mov r7, r1
mov r1, r7
mov r7, r1
mov r1, r7
str r8, [fp, #-48]
mov r8, r1
mov r1, #1
str r6, [fp, #-52]
mov r6, r1
cmp r6, #1
bne .L43
b 1f
.ltorg
1:
.L42:
ldr r1, =.L.str19
str r5, [fp, #-56]
mov r5, r1
mov r0, r5
bl _prints
mov r1, #0
str r4, [fp, #-60]
mov r4, r1
mov r1, r4
str r10, [fp, #-64]
mov r10, r1
bl _readc
mov r10, r0
mov r1, r10
str r9, [fp, #-68]
mov r9, r1
mov r1, r9
mov r9, r1
mov r1, r9
str r7, [fp, #-72]
mov r7, r1
mov r1, r8
str r8, [fp, #-76]
ldr r8, [fp, #-68]
str r6, [fp, #-80]
mov r6, r1
mov r1, r7
str r5, [fp, #-84]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movle r6, #1
movgt r6, #0
mov r1, r7
str r4, [fp, #-88]
mov r4, r1
mov r1, r10
str r10, [fp, #-92]
ldr r10, [fp, #-76]
str r9, [fp, #-96]
mov r9, r1
mov r1, r4
mov r2, r9
cmp r1, r2
movle r4, #1
movgt r4, #0
mov r1, r6
mov r2, r4
and r6, r1, r2
cmp r6, #1
bne .L44
mov r1, r7
str r7, [fp, #-100]
ldr r7, [fp, #-92]
str r8, [fp, #-68]
mov r8, r1
mov r0, r8
b 0f
mov r1, r10
mov r10, r7
mov r7, r1
str r4, [fp, #-104]
ldr r4, [fp, #-88]
str r5, [fp, #-108]
ldr r5, [fp, #-84]
str r6, [fp, #-112]
ldr r6, [fp, #-80]
str r7, [fp, #-76]
ldr r7, [fp, #-100]
str r8, [fp, #-116]
ldr r8, [fp, #-76]
str r9, [fp, #-120]
ldr r9, [fp, #-96]
b .L45
.L44:
ldr r1, =.L.str20
mov r9, r1
mov r0, r9
bl _prints
mov r1, r10
mov r8, r1
mov r0, r8
bl _printc
ldr r1, =.L.str21
mov r7, r1
mov r0, r7
bl _prints
str r7, [fp, #-124]
ldr r7, [fp, #0]
str r8, [fp, #-128]
ldr r8, [fp, #0]
str r9, [fp, #-132]
ldr r9, [fp, #0]
.L45:
mov r1, #1
mov r6, r1
cmp r6, #1
str r10, [fp, #-92]
ldr r10, [fp, #-64]
str r4, [fp, #-88]
ldr r4, [fp, #-60]
str r5, [fp, #-84]
ldr r5, [fp, #-56]
str r7, [fp, #-100]
b 1f
.ltorg
1:
ldr r7, [fp, #-72]
str r9, [fp, #-96]
ldr r9, [fp, #-68]
beq .L42
.L43:
mov r1, #0
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#132
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

wacc_askForInt:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r0, r10
bl _prints
mov r1, #0
mov r9, r1
mov r1, r9
mov r7, r1
bl _readi
mov r7, r0
ldr r1, =.L.str22
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
mov r6, r1
mov r0, r6
bl _printi
mov r1, r7
mov r5, r1
mov r0, r5
b 0f
0:
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

wacc_handleMenuInsert:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r1, =.L.str23
mov r10, r1
mov r0, r10
bl wacc_askForInt
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r7
mov r6, r1
mov r0, r8
mov r1, r6
bl wacc_insertIfNotContain
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
cmp r10, #1
bne .L46
ldr r1, =.L.str24
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-16]
ldr r10, [fp, #-8]
str r9, [fp, #-20]
ldr r9, [fp, #-12]
b .L47
.L46:
ldr r1, =.L.str25
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-24]
ldr r9, [fp, #0]
.L47:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#24
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

wacc_handleMenuFind:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r1, =.L.str26
mov r10, r1
mov r0, r10
bl wacc_askForInt
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r7
mov r6, r1
mov r0, r8
mov r1, r6
bl wacc_contain
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
cmp r10, #1
bne .L48
ldr r1, =.L.str27
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-16]
ldr r10, [fp, #-8]
str r9, [fp, #-20]
ldr r9, [fp, #-12]
b .L49
.L48:
ldr r1, =.L.str28
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-24]
ldr r9, [fp, #0]
.L49:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#24
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

wacc_handleMenuCount:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r0, r10
bl wacc_count
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r7
mov r8, r1
mov r1, #1
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
moveq r8, #1
movne r8, #0
cmp r8, #1
bne .L50
ldr r1, =.L.str29
mov r5, r1
mov r0, r5
bl _prints
str r5, [fp, #-4]
str r6, [fp, #-8]
str r8, [fp, #-12]
b .L51
.L50:
ldr r1, =.L.str30
mov r8, r1
mov r0, r8
bl _prints
mov r1, r7
mov r6, r1
mov r0, r6
bl _printi
ldr r1, =.L.str31
mov r5, r1
mov r0, r5
bl _prints
str r5, [fp, #-16]
str r6, [fp, #-20]
str r8, [fp, #-24]
.L51:
mov r1, #1
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#24
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

wacc_handleMenuPrint:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r1, =.L.str32
mov r10, r1
mov r0, r10
bl _prints
mov r1, r4
mov r9, r1
mov r0, r9
bl wacc_printAll
mov r7, r0
mov r1, r7
mov r8, r1
mov r1, #1
mov r6, r1
mov r0, r6
b 0f
0:
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_handleMenuRemove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r1, =.L.str33
mov r10, r1
mov r0, r10
bl wacc_askForInt
mov r9, r0
mov r1, r9
mov r7, r1
mov r1, r4
mov r8, r1
mov r1, r7
mov r6, r1
mov r0, r8
mov r1, r6
bl wacc_remove
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
cmp r10, #1
bne .L52
ldr r1, =.L.str34
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
str r10, [fp, #-16]
ldr r10, [fp, #-8]
str r9, [fp, #-20]
ldr r9, [fp, #-12]
b .L53
.L52:
ldr r1, =.L.str35
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-24]
ldr r9, [fp, #0]
.L53:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#24
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

wacc_handleMenuRemoveAll:
push {lr}
push {fp}
mov fp, sp
push {r10}
push {r4}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r0, r10
bl wacc_removeAll
mov r9, r0
mov r1, r9
mov r7, r1
ldr r1, =.L.str36
mov r8, r1
mov r0, r8
bl _prints
mov r1, #1
mov r6, r1
mov r0, r6
b 0f
0:
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

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
.text
_freepair:
    push {lr}
    push {r8}
    mov r8, r0
    cmp r8, #0
    bleq _errNull
    mov r0, r8
    bl free
    pop {r8}
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
	.word 2
.L._readi_str0:
	.asciz "%d"
.text
_readi:
    push {lr}
    str r0, [sp, #-4]!
    mov r1, sp
    ldr r0, =.L._readi_str0
    bl scanf
    ldr r0, [sp, #0]
	add sp, sp, #4
	pop {pc}
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
	.word 3
.L._readc_str0:
	.asciz " %c"
.text
_readc:
	push {lr}
	strb r0, [sp, #-1]!
	mov r1, sp
	ldr r0, =.L._readc_str0
	bl scanf
	ldrsb r0, [sp, #0]
	add sp, sp, #1
	pop {pc}
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
    

.data
	@ length of .L._errDivZero_str0
		.word 40
.L._errDivZero_str0:
	.asciz "#runtime_error#\n"
.text
_errDivZero:
	ldr r0, =.L._errDivZero_str0
	bl _prints
	mov r0, #255
	bl exit
.ltorg

