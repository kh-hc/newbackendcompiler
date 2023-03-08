.data
  .word 16
.L.str28:
    .asciz " column (1-3): "
  .word 18
.L.str17:
    .asciz "You have chosen: "
  .word 11
.L.str2:
    .asciz "Stalemate!"
  .word 59
.L.str0:
    .asciz "Initialising AI. Please wait, this may take a few minutes."
  .word 2
.L.str23:
    .asciz "3"
  .word 53
.L.str34:
    .asciz "Internal Error: cannot find the next move for the AI"
  .word 2
.L.str19:
    .asciz "1"
  .word 39
.L.str11:
    .asciz "=                                    ="
  .word 32
.L.str33:
    .asciz "AI is cleaning up its memory..."
  .word 17
.L.str15:
    .asciz "Invalid symbol: "
  .word 39
.L.str6:
    .asciz "=                                    ="
  .word 1
.L.str29:
    .asciz ""
  .word 39
.L.str10:
    .asciz "=   q  (quit)                        ="
  .word 10
.L.str1:
    .asciz " has won!"
  .word 40
.L.str13:
    .asciz "Which symbol you would like to choose: "
  .word 32
.L.str35:
    .asciz "AI is cleaning up its memory..."
  .word 1
.L.str24:
    .asciz ""
  .word 39
.L.str12:
    .asciz "======================================"
  .word 40
.L.str30:
    .asciz "Your move is invalid. Please try again."
  .word 39
.L.str3:
    .asciz "========= Tic Tac Toe ================"
  .word 13
.L.str27:
    .asciz " row (1-3): "
  .word 18
.L.str16:
    .asciz "Please try again."
  .word 39
.L.str7:
    .asciz "= Who would you like to be?          ="
  .word 7
.L.str22:
    .asciz " -+-+-"
  .word 7
.L.str20:
    .asciz " -+-+-"
  .word 39
.L.str8:
    .asciz "=   x  (play first)                  ="
  .word 24
.L.str26:
    .asciz "What is your next move?"
  .word 39
.L.str4:
    .asciz "=  Because we know you want to win   ="
  .word 39
.L.str5:
    .asciz "======================================"
  .word 2
.L.str21:
    .asciz "2"
  .word 55
.L.str36:
    .asciz "Internal Error: symbol given is neither \'x\' or \'o\'"
  .word 1
.L.str25:
    .asciz ""
  .word 16
.L.str14:
    .asciz "Goodbye safety."
  .word 9
.L.str32:
    .asciz " column "
  .word 7
.L.str18:
    .asciz " 1 2 3"
  .word 22
.L.str31:
    .asciz "The AI played at row "
  .word 39
.L.str9:
    .asciz "=   o  (play second)                 ="
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#296
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
bl wacc_chooseSymbol
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r10
mov r9, r1
mov r0, r9
bl wacc_oppositeSymbol
mov r7, r0
mov r1, r7
mov r8, r1
mov r1, #120
mov r6, r1
mov r1, r6
mov r5, r1
bl wacc_allocateNewBoard
str r4, [fp, #-4]
mov r4, r0
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
ldr r1, =.L.str0
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
mov r1, r8
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl wacc_initAI
str r8, [fp, #-20]
mov r8, r0
mov r1, r8
str r6, [fp, #-24]
mov r6, r1
mov r1, #0
str r5, [fp, #-28]
mov r5, r1
mov r1, r5
str r4, [fp, #-32]
mov r4, r1
mov r1, #0
str r10, [fp, #-36]
mov r10, r1
mov r1, r10
str r9, [fp, #-40]
mov r9, r1
mov r1, r7
str r7, [fp, #-44]
ldr r7, [fp, #-36]
str r8, [fp, #-48]
mov r8, r1
mov r0, r8
bl wacc_printBoard
str r6, [fp, #-52]
mov r6, r0
mov r1, r6
str r5, [fp, #-56]
mov r5, r1
mov r1, r9
str r4, [fp, #-60]
mov r4, r1
mov r1, #0
str r10, [fp, #-64]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r9
str r9, [fp, #-68]
ldr r9, [fp, #-60]
str r7, [fp, #-36]
mov r7, r1
mov r1, #9
str r8, [fp, #-72]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
mov r1, r4
mov r2, r7
and r4, r1, r2
cmp r4, #1
bne .L1
.L0:
mov r1, #12
str r6, [fp, #-76]
mov r0, r1
b 1f
.ltorg
1:
bl malloc
mov r6, r0
mov r1, #2
str r5, [fp, #-80]
mov r5, r1
str r5, [r6, #0]
mov r1, r6
mov r2, #4
adds r6, r1, r2
blvs _errOverflow
mov r1, #0
str r4, [fp, #-84]
mov r4, r1
str r4, [r6, #0]
mov r1, #0
str r10, [fp, #-88]
mov r10, r1
str r10, [r6, #4]
mov r1, r6
str r9, [fp, #-60]
mov r9, r1
mov r1, r7
str r7, [fp, #-92]
ldr r7, [fp, #-36]
str r8, [fp, #-96]
mov r8, r1
mov r1, r6
str r6, [fp, #-100]
ldr r6, [fp, #-28]
mov r5, r1
mov r1, r4
ldr r4, [fp, #-8]
mov r10, r1
mov r1, r9
str r9, [fp, #-104]
ldr r9, [fp, #-52]
str r7, [fp, #-36]
mov r7, r1
mov r1, r8
str r8, [fp, #-108]
ldr r8, [fp, #-104]
str r6, [fp, #-28]
mov r6, r1
str r5, [fp, #-112]
ldr r5, [fp, #-108]
mov r0, r5
str r4, [fp, #-8]
ldr r4, [fp, #-112]
mov r1, r4
mov r2, r10
mov r3, r7
push {r6}
bl wacc_askForAMove
str r10, [fp, #-116]
mov r10, r0
mov r1, r10
str r9, [fp, #-52]
ldr r9, [fp, #-80]
mov r9, r1
mov r1, r7
str r7, [fp, #-120]
ldr r7, [fp, #-36]
str r8, [fp, #-104]
mov r8, r1
mov r1, r6
str r6, [fp, #-124]
ldr r6, [fp, #-28]
str r5, [fp, #-108]
mov r5, r1
mov r1, #4
str r4, [fp, #-112]
mov r4, r1
mov r1, r10
str r10, [fp, #-128]
ldr r10, [fp, #-104]
str r9, [fp, #-80]
mov r9, r1
mov r1, #0
str r7, [fp, #-36]
mov r7, r1
mov r1, r7
mov r2, r4
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
str r8, [fp, #-132]
ldr r8, [r9, r7]
mov r1, r8
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
str r6, [fp, #-28]
b 1f
.ltorg
1:
mov r6, r1
mov r1, #4
str r5, [fp, #-136]
mov r5, r1
mov r1, r10
str r4, [fp, #-140]
mov r4, r1
mov r1, #1
str r10, [fp, #-104]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
str r9, [fp, #-144]
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
str r7, [fp, #-148]
mov r7, r1
ldr r8, [fp, #-132]
mov r0, r8
str r6, [fp, #-152]
ldr r6, [fp, #-136]
mov r1, r6
str r5, [fp, #-156]
ldr r5, [fp, #-152]
mov r2, r5
mov r3, r7
bl wacc_placeMove
str r4, [fp, #-160]
mov r4, r0
mov r1, r4
str r10, [fp, #-164]
ldr r10, [fp, #-80]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-36]
str r7, [fp, #-168]
mov r7, r1
mov r1, r8
str r8, [fp, #-132]
ldr r8, [fp, #-28]
str r6, [fp, #-136]
mov r6, r1
mov r1, r5
str r5, [fp, #-152]
ldr r5, [fp, #-8]
str r4, [fp, #-172]
mov r4, r1
mov r1, r10
str r10, [fp, #-80]
ldr r10, [fp, #-52]
str r9, [fp, #-36]
mov r9, r1
mov r1, #4
str r7, [fp, #-176]
mov r7, r1
mov r1, r8
str r8, [fp, #-28]
ldr r8, [fp, #-104]
str r6, [fp, #-180]
mov r6, r1
mov r1, #0
str r5, [fp, #-8]
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r4, [fp, #-184]
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
str r10, [fp, #-52]
mov r10, r1
b 1f
.ltorg
1:
mov r1, #4
str r9, [fp, #-188]
mov r9, r1
mov r1, r8
str r7, [fp, #-192]
mov r7, r1
mov r1, #1
str r8, [fp, #-104]
mov r8, r1
mov r1, r8
mov r2, r9
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-196]
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
str r5, [fp, #-200]
mov r5, r1
ldr r4, [fp, #-176]
mov r0, r4
str r10, [fp, #-204]
ldr r10, [fp, #-180]
mov r1, r10
str r9, [fp, #-208]
ldr r9, [fp, #-184]
mov r2, r9
str r7, [fp, #-212]
ldr r7, [fp, #-188]
mov r3, r7
str r8, [fp, #-216]
ldr r8, [fp, #-204]
push {r8}
push {r5}
bl wacc_notifyMove
mov r6, r0
mov r1, r6
str r5, [fp, #-220]
ldr r5, [fp, #-80]
mov r5, r1
mov r1, r4
str r4, [fp, #-176]
ldr r4, [fp, #-36]
str r10, [fp, #-180]
mov r10, r1
mov r0, r10
bl wacc_printBoard
str r9, [fp, #-184]
mov r9, r0
mov r1, r9
mov r5, r1
mov r1, r4
str r7, [fp, #-188]
mov r7, r1
mov r1, r8
str r8, [fp, #-204]
ldr r8, [fp, #-28]
str r6, [fp, #-224]
mov r6, r1
mov r0, r7
mov r1, r6
bl wacc_hasWon
str r5, [fp, #-80]
mov r5, r0
mov r1, r5
str r4, [fp, #-36]
mov r4, r1
mov r1, r4
str r10, [fp, #-228]
mov r10, r1
cmp r10, #1
bne .L2
mov r1, r8
str r9, [fp, #-232]
ldr r9, [fp, #-68]
mov r9, r1
str r10, [fp, #-236]
ldr r10, [fp, #-228]
str r9, [fp, #-68]
ldr r9, [fp, #-232]
b .L3
.L2:
.L3:
mov r1, r8
mov r9, r1
mov r0, r9
bl wacc_oppositeSymbol
mov r10, r0
mov r1, r10
b 1f
.ltorg
1:
mov r8, r1
mov r1, r7
str r7, [fp, #-240]
ldr r7, [fp, #-60]
str r8, [fp, #-28]
mov r8, r1
mov r1, #1
str r6, [fp, #-244]
mov r6, r1
mov r1, r8
mov r2, r6
adds r8, r1, r2
blvs _errOverflow
mov r1, r8
mov r7, r1
mov r1, r5
str r5, [fp, #-248]
ldr r5, [fp, #-68]
str r4, [fp, #-252]
ldr r4, [fp, #-84]
mov r4, r1
mov r1, #0
str r9, [fp, #-256]
ldr r9, [fp, #-88]
mov r9, r1
mov r1, r4
mov r2, r9
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r7
str r10, [fp, #-260]
ldr r10, [fp, #-92]
mov r10, r1
mov r1, #9
str r7, [fp, #-60]
ldr r7, [fp, #-96]
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movlt r10, #1
movge r10, #0
mov r1, r4
mov r2, r10
and r4, r1, r2
cmp r4, #1
mov r1, r10
mov r10, r9
mov r9, r1
str r5, [fp, #-68]
ldr r5, [fp, #-80]
str r6, [fp, #-264]
ldr r6, [fp, #-76]
mov r1, r7
mov r7, r9
mov r9, r1
str r8, [fp, #-268]
mov r8, r9
str r9, [fp, #-96]
ldr r9, [fp, #-60]
beq .L0
.L1:
mov r1, r9
ldr r9, [fp, #-36]
mov r8, r1
mov r0, r8
bl wacc_freeBoard
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, r5
ldr r5, [fp, #-52]
str r4, [fp, #-84]
mov r4, r1
mov r0, r4
bl wacc_destroyAI
str r10, [fp, #-88]
mov r10, r0
mov r1, r10
mov r5, r1
mov r1, r7
str r7, [fp, #-92]
ldr r7, [fp, #-68]
str r9, [fp, #-36]
mov r9, r1
mov r1, #0
str r8, [fp, #-272]
mov r8, r1
mov r1, r9
mov r2, r8
cmp r1, r2
movne r9, #1
moveq r9, #0
cmp r9, #1
bne .L4
mov r1, r7
str r6, [fp, #-276]
mov r6, r1
mov r0, r6
bl _printc
ldr r1, =.L.str1
str r5, [fp, #-52]
mov r5, r1
mov r0, r5
bl _prints
str r5, [fp, #-280]
ldr r5, [fp, #-52]
b 1f
.ltorg
1:
str r6, [fp, #-284]
ldr r6, [fp, #-276]
str r7, [fp, #-68]
ldr r7, [fp, #-92]
str r8, [fp, #-288]
ldr r8, [fp, #-272]
str r9, [fp, #-292]
ldr r9, [fp, #-36]
b .L5
.L4:
ldr r1, =.L.str2
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-296]
ldr r9, [fp, #0]
.L5:
mov r0, #0
ldr r12, =#296
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

wacc_chooseSymbol:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#144
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
ldr r1, =.L.str3
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str4
mov r10, r1
mov r0, r10
bl _prints
ldr r1, =.L.str5
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str6
mov r7, r1
mov r0, r7
bl _prints
ldr r1, =.L.str7
mov r8, r1
mov r0, r8
bl _prints
ldr r1, =.L.str8
mov r6, r1
mov r0, r6
bl _prints
ldr r1, =.L.str9
mov r5, r1
mov r0, r5
bl _prints
ldr r1, =.L.str10
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str11
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl _prints
ldr r1, =.L.str12
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
mov r1, #0
str r7, [fp, #-16]
mov r7, r1
mov r1, r7
str r8, [fp, #-20]
mov r8, r1
mov r1, r8
str r6, [fp, #-24]
mov r6, r1
mov r1, #0
str r5, [fp, #-28]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L7
.L6:
ldr r1, =.L.str13
str r4, [fp, #-32]
mov r4, r1
mov r0, r4
bl _prints
mov r1, #0
str r10, [fp, #-36]
mov r10, r1
mov r1, r10
str r9, [fp, #-40]
mov r9, r1
bl _readc
mov r9, r0
mov r1, r9
str r7, [fp, #-44]
mov r7, r1
mov r1, #120
str r8, [fp, #-48]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r9
str r6, [fp, #-52]
mov r6, r1
mov r1, #88
str r5, [fp, #-56]
mov r5, r1
b 1f
.ltorg
1:
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r7
mov r2, r6
orr r7, r1, r2
cmp r7, #1
bne .L12
mov r1, #120
str r4, [fp, #-60]
mov r4, r1
mov r1, r4
str r10, [fp, #-64]
ldr r10, [fp, #-48]
mov r10, r1
str r10, [fp, #-48]
ldr r10, [fp, #-64]
str r4, [fp, #-68]
ldr r4, [fp, #-60]
str r5, [fp, #-72]
ldr r5, [fp, #-56]
str r6, [fp, #-76]
ldr r6, [fp, #-52]
str r7, [fp, #-80]
ldr r7, [fp, #-44]
str r8, [fp, #-84]
ldr r8, [fp, #-48]
b .L13
.L12:
mov r1, r9
mov r8, r1
mov r1, #111
mov r7, r1
mov r1, r8
mov r2, r7
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r1, r9
mov r6, r1
mov r1, #79
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r8
mov r2, r6
orr r8, r1, r2
cmp r8, #1
bne .L10
mov r1, #111
mov r4, r1
mov r1, r4
mov r8, r1
str r4, [fp, #-88]
ldr r4, [fp, #0]
str r5, [fp, #-92]
ldr r5, [fp, #0]
str r6, [fp, #-96]
ldr r6, [fp, #0]
str r7, [fp, #-100]
ldr r7, [fp, #0]
str r8, [fp, #-104]
ldr r8, [fp, #0]
b .L11
.L10:
mov r1, r9
mov r8, r1
mov r1, #113
mov r7, r1
mov r1, r8
mov r2, r7
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r1, r9
mov r6, r1
mov r1, #81
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r8
mov r2, r6
orr r8, r1, r2
cmp r8, #1
bne .L8
ldr r1, =.L.str14
mov r4, r1
mov r0, r4
bl _prints
mov r1, #0
mov r10, r1
mov r0, r10
bl exit
str r10, [fp, #-108]
ldr r10, [fp, #0]
str r4, [fp, #-112]
ldr r4, [fp, #0]
str r5, [fp, #-116]
ldr r5, [fp, #0]
str r6, [fp, #-120]
ldr r6, [fp, #0]
str r7, [fp, #-124]
ldr r7, [fp, #0]
str r8, [fp, #-128]
b 1f
.ltorg
1:
ldr r8, [fp, #0]
b .L9
.L8:
ldr r1, =.L.str15
mov r8, r1
mov r0, r8
bl _prints
mov r1, r9
mov r7, r1
mov r0, r7
bl _printc
ldr r1, =.L.str16
mov r6, r1
mov r0, r6
bl _prints
str r6, [fp, #-132]
ldr r6, [fp, #0]
str r7, [fp, #-136]
ldr r7, [fp, #0]
str r8, [fp, #-140]
ldr r8, [fp, #0]
.L9:
.L11:
.L13:
mov r1, r8
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
str r10, [fp, #-64]
ldr r10, [fp, #-36]
str r4, [fp, #-60]
ldr r4, [fp, #-32]
str r9, [fp, #-144]
ldr r9, [fp, #-40]
beq .L6
.L7:
ldr r1, =.L.str17
mov r9, r1
mov r0, r9
bl _prints
mov r1, r8
mov r4, r1
mov r0, r4
bl _printc
mov r1, r8
mov r10, r1
mov r0, r10
b 0f
0:
ldr r12, =#144
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

wacc_printBoard:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
ldr r1, =.L.str18
mov r7, r1
mov r0, r7
bl _prints
ldr r1, =.L.str19
str r8, [fp, #-8]
mov r8, r1
mov r0, r8
bl _prints
mov r1, r6
ldr r6, [fp, #-8]
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_printRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r10, r1
ldr r1, =.L.str20
str r9, [fp, #-20]
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str21
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
bl _prints
mov r1, r8
str r8, [fp, #-28]
ldr r8, [fp, #-12]
str r6, [fp, #-8]
mov r6, r1
mov r0, r6
bl wacc_printRow
str r5, [fp, #-32]
mov r5, r0
mov r1, r5
mov r10, r1
ldr r1, =.L.str22
str r4, [fp, #-36]
mov r4, r1
mov r0, r4
bl _prints
ldr r1, =.L.str23
str r10, [fp, #-40]
mov r10, r1
mov r0, r10
bl _prints
mov r1, r9
str r9, [fp, #-44]
ldr r9, [fp, #-20]
str r7, [fp, #-48]
mov r7, r1
mov r0, r7
bl wacc_printRow
str r8, [fp, #-12]
mov r8, r0
mov r1, r8
str r6, [fp, #-52]
ldr r6, [fp, #-40]
mov r6, r1
ldr r1, =.L.str24
str r5, [fp, #-56]
mov r5, r1
mov r0, r5
b 1f
.ltorg
1:
bl _prints
mov r1, #1
str r4, [fp, #-60]
mov r4, r1
mov r0, r4
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

wacc_printRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#44
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_printCell
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, #124
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl _printc
mov r1, r4
str r4, [fp, #-16]
ldr r4, [fp, #-12]
mov r10, r1
mov r0, r10
bl wacc_printCell
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, #124
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
bl _printc
mov r1, r8
str r8, [fp, #-28]
ldr r8, [fp, #-20]
str r6, [fp, #-32]
mov r6, r1
mov r0, r6
bl wacc_printCell
str r5, [fp, #-36]
mov r5, r0
mov r1, r5
str r4, [fp, #-12]
ldr r4, [fp, #-32]
mov r4, r1
ldr r1, =.L.str25
str r10, [fp, #-40]
mov r10, r1
mov r0, r10
bl _prints
mov r1, #1
str r9, [fp, #-44]
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#44
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

wacc_printCell:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
subs sp, sp, r12
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L14
mov r1, #32
mov r7, r1
mov r0, r7
bl _printc
str r10, [fp, #-4]
str r7, [fp, #-8]
str r9, [fp, #-12]
b .L15
.L14:
mov r1, r4
mov r9, r1
mov r0, r9
bl _printc
str r9, [fp, #-16]
.L15:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#16
adds sp, sp, r12
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_askForAMoveHuman:
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
mov r1, #0
mov r9, r1
mov r1, r9
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
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
cmp r10, #1
bne .L17
.L16:
ldr r1, =.L.str26
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _prints
ldr r1, =.L.str27
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
bl _prints
bl _readi
mov r6, r0
ldr r1, =.L.str28
str r8, [fp, #-20]
mov r8, r1
mov r0, r8
bl _prints
bl _readi
mov r4, r0
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-4]
str r5, [fp, #-28]
mov r5, r1
mov r1, r4
str r4, [fp, #-32]
ldr r4, [fp, #-24]
str r10, [fp, #-36]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-32]
str r7, [fp, #-44]
mov r7, r1
mov r0, r5
mov r1, r10
mov r2, r7
bl wacc_validateMove
str r8, [fp, #-48]
mov r8, r0
mov r1, r8
str r6, [fp, #-4]
ldr r6, [fp, #-16]
mov r6, r1
mov r1, r6
str r5, [fp, #-52]
mov r5, r1
cmp r5, #1
bne .L18
ldr r1, =.L.str29
str r4, [fp, #-24]
mov r4, r1
mov r0, r4
bl _prints
mov r1, #4
str r10, [fp, #-56]
mov r10, r1
mov r1, r9
str r9, [fp, #-32]
ldr r9, [fp, #-8]
str r7, [fp, #-60]
mov r7, r1
mov r1, #0
str r8, [fp, #-64]
mov r8, r1
mov r1, r8
mov r2, r10
b 1f
.ltorg
1:
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, r6
str r6, [fp, #-16]
ldr r6, [fp, #-24]
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
str r5, [fp, #-68]
mov r5, r1
str r5, [r7, r8]
mov r1, #4
str r4, [fp, #-72]
mov r4, r1
mov r1, r9
str r10, [fp, #-76]
mov r10, r1
mov r1, #1
str r9, [fp, #-8]
mov r9, r1
mov r1, r9
mov r2, r4
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r1, r7
str r7, [fp, #-80]
ldr r7, [fp, #-32]
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
str r8, [fp, #-84]
mov r8, r1
str r8, [r10, r9]
mov r1, #1
str r6, [fp, #-24]
mov r6, r1
mov r0, r6
b 0f
str r10, [fp, #-88]
ldr r10, [fp, #-56]
str r4, [fp, #-92]
ldr r4, [fp, #-24]
ldr r5, [fp, #-52]
str r6, [fp, #-96]
ldr r6, [fp, #-16]
str r7, [fp, #-32]
ldr r7, [fp, #-60]
ldr r8, [fp, #-64]
str r9, [fp, #-100]
ldr r9, [fp, #-32]
b .L19
.L18:
ldr r1, =.L.str30
mov r9, r1
mov r0, r9
bl _prints
str r9, [fp, #-104]
ldr r9, [fp, #0]
.L19:
mov r1, r6
ldr r9, [fp, #-36]
mov r9, r1
mov r1, r9
cmp r9, #1
str r10, [fp, #-56]
mov r10, r9
str r4, [fp, #-24]
ldr r4, [fp, #0]
str r5, [fp, #-52]
ldr r5, [fp, #-28]
str r6, [fp, #-16]
ldr r6, [fp, #-24]
str r7, [fp, #-60]
ldr r7, [fp, #-16]
str r8, [fp, #-64]
ldr r8, [fp, #-20]
str r9, [fp, #-36]
ldr r9, [fp, #-12]
beq .L16
.L17:
b 1f
.ltorg
1:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
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

wacc_validateMove:
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
mov r10, r1
mov r9, r2
mov r1, #1
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movle r7, #1
movgt r7, #0
mov r1, r10
mov r6, r1
mov r1, #3
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movle r6, #1
movgt r6, #0
mov r1, r7
mov r2, r6
and r7, r1, r2
mov r1, #1
str r4, [fp, #-4]
mov r4, r1
mov r1, r9
str r10, [fp, #-8]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
movle r4, #1
movgt r4, #0
mov r1, r7
mov r2, r4
and r7, r1, r2
mov r1, r9
str r9, [fp, #-12]
mov r9, r1
mov r1, #3
str r7, [fp, #-16]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movle r9, #1
movgt r9, #0
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-16]
mov r2, r9
and r8, r1, r2
cmp r8, #1
bne .L20
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-4]
str r5, [fp, #-28]
mov r5, r1
mov r1, r4
str r4, [fp, #-32]
ldr r4, [fp, #-8]
str r10, [fp, #-36]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-12]
str r7, [fp, #-44]
mov r7, r1
mov r0, r5
mov r1, r10
mov r2, r7
bl wacc_symbolAt
str r8, [fp, #-16]
mov r8, r0
mov r1, r8
str r6, [fp, #-4]
mov r6, r1
mov r1, r6
str r5, [fp, #-48]
mov r5, r1
mov r1, #0
str r4, [fp, #-8]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
mov r0, r5
b 0f
str r10, [fp, #-52]
ldr r10, [fp, #-8]
str r4, [fp, #-56]
ldr r4, [fp, #-4]
str r5, [fp, #-60]
str r6, [fp, #-64]
b 1f
.ltorg
1:
str r7, [fp, #-68]
str r8, [fp, #-72]
b .L21
.L20:
mov r1, #0
mov r8, r1
mov r0, r8
b 0f
str r8, [fp, #-76]
.L21:
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

wacc_notifyMoveHuman:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
ldr r1, =.L.str31
mov r6, r1
mov r0, r6
bl _prints
mov r1, r7
mov r5, r1
mov r0, r5
bl _printi
ldr r1, =.L.str32
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #8]
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
bl _printi
mov r1, #1
str r7, [fp, #-16]
mov r7, r1
mov r0, r7
b 0f
0:
ldr r12, =#16
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

wacc_initAI:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#44
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
mov r0, #8
bl malloc
mov r10, r0
mov r1, r4
cmp r10, #0
bleq _errNull
mov r9, r1
str r9, [r10, #0]
mov r1, #0
cmp r10, #0
bleq _errNull
mov r7, r1
str r7, [r10, #4]
mov r1, r10
mov r8, r1
mov r1, r4
mov r6, r1
mov r0, r6
bl wacc_generateAllPossibleStates
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-4]
mov r7, r1
mov r1, #120
str r8, [fp, #-12]
mov r8, r1
mov r0, r10
mov r1, r7
mov r2, r8
bl wacc_setValuesForAllStates
str r6, [fp, #-16]
mov r6, r0
mov r1, r6
str r5, [fp, #-20]
mov r5, r1
str r4, [fp, #-24]
mov r0, #8
bl malloc
mov r4, r0
mov r1, r10
str r10, [fp, #-28]
ldr r10, [fp, #-12]
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
str r9, [r4, #0]
mov r1, r7
str r7, [fp, #-32]
ldr r7, [fp, #-24]
cmp r4, #0
bleq _errNull
str r8, [fp, #-36]
mov r8, r1
str r8, [r4, #4]
mov r1, r4
str r6, [fp, #-40]
mov r6, r1
mov r1, r6
str r5, [fp, #-44]
mov r5, r1
mov r0, r5
b 0f
0:
ldr r12, =#44
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

wacc_generateAllPossibleStates:
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
bl wacc_allocateNewBoard
mov r10, r0
mov r1, r10
mov r9, r1
mov r1, r9
mov r7, r1
mov r0, r7
bl wacc_convertFromBoardToState
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, #120
str r4, [fp, #-4]
mov r4, r1
mov r0, r5
mov r1, r4
bl wacc_generateNextStates
str r10, [fp, #-8]
mov r10, r0
mov r1, r10
mov r6, r1
mov r1, r6
str r9, [fp, #-12]
mov r9, r1
mov r0, r9
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

wacc_convertFromBoardToState:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
bl wacc_generateEmptyPointerBoard
mov r10, r0
mov r1, r10
mov r9, r1
mov r0, #8
bl malloc
mov r7, r0
mov r1, r4
cmp r7, #0
bleq _errNull
mov r8, r1
str r8, [r7, #0]
mov r1, r9
cmp r7, #0
bleq _errNull
mov r6, r1
str r6, [r7, #4]
mov r1, r7
mov r5, r1
str r4, [fp, #-4]
mov r0, #8
bl malloc
mov r4, r0
mov r1, r5
cmp r4, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
str r10, [r4, #0]
mov r1, #0
cmp r4, #0
bleq _errNull
str r9, [fp, #-12]
mov r9, r1
str r9, [r4, #4]
mov r1, r4
str r7, [fp, #-16]
mov r7, r1
mov r1, r7
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#16
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

wacc_generateEmptyPointerBoard:
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
bl wacc_generateEmptyPointerRow
mov r4, r0
mov r1, r4
mov r10, r1
bl wacc_generateEmptyPointerRow
mov r9, r0
mov r1, r9
mov r7, r1
bl wacc_generateEmptyPointerRow
mov r8, r0
mov r1, r8
mov r6, r1
mov r0, #8
bl malloc
mov r5, r0
mov r1, r10
cmp r5, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
str r4, [r5, #0]
mov r1, r7
cmp r5, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
str r10, [r5, #4]
mov r1, r5
str r9, [fp, #-12]
mov r9, r1
str r7, [fp, #-16]
mov r0, #8
bl malloc
mov r7, r0
mov r1, r9
cmp r7, #0
bleq _errNull
str r8, [fp, #-20]
mov r8, r1
str r8, [r7, #0]
mov r1, r6
cmp r7, #0
bleq _errNull
str r6, [fp, #-24]
mov r6, r1
str r6, [r7, #4]
mov r1, r7
str r5, [fp, #-28]
mov r5, r1
mov r1, r5
mov r4, r1
mov r0, r4
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

wacc_generateEmptyPointerRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r0, #8
bl malloc
mov r4, r0
mov r1, #0
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #0
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #4]
mov r1, r4
mov r7, r1
mov r0, #8
bl malloc
mov r8, r0
mov r1, r7
cmp r8, #0
bleq _errNull
mov r6, r1
str r6, [r8, #0]
mov r1, #0
cmp r8, #0
bleq _errNull
mov r5, r1
str r5, [r8, #4]
mov r1, r8
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r0, r10
b 0f
0:
ldr r12, =#4
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

wacc_generateNextStates:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#80
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
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r8, [r7, #0]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r6, r1
ldr r5, [r7, #4]
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r0, r10
bl wacc_oppositeSymbol
mov r9, r0
mov r1, r9
str r7, [fp, #-12]
mov r7, r1
mov r1, r6
mov r8, r1
mov r1, r7
str r6, [fp, #-16]
mov r6, r1
mov r0, r8
mov r1, r6
bl wacc_hasWon
mov r5, r0
mov r1, r5
str r4, [fp, #-20]
mov r4, r1
mov r1, r4
str r10, [fp, #-24]
mov r10, r1
cmp r10, #1
bne .L22
mov r1, r9
str r9, [fp, #-28]
ldr r9, [fp, #-4]
str r7, [fp, #-32]
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-36]
ldr r10, [fp, #-24]
str r7, [fp, #-40]
ldr r7, [fp, #-32]
str r9, [fp, #-4]
ldr r9, [fp, #-28]
b .L23
.L22:
mov r1, r9
ldr r9, [fp, #-16]
mov r7, r1
mov r1, r10
ldr r10, [fp, #-20]
str r8, [fp, #-44]
mov r8, r1
mov r1, r6
str r6, [fp, #-48]
ldr r6, [fp, #-8]
str r5, [fp, #-52]
mov r5, r1
mov r0, r7
mov r1, r8
mov r2, r5
bl wacc_generateNextStatesBoard
str r4, [fp, #-56]
mov r4, r0
mov r1, r4
str r9, [fp, #-16]
mov r9, r1
mov r1, r7
str r7, [fp, #-60]
ldr r7, [fp, #-4]
str r10, [fp, #-20]
mov r10, r1
mov r0, r10
b 0f
str r10, [fp, #-64]
ldr r10, [fp, #0]
b 1f
.ltorg
1:
str r4, [fp, #-68]
ldr r4, [fp, #-56]
str r5, [fp, #-72]
ldr r5, [fp, #-52]
str r6, [fp, #-8]
ldr r6, [fp, #-48]
str r7, [fp, #-4]
ldr r7, [fp, #0]
str r8, [fp, #-76]
ldr r8, [fp, #-44]
str r9, [fp, #-80]
ldr r9, [fp, #0]
.L23:
0:
ldr r12, =#80
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

wacc_generateNextStatesBoard:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#108
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
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
str r5, [fp, #-20]
ldr r5, [r6, #0]
mov r1, r5
ldr r6, [fp, #-8]
cmp r6, #0
bleq _errNull
mov r4, r1
str r10, [fp, #-24]
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
ldr r7, [r4, #4]
mov r1, r7
cmp r4, #0
bleq _errNull
str r8, [fp, #-28]
mov r8, r1
ldr r5, [r6, #4]
mov r1, r5
cmp r6, #0
bleq _errNull
str r4, [fp, #-32]
mov r4, r1
mov r1, r10
ldr r10, [fp, #-4]
str r9, [fp, #-36]
mov r9, r1
mov r1, r7
ldr r7, [fp, #-20]
str r8, [fp, #-40]
mov r8, r1
mov r1, r6
str r6, [fp, #-8]
ldr r6, [fp, #-36]
mov r5, r1
mov r1, r4
str r4, [fp, #-44]
ldr r4, [fp, #-12]
str r10, [fp, #-4]
mov r10, r1
mov r1, #1
str r9, [fp, #-48]
mov r9, r1
str r7, [fp, #-20]
ldr r7, [fp, #-48]
mov r0, r7
mov r1, r8
mov r2, r5
mov r3, r10
push {r9}
bl wacc_generateNextStatesRow
str r8, [fp, #-52]
mov r8, r0
mov r1, r8
str r6, [fp, #-36]
mov r6, r1
mov r1, r5
str r5, [fp, #-56]
b 1f
.ltorg
1:
ldr r5, [fp, #-4]
str r4, [fp, #-12]
mov r4, r1
mov r1, r10
str r10, [fp, #-60]
ldr r10, [fp, #-24]
str r9, [fp, #-64]
mov r9, r1
mov r1, r7
str r7, [fp, #-48]
ldr r7, [fp, #-40]
str r8, [fp, #-68]
mov r8, r1
mov r1, r6
str r6, [fp, #-72]
ldr r6, [fp, #-12]
str r5, [fp, #-4]
mov r5, r1
mov r1, #2
str r4, [fp, #-76]
mov r4, r1
str r10, [fp, #-24]
ldr r10, [fp, #-76]
mov r0, r10
mov r1, r9
mov r2, r8
mov r3, r5
push {r4}
bl wacc_generateNextStatesRow
str r9, [fp, #-80]
mov r9, r0
mov r1, r9
str r7, [fp, #-40]
ldr r7, [fp, #-72]
mov r7, r1
mov r1, r8
str r8, [fp, #-84]
ldr r8, [fp, #-4]
str r6, [fp, #-12]
mov r6, r1
mov r1, r5
str r5, [fp, #-88]
ldr r5, [fp, #-28]
str r4, [fp, #-92]
mov r4, r1
mov r1, r10
str r10, [fp, #-76]
ldr r10, [fp, #-44]
str r9, [fp, #-96]
mov r9, r1
mov r1, r7
str r7, [fp, #-72]
ldr r7, [fp, #-12]
str r8, [fp, #-4]
mov r8, r1
mov r1, #3
str r6, [fp, #-100]
mov r6, r1
str r5, [fp, #-28]
ldr r5, [fp, #-100]
mov r0, r5
mov r1, r4
mov r2, r9
mov r3, r8
push {r6}
bl wacc_generateNextStatesRow
str r4, [fp, #-104]
mov r4, r0
mov r1, r4
str r10, [fp, #-44]
ldr r10, [fp, #-72]
mov r10, r1
mov r1, #1
str r9, [fp, #-108]
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#108
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

wacc_generateNextStatesRow:
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
ldr r6, [r10, #0]
mov r1, r6
cmp r10, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r5, #0]
mov r1, r4
cmp r5, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
str r9, [fp, #-12]
ldr r9, [r5, #4]
mov r1, r9
cmp r5, #0
bleq _errNull
str r7, [fp, #-16]
mov r7, r1
ldr r6, [r8, #4]
mov r1, r6
str r8, [fp, #-20]
ldr r8, [fp, #-8]
cmp r8, #0
bleq _errNull
str r5, [fp, #-24]
mov r5, r1
str r10, [fp, #-28]
ldr r10, [r4, #0]
mov r1, r10
ldr r4, [fp, #-12]
cmp r4, #0
bleq _errNull
mov r9, r1
mov r1, r7
str r7, [fp, #-32]
ldr r7, [fp, #-4]
str r8, [fp, #-8]
mov r8, r1
mov r1, r6
ldr r6, [fp, #-28]
str r5, [fp, #-36]
mov r5, r1
mov r1, r4
str r4, [fp, #-12]
ldr r4, [fp, #-16]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-20]
str r7, [fp, #-4]
mov r7, r1
mov r1, #1
str r8, [fp, #-44]
mov r8, r1
str r6, [fp, #-28]
ldr r6, [fp, #-44]
mov r0, r6
mov r1, r5
mov r2, r10
mov r3, r7
push {r8}
bl wacc_generateNextStatesCell
str r5, [fp, #-48]
mov r5, r0
mov r1, r5
str r4, [fp, #-16]
ldr r4, [fp, #-40]
cmp r4, #0
bleq _errNull
str r10, [fp, #-52]
mov r10, r1
str r10, [r4, #0]
mov r1, r9
str r9, [fp, #-20]
ldr r9, [fp, #-4]
str r7, [fp, #-56]
mov r7, r1
mov r1, r8
str r8, [fp, #-60]
ldr r8, [fp, #-32]
str r6, [fp, #-44]
mov r6, r1
mov r1, r5
b 1f
.ltorg
1:
str r5, [fp, #-64]
ldr r5, [fp, #-16]
str r4, [fp, #-40]
mov r4, r1
mov r1, r10
ldr r10, [fp, #-20]
str r9, [fp, #-4]
mov r9, r1
mov r1, #2
str r7, [fp, #-68]
mov r7, r1
str r8, [fp, #-32]
ldr r8, [fp, #-68]
mov r0, r8
mov r1, r6
mov r2, r4
mov r3, r9
push {r7}
bl wacc_generateNextStatesCell
str r6, [fp, #-72]
mov r6, r0
mov r1, r6
str r5, [fp, #-16]
ldr r5, [fp, #-40]
cmp r5, #0
bleq _errNull
str r4, [fp, #-76]
mov r4, r1
str r4, [r5, #4]
mov r1, r10
str r10, [fp, #-20]
ldr r10, [fp, #-4]
str r9, [fp, #-80]
mov r9, r1
mov r1, r7
str r7, [fp, #-84]
ldr r7, [fp, #-36]
str r8, [fp, #-68]
mov r8, r1
mov r1, r6
str r6, [fp, #-88]
ldr r6, [fp, #-16]
str r5, [fp, #-40]
mov r5, r1
mov r1, r4
ldr r4, [fp, #-20]
str r10, [fp, #-4]
mov r10, r1
mov r1, #3
str r9, [fp, #-92]
mov r9, r1
str r7, [fp, #-36]
ldr r7, [fp, #-92]
mov r0, r7
mov r1, r8
mov r2, r5
mov r3, r10
push {r9}
bl wacc_generateNextStatesCell
str r8, [fp, #-96]
mov r8, r0
mov r1, r8
str r6, [fp, #-16]
ldr r6, [fp, #-12]
cmp r6, #0
bleq _errNull
str r5, [fp, #-100]
mov r5, r1
str r5, [r6, #4]
mov r1, #1
str r4, [fp, #-20]
mov r4, r1
mov r0, r4
b 0f
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
pop {fp}
pop {pc}
.ltorg

wacc_generateNextStatesCell:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#108
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
mov r1, r10
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L24
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl wacc_cloneBoard
str r10, [fp, #-8]
mov r10, r0
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r1, r9
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-12]
str r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-28]
ldr r5, [fp, #-16]
str r4, [fp, #-32]
mov r4, r1
mov r1, r10
str r10, [fp, #-36]
ldr r10, [fp, #-20]
str r9, [fp, #-40]
mov r9, r1
mov r0, r7
mov r1, r6
mov r2, r4
mov r3, r9
bl wacc_placeMove
str r7, [fp, #-44]
mov r7, r0
mov r1, r7
str r8, [fp, #-12]
mov r8, r1
mov r1, r6
str r6, [fp, #-48]
ldr r6, [fp, #-40]
str r5, [fp, #-16]
mov r5, r1
mov r0, r5
bl wacc_convertFromBoardToState
str r4, [fp, #-52]
mov r4, r0
mov r1, r4
str r10, [fp, #-20]
mov r10, r1
mov r1, r9
str r9, [fp, #-56]
ldr r9, [fp, #-12]
str r7, [fp, #-60]
mov r7, r1
mov r0, r7
bl wacc_oppositeSymbol
str r8, [fp, #-64]
mov r8, r0
mov r1, r8
str r6, [fp, #-40]
mov r6, r1
mov r1, r10
str r5, [fp, #-68]
mov r5, r1
mov r1, r6
str r4, [fp, #-72]
mov r4, r1
mov r0, r5
mov r1, r4
bl wacc_generateNextStates
str r10, [fp, #-76]
mov r10, r0
mov r1, r10
str r9, [fp, #-12]
b 1f
.ltorg
1:
ldr r9, [fp, #-76]
mov r9, r1
mov r1, r9
str r7, [fp, #-80]
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-84]
ldr r10, [fp, #-8]
str r4, [fp, #-88]
ldr r4, [fp, #-4]
str r7, [fp, #-92]
ldr r7, [fp, #-16]
str r8, [fp, #-96]
ldr r8, [fp, #-20]
str r9, [fp, #-76]
ldr r9, [fp, #-12]
str r5, [fp, #-100]
str r6, [fp, #-104]
b .L25
.L24:
mov r1, #0
mov r6, r1
mov r0, r6
b 0f
str r6, [fp, #-108]
.L25:
0:
ldr r12, =#108
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

wacc_cloneBoard:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
bl wacc_allocateNewBoard
mov r10, r0
mov r1, r10
mov r9, r1
mov r1, r4
mov r7, r1
mov r1, r9
mov r8, r1
mov r0, r7
mov r1, r8
bl wacc_copyBoard
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, r9
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
b 0f
0:
ldr r12, =#4
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

wacc_copyBoard:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#68
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
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r8, [r7, #0]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r6, r1
ldr r5, [r7, #4]
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
ldr r9, [r10, #4]
mov r1, r9
str r10, [fp, #-8]
ldr r10, [fp, #-4]
cmp r10, #0
bleq _errNull
str r7, [fp, #-12]
mov r7, r1
str r6, [fp, #-16]
ldr r6, [r8, #0]
mov r1, r6
ldr r8, [fp, #-8]
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-20]
ldr r4, [r5, #0]
mov r1, r4
cmp r5, #0
bleq _errNull
str r10, [fp, #-4]
mov r10, r1
ldr r9, [r5, #4]
mov r1, r9
cmp r5, #0
bleq _errNull
str r7, [fp, #-24]
mov r7, r1
ldr r6, [r8, #4]
mov r1, r6
cmp r8, #0
bleq _errNull
str r5, [fp, #-28]
mov r5, r1
mov r1, r4
ldr r4, [fp, #-16]
str r10, [fp, #-32]
mov r10, r1
mov r1, r9
ldr r9, [fp, #-32]
str r7, [fp, #-36]
mov r7, r1
mov r0, r10
mov r1, r7
bl wacc_copyRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-40]
ldr r5, [fp, #-20]
str r4, [fp, #-16]
mov r4, r1
mov r1, r10
str r10, [fp, #-44]
ldr r10, [fp, #-36]
str r9, [fp, #-32]
mov r9, r1
mov r0, r4
mov r1, r9
bl wacc_copyRow
str r7, [fp, #-48]
mov r7, r0
mov r1, r7
mov r6, r1
mov r1, r8
str r8, [fp, #-52]
ldr r8, [fp, #-24]
str r6, [fp, #-56]
mov r6, r1
b 1f
.ltorg
1:
mov r1, r5
str r5, [fp, #-20]
ldr r5, [fp, #-40]
str r4, [fp, #-60]
mov r4, r1
mov r0, r6
mov r1, r4
bl wacc_copyRow
str r10, [fp, #-36]
mov r10, r0
mov r1, r10
str r9, [fp, #-64]
ldr r9, [fp, #-56]
mov r9, r1
mov r1, #1
str r7, [fp, #-68]
mov r7, r1
mov r0, r7
b 0f
0:
ldr r12, =#68
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

wacc_copyRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
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
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r8, [r10, #0]
mov r1, r8
cmp r10, #0
bleq _errNull
mov r6, r1
ldr r5, [r7, #0]
mov r1, r5
cmp r7, #0
bleq _errNull
cmp r6, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
str r4, [r6, #0]
str r10, [fp, #-8]
ldr r10, [r7, #4]
mov r1, r10
cmp r7, #0
bleq _errNull
cmp r6, #0
bleq _errNull
mov r9, r1
str r9, [r6, #4]
ldr r8, [r7, #4]
mov r1, r8
str r7, [fp, #-12]
ldr r7, [fp, #-4]
cmp r7, #0
bleq _errNull
str r6, [fp, #-16]
ldr r6, [fp, #-8]
cmp r6, #0
bleq _errNull
mov r5, r1
str r5, [r6, #4]
mov r1, #1
mov r4, r1
mov r0, r4
b 0f
0:
ldr r12, =#16
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

wacc_setValuesForAllStates:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#152
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
mov r9, r2
mov r1, #0
mov r7, r1
mov r1, r7
mov r8, r1
mov r1, r4
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L36
mov r1, r9
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
cmp r4, #1
bne .L26
mov r1, #101
str r9, [fp, #-12]
mov r9, r1
mov r1, r9
mov r8, r1
str r10, [fp, #-16]
ldr r10, [fp, #-8]
str r4, [fp, #-20]
ldr r4, [fp, #-4]
str r9, [fp, #-24]
ldr r9, [fp, #-12]
b .L27
.L26:
mov r1, #-101
mov r9, r1
mov r1, r9
mov r8, r1
str r9, [fp, #-28]
ldr r9, [fp, #0]
.L27:
str r5, [fp, #-32]
str r6, [fp, #-36]
b .L37
.L36:
ldr r6, [r4, #0]
mov r1, r6
cmp r4, #0
bleq _errNull
mov r5, r1
ldr r9, [r5, #0]
mov r1, r9
cmp r5, #0
bleq _errNull
mov r4, r1
ldr r10, [r5, #4]
mov r1, r10
cmp r5, #0
bleq _errNull
str r7, [fp, #-40]
mov r7, r1
mov r1, r9
str r8, [fp, #-44]
mov r8, r1
mov r0, r8
bl wacc_oppositeSymbol
mov r6, r0
mov r1, r6
str r5, [fp, #-48]
mov r5, r1
mov r1, r4
str r9, [fp, #-12]
mov r9, r1
mov r1, r5
str r4, [fp, #-52]
mov r4, r1
mov r0, r9
mov r1, r4
bl wacc_hasWon
str r10, [fp, #-8]
mov r10, r0
mov r1, r10
str r7, [fp, #-56]
b 1f
.ltorg
1:
mov r7, r1
mov r1, r7
str r8, [fp, #-60]
mov r8, r1
cmp r8, #1
bne .L34
mov r1, r5
str r6, [fp, #-64]
mov r6, r1
mov r1, r5
str r5, [fp, #-68]
ldr r5, [fp, #-8]
str r9, [fp, #-72]
mov r9, r1
mov r1, r6
mov r2, r9
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L28
mov r1, #100
str r4, [fp, #-76]
mov r4, r1
mov r1, r4
str r10, [fp, #-80]
ldr r10, [fp, #-44]
mov r10, r1
str r10, [fp, #-44]
ldr r10, [fp, #-80]
str r4, [fp, #-84]
ldr r4, [fp, #-76]
str r5, [fp, #-8]
ldr r5, [fp, #-68]
str r6, [fp, #-88]
ldr r6, [fp, #-64]
str r9, [fp, #-92]
ldr r9, [fp, #-72]
b .L29
.L28:
mov r1, #-100
mov r9, r1
mov r1, r9
ldr r6, [fp, #-44]
mov r6, r1
str r6, [fp, #-44]
ldr r6, [fp, #0]
str r9, [fp, #-96]
ldr r9, [fp, #0]
.L29:
str r8, [fp, #-100]
ldr r8, [fp, #-60]
b .L35
.L34:
mov r1, r8
ldr r8, [fp, #-52]
mov r9, r1
mov r0, r9
bl wacc_containEmptyCell
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, r5
mov r4, r1
cmp r4, #1
bne .L32
mov r1, r10
ldr r10, [fp, #-56]
str r7, [fp, #-104]
mov r7, r1
mov r1, r8
str r8, [fp, #-52]
ldr r8, [fp, #-8]
str r9, [fp, #-108]
mov r9, r1
mov r1, r5
str r6, [fp, #-112]
mov r6, r1
mov r0, r7
mov r1, r9
mov r2, r6
bl wacc_calculateValuesFromNextStates
str r5, [fp, #-116]
mov r5, r0
mov r1, r5
str r4, [fp, #-120]
ldr r4, [fp, #-44]
mov r4, r1
mov r1, r4
str r10, [fp, #-56]
mov r10, r1
mov r1, #100
str r7, [fp, #-124]
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L30
mov r1, #90
str r8, [fp, #-8]
mov r8, r1
mov r1, r8
mov r4, r1
b 1f
.ltorg
1:
str r10, [fp, #-128]
ldr r10, [fp, #-56]
str r7, [fp, #-132]
ldr r7, [fp, #-124]
str r8, [fp, #-136]
ldr r8, [fp, #-8]
b .L31
.L30:
.L31:
str r10, [fp, #-56]
ldr r10, [fp, #0]
str r4, [fp, #-44]
ldr r4, [fp, #0]
str r5, [fp, #-140]
ldr r5, [fp, #-116]
str r6, [fp, #-144]
ldr r6, [fp, #-112]
str r7, [fp, #-124]
ldr r7, [fp, #-104]
str r8, [fp, #-8]
ldr r8, [fp, #-52]
str r9, [fp, #-148]
ldr r9, [fp, #-108]
b .L33
.L32:
mov r1, #0
mov r9, r1
mov r1, r9
ldr r8, [fp, #-44]
mov r8, r1
str r8, [fp, #-44]
ldr r8, [fp, #0]
str r9, [fp, #-152]
ldr r9, [fp, #0]
.L33:
str r5, [fp, #-116]
ldr r5, [fp, #0]
str r6, [fp, #-112]
ldr r6, [fp, #0]
str r8, [fp, #-52]
ldr r8, [fp, #0]
str r9, [fp, #-108]
ldr r9, [fp, #0]
.L35:
mov r1, r9
ldr r9, [fp, #-44]
cmp r4, #0
bleq _errNull
mov r8, r1
str r8, [r4, #4]
str r10, [fp, #-80]
ldr r10, [fp, #-8]
str r4, [fp, #-76]
ldr r4, [fp, #0]
str r7, [fp, #-104]
ldr r7, [fp, #-40]
str r8, [fp, #-60]
mov r8, r9
str r9, [fp, #-44]
ldr r9, [fp, #-12]
str r5, [fp, #-68]
str r6, [fp, #-64]
.L37:
mov r1, r6
ldr r6, [fp, #-44]
mov r5, r1
mov r0, r5
b 0f
0:
ldr r12, =#152
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

wacc_calculateValuesFromNextStates:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#96
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
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
mov r1, r5
mov r6, r1
mov r1, r5
str r5, [fp, #-20]
ldr r5, [fp, #-8]
mov r4, r1
mov r1, r10
str r10, [fp, #-24]
ldr r10, [fp, #-12]
str r9, [fp, #-4]
mov r9, r1
mov r0, r6
mov r1, r4
mov r2, r9
bl wacc_calculateValuesFromNextStatesRow
mov r7, r0
mov r1, r7
str r8, [fp, #-28]
mov r8, r1
mov r1, r6
str r6, [fp, #-32]
ldr r6, [fp, #-24]
str r5, [fp, #-8]
mov r5, r1
mov r1, r4
str r4, [fp, #-36]
ldr r4, [fp, #-8]
str r10, [fp, #-12]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-12]
str r7, [fp, #-44]
mov r7, r1
mov r0, r5
mov r1, r10
mov r2, r7
bl wacc_calculateValuesFromNextStatesRow
str r8, [fp, #-48]
mov r8, r0
mov r1, r8
str r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-52]
ldr r5, [fp, #-28]
str r4, [fp, #-8]
mov r4, r1
mov r1, r10
str r10, [fp, #-56]
ldr r10, [fp, #-8]
str r9, [fp, #-12]
mov r9, r1
mov r1, r7
str r7, [fp, #-60]
ldr r7, [fp, #-12]
str r8, [fp, #-64]
mov r8, r1
mov r0, r4
mov r1, r9
mov r2, r8
b 1f
.ltorg
1:
bl wacc_calculateValuesFromNextStatesRow
str r6, [fp, #-68]
mov r6, r0
mov r1, r6
str r5, [fp, #-28]
mov r5, r1
mov r1, r10
str r4, [fp, #-72]
mov r4, r1
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
str r9, [fp, #-76]
ldr r9, [fp, #-48]
str r7, [fp, #-12]
mov r7, r1
mov r1, r8
str r8, [fp, #-80]
ldr r8, [fp, #-68]
str r6, [fp, #-84]
mov r6, r1
mov r1, r5
str r5, [fp, #-88]
mov r5, r1
mov r0, r4
mov r1, r10
mov r2, r7
mov r3, r6
push {r5}
bl wacc_combineValue
str r4, [fp, #-92]
mov r4, r0
mov r1, r4
str r10, [fp, #-96]
mov r10, r1
mov r1, r10
str r9, [fp, #-48]
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#96
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

wacc_calculateValuesFromNextStatesRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#96
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
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
mov r1, r5
mov r6, r1
mov r1, r5
str r5, [fp, #-20]
ldr r5, [fp, #-8]
mov r4, r1
mov r1, r10
str r10, [fp, #-24]
ldr r10, [fp, #-12]
str r9, [fp, #-4]
mov r9, r1
mov r0, r6
mov r1, r4
mov r2, r9
bl wacc_setValuesForAllStates
mov r7, r0
mov r1, r7
str r8, [fp, #-28]
mov r8, r1
mov r1, r6
str r6, [fp, #-32]
ldr r6, [fp, #-24]
str r5, [fp, #-8]
mov r5, r1
mov r1, r4
str r4, [fp, #-36]
ldr r4, [fp, #-8]
str r10, [fp, #-12]
mov r10, r1
mov r1, r9
str r9, [fp, #-40]
ldr r9, [fp, #-12]
str r7, [fp, #-44]
mov r7, r1
mov r0, r5
mov r1, r10
mov r2, r7
bl wacc_setValuesForAllStates
str r8, [fp, #-48]
mov r8, r0
mov r1, r8
str r6, [fp, #-24]
mov r6, r1
mov r1, r5
str r5, [fp, #-52]
ldr r5, [fp, #-28]
str r4, [fp, #-8]
mov r4, r1
mov r1, r10
str r10, [fp, #-56]
ldr r10, [fp, #-8]
str r9, [fp, #-12]
mov r9, r1
mov r1, r7
str r7, [fp, #-60]
ldr r7, [fp, #-12]
str r8, [fp, #-64]
mov r8, r1
mov r0, r4
mov r1, r9
mov r2, r8
b 1f
.ltorg
1:
bl wacc_setValuesForAllStates
str r6, [fp, #-68]
mov r6, r0
mov r1, r6
str r5, [fp, #-28]
mov r5, r1
mov r1, r10
str r4, [fp, #-72]
mov r4, r1
mov r1, r7
str r10, [fp, #-8]
mov r10, r1
mov r1, r9
str r9, [fp, #-76]
ldr r9, [fp, #-48]
str r7, [fp, #-12]
mov r7, r1
mov r1, r8
str r8, [fp, #-80]
ldr r8, [fp, #-68]
str r6, [fp, #-84]
mov r6, r1
mov r1, r5
str r5, [fp, #-88]
mov r5, r1
mov r0, r4
mov r1, r10
mov r2, r7
mov r3, r6
push {r5}
bl wacc_combineValue
str r4, [fp, #-92]
mov r4, r0
mov r1, r4
str r10, [fp, #-96]
mov r10, r1
mov r1, r10
str r9, [fp, #-48]
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#96
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

wacc_combineValue:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#68
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
mov r1, #0
mov r6, r1
mov r1, r6
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
cmp r4, #1
bne .L38
mov r1, r9
str r9, [fp, #-12]
mov r9, r1
mov r1, r7
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #8]
str r6, [fp, #-24]
mov r6, r1
mov r0, r9
mov r1, r7
mov r2, r6
bl wacc_min3
str r5, [fp, #-28]
mov r5, r0
mov r1, r5
str r4, [fp, #-32]
ldr r4, [fp, #-28]
mov r4, r1
str r10, [fp, #-36]
ldr r10, [fp, #-8]
str r4, [fp, #-28]
ldr r4, [fp, #-4]
str r5, [fp, #-40]
ldr r5, [fp, #-28]
str r6, [fp, #-44]
ldr r6, [fp, #-24]
str r7, [fp, #-48]
ldr r7, [fp, #-16]
str r9, [fp, #-52]
ldr r9, [fp, #-12]
b .L39
.L38:
mov r1, r9
mov r9, r1
mov r1, r7
mov r7, r1
mov r1, r8
mov r6, r1
mov r0, r9
mov r1, r7
mov r2, r6
bl wacc_max3
mov r5, r0
mov r1, r5
mov r5, r1
str r5, [fp, #-56]
ldr r5, [fp, #0]
str r6, [fp, #-60]
ldr r6, [fp, #0]
str r7, [fp, #-64]
ldr r7, [fp, #0]
str r9, [fp, #-68]
ldr r9, [fp, #0]
.L39:
mov r1, r5
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#68
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
b 1f
.ltorg
1:
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_min3:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#44
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
mov r9, r2
mov r1, r4
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movlt r7, #1
movge r7, #0
cmp r7, #1
bne .L44
mov r1, r4
mov r6, r1
mov r1, r9
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movlt r6, #1
movge r6, #0
cmp r6, #1
bne .L40
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
b 0f
str r4, [fp, #-8]
ldr r4, [fp, #-4]
str r5, [fp, #-12]
str r6, [fp, #-16]
b .L41
.L40:
mov r1, r9
mov r6, r1
mov r0, r6
b 0f
str r6, [fp, #-20]
.L41:
str r7, [fp, #-24]
str r8, [fp, #-28]
b .L45
.L44:
mov r1, r10
mov r8, r1
mov r1, r9
mov r7, r1
mov r1, r8
mov r2, r7
cmp r1, r2
movlt r8, #1
movge r8, #0
cmp r8, #1
bne .L42
mov r1, r10
mov r6, r1
mov r0, r6
b 0f
str r6, [fp, #-32]
str r7, [fp, #-36]
str r8, [fp, #-40]
b .L43
.L42:
mov r1, r9
mov r8, r1
mov r0, r8
b 0f
str r8, [fp, #-44]
.L43:
.L45:
0:
ldr r12, =#44
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

wacc_max3:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#44
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
mov r9, r2
mov r1, r4
mov r7, r1
mov r1, r10
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
movgt r7, #1
movle r7, #0
cmp r7, #1
bne .L50
mov r1, r4
mov r6, r1
mov r1, r9
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movgt r6, #1
movle r6, #0
cmp r6, #1
bne .L46
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
b 0f
str r4, [fp, #-8]
ldr r4, [fp, #-4]
str r5, [fp, #-12]
str r6, [fp, #-16]
b .L47
.L46:
mov r1, r9
mov r6, r1
mov r0, r6
b 0f
str r6, [fp, #-20]
.L47:
str r7, [fp, #-24]
str r8, [fp, #-28]
b .L51
.L50:
mov r1, r10
mov r8, r1
mov r1, r9
mov r7, r1
mov r1, r8
mov r2, r7
cmp r1, r2
movgt r8, #1
movle r8, #0
cmp r8, #1
bne .L48
mov r1, r10
mov r6, r1
mov r0, r6
b 0f
str r6, [fp, #-32]
str r7, [fp, #-36]
str r8, [fp, #-40]
b .L49
.L48:
mov r1, r9
mov r8, r1
mov r0, r8
b 0f
str r8, [fp, #-44]
.L49:
.L51:
0:
ldr r12, =#44
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

wacc_destroyAI:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r4, #4]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
bl wacc_deleteStateTreeRecursively
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl _freepair
mov r1, r9
str r9, [fp, #-8]
ldr r9, [fp, #-4]
mov r7, r1
mov r0, r7
bl _freepair
mov r1, #1
str r8, [fp, #-12]
mov r8, r1
mov r0, r8
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

wacc_askForAMoveAI:
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
ldr r6, [r7, #0]
mov r1, r6
cmp r7, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r7, #4]
mov r1, r4
cmp r7, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
str r9, [fp, #-12]
ldr r9, [r10, #0]
mov r1, r9
cmp r10, #0
bleq _errNull
str r7, [fp, #-16]
mov r7, r1
str r8, [fp, #-20]
ldr r8, [r7, #4]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r6, r1
str r5, [fp, #-24]
ldr r5, [r10, #4]
mov r1, r5
cmp r10, #0
bleq _errNull
mov r4, r1
mov r1, r6
str r10, [fp, #-28]
mov r10, r1
mov r1, r4
mov r9, r1
mov r1, r7
str r7, [fp, #-32]
ldr r7, [fp, #-20]
mov r8, r1
mov r0, r10
mov r1, r9
mov r2, r8
bl wacc_findTheBestMove
str r6, [fp, #-36]
mov r6, r0
mov r1, r6
mov r5, r1
ldr r1, =.L.str33
str r4, [fp, #-40]
mov r4, r1
mov r0, r4
bl _prints
mov r1, r10
str r10, [fp, #-44]
ldr r10, [fp, #-36]
str r9, [fp, #-48]
mov r9, r1
mov r1, #4
str r7, [fp, #-20]
mov r7, r1
mov r1, r8
str r8, [fp, #-52]
ldr r8, [fp, #-20]
str r6, [fp, #-56]
mov r6, r1
mov r1, #0
str r5, [fp, #-60]
mov r5, r1
mov r1, r5
mov r2, r7
smull r5, r3, r1, r2
cmp r3, r5, asr #31
blne _errOverflow
str r4, [fp, #-64]
ldr r4, [r6, r5]
mov r1, r4
push {r1}
mov r3, r5
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r6, #-4]
mov r0, #4
b 1f
.ltorg
1:
muls lr, lr, r0
mov r3, r5
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r10, [fp, #-36]
mov r10, r1
mov r1, #4
str r9, [fp, #-68]
mov r9, r1
mov r1, r8
str r7, [fp, #-72]
mov r7, r1
mov r1, #1
str r8, [fp, #-20]
mov r8, r1
mov r1, r8
mov r2, r9
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
str r6, [fp, #-76]
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
str r5, [fp, #-80]
mov r5, r1
ldr r4, [fp, #-68]
mov r0, r4
mov r1, r10
mov r2, r5
bl wacc_deleteAllOtherChildren
str r10, [fp, #-84]
mov r10, r0
mov r1, r10
str r9, [fp, #-88]
ldr r9, [fp, #-16]
cmp r9, #0
bleq _errNull
str r7, [fp, #-92]
mov r7, r1
str r7, [r9, #4]
mov r1, r8
str r8, [fp, #-96]
ldr r8, [fp, #-28]
mov r6, r1
mov r0, r6
bl wacc_deleteThisStateOnly
str r5, [fp, #-100]
mov r5, r0
mov r1, r5
str r4, [fp, #-68]
ldr r4, [fp, #-60]
mov r4, r1
mov r1, #1
str r10, [fp, #-104]
mov r10, r1
mov r0, r10
b 0f
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

wacc_findTheBestMove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#64
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
mov r9, r2
mov r1, r10
mov r7, r1
mov r1, #90
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
cmp r7, #1
bne .L54
mov r1, r4
mov r6, r1
mov r1, #100
mov r5, r1
mov r1, r9
str r4, [fp, #-4]
mov r4, r1
mov r0, r6
mov r1, r5
mov r2, r4
bl wacc_findMoveWithGivenValue
str r10, [fp, #-8]
mov r10, r0
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r1, r9
str r7, [fp, #-16]
mov r7, r1
cmp r7, #1
bne .L52
mov r1, #1
str r8, [fp, #-20]
mov r8, r1
mov r0, r8
b 0f
str r7, [fp, #-24]
ldr r7, [fp, #-16]
str r8, [fp, #-28]
ldr r8, [fp, #-20]
b .L53
.L52:
.L53:
str r10, [fp, #-32]
ldr r10, [fp, #-8]
str r4, [fp, #-36]
ldr r4, [fp, #-4]
str r9, [fp, #-40]
ldr r9, [fp, #-12]
str r5, [fp, #-44]
str r6, [fp, #-48]
str r7, [fp, #-16]
str r8, [fp, #-20]
b .L55
.L54:
.L55:
mov r1, r4
mov r8, r1
mov r1, r10
mov r7, r1
mov r1, r9
mov r6, r1
mov r0, r8
mov r1, r7
mov r2, r6
bl wacc_findMoveWithGivenValue
mov r5, r0
mov r1, r5
mov r9, r1
mov r1, r9
mov r4, r1
cmp r4, #1
bne .L56
mov r1, #1
mov r10, r1
mov r0, r10
b 0f
str r10, [fp, #-52]
ldr r10, [fp, #0]
str r4, [fp, #-56]
ldr r4, [fp, #0]
b .L57
.L56:
ldr r1, =.L.str34
mov r4, r1
mov r0, r4
bl _prints
b 1f
.ltorg
1:
mov r1, #-1
mov r10, r1
mov r0, r10
bl exit
str r10, [fp, #-60]
ldr r10, [fp, #0]
str r4, [fp, #-64]
ldr r4, [fp, #0]
.L57:
0:
ldr r12, =#64
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

wacc_findMoveWithGivenValue:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#144
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
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
mov r1, r5
mov r6, r1
mov r1, r5
str r5, [fp, #-20]
ldr r5, [fp, #-8]
mov r4, r1
mov r1, r10
str r10, [fp, #-24]
ldr r10, [fp, #-12]
str r9, [fp, #-4]
mov r9, r1
mov r0, r6
mov r1, r4
mov r2, r9
bl wacc_findMoveWithGivenValueRow
mov r7, r0
mov r1, r7
str r8, [fp, #-28]
mov r8, r1
mov r1, r8
str r6, [fp, #-32]
mov r6, r1
cmp r6, #1
bne .L62
mov r1, #4
str r5, [fp, #-8]
mov r5, r1
mov r1, r10
str r4, [fp, #-36]
mov r4, r1
mov r1, #0
str r10, [fp, #-12]
mov r10, r1
mov r1, r10
mov r2, r5
smull r10, r3, r1, r2
cmp r3, r10, asr #31
blne _errOverflow
mov r1, #1
str r9, [fp, #-40]
mov r9, r1
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
str r7, [fp, #-44]
mov r7, r1
str r7, [r4, r10]
str r10, [fp, #-48]
ldr r10, [fp, #-12]
str r4, [fp, #-52]
b 1f
.ltorg
1:
ldr r4, [fp, #-36]
str r5, [fp, #-56]
ldr r5, [fp, #-8]
str r6, [fp, #-60]
ldr r6, [fp, #-32]
ldr r7, [fp, #-44]
str r9, [fp, #-64]
ldr r9, [fp, #-40]
b .L63
.L62:
mov r1, r9
ldr r9, [fp, #-24]
mov r7, r1
mov r1, r5
mov r6, r1
mov r1, r10
mov r5, r1
mov r0, r7
mov r1, r6
mov r2, r5
bl wacc_findMoveWithGivenValueRow
mov r4, r0
mov r1, r4
mov r8, r1
mov r1, r8
mov r10, r1
cmp r10, #1
bne .L60
mov r1, #4
str r8, [fp, #-68]
mov r8, r1
mov r1, r10
str r9, [fp, #-24]
mov r9, r1
mov r1, #0
str r7, [fp, #-72]
mov r7, r1
mov r1, r7
mov r2, r8
smull r7, r3, r1, r2
cmp r3, r7, asr #31
blne _errOverflow
mov r1, #2
str r6, [fp, #-76]
mov r6, r1
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
str r5, [fp, #-80]
mov r5, r1
str r5, [r9, r7]
str r10, [fp, #-84]
ldr r10, [fp, #0]
ldr r5, [fp, #-80]
str r6, [fp, #-88]
ldr r6, [fp, #-76]
str r7, [fp, #-92]
ldr r7, [fp, #-72]
str r8, [fp, #-96]
ldr r8, [fp, #-68]
str r9, [fp, #-100]
ldr r9, [fp, #-24]
b .L61
.L60:
mov r1, r9
ldr r9, [fp, #-28]
mov r8, r1
mov r1, r5
mov r7, r1
mov r1, r10
mov r6, r1
mov r0, r8
mov r1, r7
mov r2, r6
bl wacc_findMoveWithGivenValueRow
mov r5, r0
mov r1, r5
mov r8, r1
mov r1, r8
mov r10, r1
cmp r10, #1
bne .L58
mov r1, #4
str r4, [fp, #-104]
mov r4, r1
mov r1, r10
str r9, [fp, #-28]
mov r9, r1
mov r1, #0
str r8, [fp, #-108]
mov r8, r1
b 1f
.ltorg
1:
mov r1, r8
mov r2, r4
smull r8, r3, r1, r2
cmp r3, r8, asr #31
blne _errOverflow
mov r1, #3
str r7, [fp, #-112]
mov r7, r1
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
str r6, [fp, #-116]
mov r6, r1
str r6, [r9, r8]
str r10, [fp, #-120]
ldr r10, [fp, #0]
str r4, [fp, #-124]
ldr r4, [fp, #-104]
ldr r6, [fp, #-116]
str r7, [fp, #-128]
ldr r7, [fp, #-112]
str r8, [fp, #-132]
ldr r8, [fp, #-108]
str r9, [fp, #-136]
ldr r9, [fp, #-28]
b .L59
.L58:
mov r1, #0
mov r9, r1
mov r0, r9
b 0f
str r9, [fp, #-140]
ldr r9, [fp, #0]
.L59:
str r5, [fp, #-144]
ldr r5, [fp, #0]
str r6, [fp, #-116]
ldr r6, [fp, #0]
str r7, [fp, #-112]
ldr r7, [fp, #0]
str r8, [fp, #-108]
ldr r8, [fp, #0]
str r9, [fp, #-28]
ldr r9, [fp, #0]
.L61:
str r4, [fp, #-104]
ldr r4, [fp, #0]
str r5, [fp, #-80]
ldr r5, [fp, #0]
str r6, [fp, #-76]
ldr r6, [fp, #0]
str r7, [fp, #-72]
ldr r7, [fp, #0]
str r9, [fp, #-24]
ldr r9, [fp, #0]
.L63:
mov r1, #1
mov r9, r1
mov r0, r9
b 0f
0:
ldr r12, =#144
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

wacc_findMoveWithGivenValueRow:
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
mov r4, r0
mov r10, r1
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
mov r1, r5
mov r6, r1
mov r1, r5
str r5, [fp, #-20]
ldr r5, [fp, #-8]
mov r4, r1
mov r0, r6
mov r1, r4
bl wacc_hasGivenStateValue
str r10, [fp, #-24]
mov r10, r0
mov r1, r10
str r9, [fp, #-4]
mov r9, r1
mov r1, r9
mov r7, r1
cmp r7, #1
bne .L68
mov r1, #4
str r8, [fp, #-28]
mov r8, r1
mov r1, r6
str r6, [fp, #-32]
ldr r6, [fp, #-12]
str r5, [fp, #-8]
mov r5, r1
mov r1, #1
str r4, [fp, #-36]
mov r4, r1
mov r1, r4
mov r2, r8
smull r4, r3, r1, r2
cmp r3, r4, asr #31
blne _errOverflow
mov r1, #1
str r10, [fp, #-40]
mov r10, r1
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
str r9, [fp, #-44]
mov r9, r1
str r9, [r5, r4]
str r10, [fp, #-48]
ldr r10, [fp, #-40]
str r4, [fp, #-52]
ldr r4, [fp, #-36]
str r5, [fp, #-56]
ldr r5, [fp, #-8]
str r6, [fp, #-12]
b 1f
.ltorg
1:
ldr r6, [fp, #-32]
str r8, [fp, #-60]
ldr r8, [fp, #-28]
ldr r9, [fp, #-44]
str r7, [fp, #-64]
b .L69
.L68:
mov r1, r7
ldr r7, [fp, #-24]
mov r9, r1
mov r1, r5
mov r8, r1
mov r0, r9
mov r1, r8
bl wacc_hasGivenStateValue
mov r6, r0
mov r1, r6
mov r9, r1
mov r1, r9
mov r5, r1
cmp r5, #1
bne .L66
mov r1, #4
mov r4, r1
mov r1, r10
ldr r10, [fp, #-12]
str r7, [fp, #-24]
mov r7, r1
mov r1, #1
str r9, [fp, #-68]
mov r9, r1
mov r1, r9
mov r2, r4
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r1, #2
str r8, [fp, #-72]
mov r8, r1
mov r1, r8
push {r1}
mov r3, r9
cmp r3, #0
mov r1, r3
bllt _errOutOfBounds
ldr lr, [r7, #-4]
mov r0, #4
muls lr, lr, r0
mov r3, r9
cmp r3, lr
mov r1, r3
blgt _errOutOfBounds
pop {r1}
str r6, [fp, #-76]
mov r6, r1
str r6, [r7, r9]
str r10, [fp, #-12]
ldr r10, [fp, #0]
str r4, [fp, #-80]
ldr r4, [fp, #0]
str r5, [fp, #-84]
ldr r5, [fp, #0]
ldr r6, [fp, #-76]
str r7, [fp, #-88]
ldr r7, [fp, #-24]
str r8, [fp, #-92]
ldr r8, [fp, #-72]
str r9, [fp, #-96]
ldr r9, [fp, #-68]
b .L67
.L66:
mov r1, r8
mov r9, r1
mov r1, r5
mov r8, r1
mov r0, r9
mov r1, r8
bl wacc_hasGivenStateValue
mov r7, r0
mov r1, r7
mov r9, r1
mov r1, r9
mov r6, r1
cmp r6, #1
bne .L64
mov r1, #4
mov r5, r1
mov r1, r4
ldr r4, [fp, #-12]
mov r10, r1
mov r1, #1
str r9, [fp, #-100]
mov r9, r1
mov r1, r9
mov r2, r5
smull r9, r3, r1, r2
cmp r3, r9, asr #31
blne _errOverflow
mov r1, #3
str r8, [fp, #-104]
mov r8, r1
mov r1, r8
b 1f
.ltorg
1:
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
str r7, [fp, #-108]
mov r7, r1
str r7, [r10, r9]
str r10, [fp, #-112]
ldr r10, [fp, #0]
str r4, [fp, #-12]
ldr r4, [fp, #0]
str r5, [fp, #-116]
ldr r5, [fp, #0]
str r6, [fp, #-120]
ldr r6, [fp, #0]
ldr r7, [fp, #-108]
str r8, [fp, #-124]
ldr r8, [fp, #-104]
str r9, [fp, #-128]
ldr r9, [fp, #-100]
b .L65
.L64:
mov r1, #0
mov r9, r1
mov r0, r9
b 0f
str r9, [fp, #-132]
ldr r9, [fp, #0]
.L65:
str r7, [fp, #-108]
ldr r7, [fp, #0]
str r8, [fp, #-104]
ldr r8, [fp, #0]
str r9, [fp, #-100]
ldr r9, [fp, #0]
.L67:
str r6, [fp, #-76]
ldr r6, [fp, #0]
str r8, [fp, #-72]
ldr r8, [fp, #0]
str r9, [fp, #-68]
ldr r9, [fp, #0]
str r7, [fp, #-24]
.L69:
mov r1, #1
mov r7, r1
mov r0, r7
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

wacc_hasGivenStateValue:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#24
subs sp, sp, r12
push {r10}
push {r4}
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
bne .L70
mov r1, #0
mov r8, r1
mov r0, r8
b 0f
str r7, [fp, #-4]
str r8, [fp, #-8]
str r9, [fp, #-12]
b .L71
.L70:
ldr r9, [r4, #4]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r7, r1
mov r1, r10
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r0, r7
b 0f
str r6, [fp, #-16]
str r7, [fp, #-20]
str r8, [fp, #-24]
.L71:
0:
ldr r12, =#24
adds sp, sp, r12
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

wacc_notifyMoveAI:
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #12]
ldr r6, [fp, #8]
ldr r5, [r7, #4]
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
str r10, [fp, #-8]
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-12]
mov r9, r1
str r7, [fp, #-16]
ldr r7, [r9, #4]
mov r1, r7
cmp r9, #0
bleq _errNull
str r8, [fp, #-20]
mov r8, r1
ldr r1, =.L.str35
str r6, [fp, #-24]
mov r6, r1
mov r0, r6
bl _prints
mov r1, r8
mov r5, r1
mov r1, r4
str r4, [fp, #-28]
ldr r4, [fp, #-20]
mov r10, r1
mov r1, r9
str r9, [fp, #-32]
ldr r9, [fp, #-24]
mov r7, r1
mov r0, r5
mov r1, r10
mov r2, r7
bl wacc_deleteAllOtherChildren
str r8, [fp, #-36]
mov r8, r0
mov r1, r8
str r6, [fp, #-40]
ldr r6, [fp, #-16]
cmp r6, #0
bleq _errNull
str r5, [fp, #-44]
mov r5, r1
str r5, [r6, #4]
mov r1, r4
str r4, [fp, #-20]
ldr r4, [fp, #-28]
str r10, [fp, #-48]
mov r10, r1
mov r0, r10
bl wacc_deleteThisStateOnly
str r9, [fp, #-24]
mov r9, r0
mov r1, r9
str r7, [fp, #-52]
mov r7, r1
mov r1, #1
str r8, [fp, #-56]
mov r8, r1
mov r0, r8
b 0f
0:
ldr r12, =#56
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

wacc_deleteAllOtherChildren:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#80
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
mov r9, r2
ldr r7, [r4, #0]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
ldr r6, [r8, #0]
mov r1, r6
cmp r8, #0
bleq _errNull
mov r5, r1
str r4, [fp, #-4]
ldr r4, [r8, #4]
mov r1, r4
cmp r8, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
ldr r7, [r9, #4]
mov r1, r7
str r9, [fp, #-12]
ldr r9, [fp, #-4]
cmp r9, #0
bleq _errNull
str r8, [fp, #-16]
mov r8, r1
mov r1, #0
mov r6, r1
mov r1, r6
str r5, [fp, #-20]
mov r5, r1
mov r1, #0
mov r4, r1
mov r1, r4
str r10, [fp, #-24]
mov r10, r1
mov r1, #0
str r9, [fp, #-4]
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, r8
str r8, [fp, #-28]
ldr r8, [fp, #-8]
str r6, [fp, #-32]
mov r6, r1
mov r1, #1
str r5, [fp, #-36]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L74
mov r1, r4
str r4, [fp, #-40]
ldr r4, [fp, #-20]
str r10, [fp, #-44]
ldr r10, [fp, #-36]
mov r10, r1
mov r1, r9
str r9, [fp, #-48]
ldr r9, [fp, #-24]
str r7, [fp, #-52]
ldr r7, [fp, #-44]
mov r7, r1
mov r1, r8
str r8, [fp, #-8]
ldr r8, [fp, #-28]
str r6, [fp, #-56]
ldr r6, [fp, #-52]
mov r6, r1
mov r1, r10
mov r10, r7
mov r7, r1
str r4, [fp, #-20]
ldr r4, [fp, #-40]
str r5, [fp, #-60]
mov r5, r7
str r6, [fp, #-52]
ldr r6, [fp, #-32]
str r7, [fp, #-36]
ldr r7, [fp, #-52]
str r9, [fp, #-24]
ldr r9, [fp, #-48]
b .L75
.L74:
b 1f
.ltorg
1:
mov r1, r9
ldr r9, [fp, #-20]
mov r10, r1
mov r1, r7
ldr r7, [fp, #-8]
mov r6, r1
mov r1, #2
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L72
mov r1, r4
ldr r4, [fp, #-24]
str r10, [fp, #-44]
ldr r10, [fp, #-36]
mov r10, r1
mov r1, r8
mov r7, r1
str r10, [fp, #-36]
ldr r10, [fp, #-44]
str r4, [fp, #-24]
ldr r4, [fp, #0]
str r5, [fp, #-64]
ldr r5, [fp, #-36]
str r6, [fp, #-68]
ldr r6, [fp, #0]
str r7, [fp, #-8]
ldr r7, [fp, #0]
b .L73
.L72:
mov r1, r8
mov r5, r1
mov r1, r7
ldr r7, [fp, #-24]
mov r7, r1
str r7, [fp, #-24]
ldr r7, [fp, #0]
.L73:
str r9, [fp, #-20]
ldr r9, [fp, #0]
.L75:
mov r1, r5
mov r9, r1
mov r1, r7
ldr r7, [fp, #-12]
mov r6, r1
mov r0, r9
mov r1, r6
bl wacc_deleteAllOtherChildrenRow
mov r5, r0
mov r1, r5
mov r4, r1
mov r1, r10
mov r10, r1
mov r0, r10
bl wacc_deleteChildrenStateRecursivelyRow
str r8, [fp, #-28]
mov r8, r0
mov r1, r8
str r9, [fp, #-72]
mov r9, r1
mov r1, r7
str r7, [fp, #-12]
mov r7, r1
mov r0, r7
bl wacc_deleteChildrenStateRecursivelyRow
str r6, [fp, #-76]
mov r6, r0
mov r1, r6
mov r9, r1
mov r1, r4
str r5, [fp, #-80]
mov r5, r1
mov r0, r5
b 0f
0:
ldr r12, =#80
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

wacc_deleteAllOtherChildrenRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#64
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
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r8, [r7, #0]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r6, r1
ldr r5, [r7, #4]
mov r1, r5
cmp r7, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
ldr r9, [r10, #4]
mov r1, r9
str r10, [fp, #-8]
ldr r10, [fp, #-4]
cmp r10, #0
bleq _errNull
str r7, [fp, #-12]
mov r7, r1
mov r1, #0
mov r8, r1
mov r1, r8
str r6, [fp, #-16]
mov r6, r1
mov r1, #0
mov r5, r1
mov r1, r5
str r4, [fp, #-20]
mov r4, r1
mov r1, #0
str r10, [fp, #-4]
mov r10, r1
mov r1, r10
mov r9, r1
mov r1, r7
str r7, [fp, #-24]
ldr r7, [fp, #-8]
str r8, [fp, #-28]
mov r8, r1
mov r1, #1
str r6, [fp, #-32]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
moveq r8, #1
movne r8, #0
cmp r8, #1
bne .L78
mov r1, r5
str r5, [fp, #-36]
ldr r5, [fp, #-16]
str r4, [fp, #-40]
ldr r4, [fp, #-32]
mov r4, r1
mov r1, r10
str r10, [fp, #-44]
ldr r10, [fp, #-20]
str r9, [fp, #-48]
ldr r9, [fp, #-40]
mov r9, r1
mov r1, r7
str r7, [fp, #-8]
ldr r7, [fp, #-24]
str r8, [fp, #-52]
ldr r8, [fp, #-48]
mov r8, r1
str r10, [fp, #-20]
ldr r10, [fp, #-44]
mov r1, r4
mov r4, r9
mov r9, r1
str r5, [fp, #-16]
ldr r5, [fp, #-36]
str r6, [fp, #-56]
mov r6, r9
str r8, [fp, #-48]
ldr r8, [fp, #-28]
str r9, [fp, #-32]
ldr r9, [fp, #-48]
b .L79
.L78:
mov r1, r9
ldr r9, [fp, #-16]
b 1f
.ltorg
1:
mov r4, r1
mov r1, r8
ldr r8, [fp, #-8]
mov r6, r1
mov r1, #2
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L76
mov r1, r10
ldr r10, [fp, #-20]
str r4, [fp, #-40]
ldr r4, [fp, #-32]
mov r4, r1
mov r1, r7
mov r9, r1
str r10, [fp, #-20]
ldr r10, [fp, #0]
str r4, [fp, #-32]
ldr r4, [fp, #-40]
str r5, [fp, #-60]
ldr r5, [fp, #0]
str r6, [fp, #-64]
ldr r6, [fp, #-32]
str r8, [fp, #-8]
ldr r8, [fp, #0]
b .L77
.L76:
mov r1, r7
mov r6, r1
mov r1, r8
ldr r8, [fp, #-20]
mov r9, r1
str r8, [fp, #-20]
ldr r8, [fp, #0]
.L77:
str r9, [fp, #-16]
ldr r9, [fp, #0]
.L79:
mov r1, r4
mov r9, r1
mov r0, r9
bl wacc_deleteStateTreeRecursively
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r9
mov r5, r1
mov r0, r5
bl wacc_deleteStateTreeRecursively
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r6
mov r10, r1
mov r0, r10
b 0f
0:
ldr r12, =#64
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

wacc_deleteStateTreeRecursively:
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
mov r1, #0
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L80
mov r1, #1
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-4]
str r7, [fp, #-8]
str r9, [fp, #-12]
b .L81
.L80:
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r10, [r7, #0]
mov r1, r10
cmp r7, #0
bleq _errNull
mov r8, r1
ldr r6, [r7, #4]
mov r1, r6
cmp r7, #0
bleq _errNull
mov r5, r1
mov r1, r5
str r4, [fp, #-16]
mov r4, r1
mov r0, r4
bl wacc_deleteChildrenStateRecursively
mov r9, r0
mov r1, r9
str r7, [fp, #-20]
mov r7, r1
mov r1, r10
ldr r10, [fp, #-16]
str r8, [fp, #-24]
mov r8, r1
mov r0, r8
bl wacc_deleteThisStateOnly
mov r6, r0
mov r1, r6
mov r7, r1
mov r1, #1
str r5, [fp, #-28]
mov r5, r1
mov r0, r5
b 0f
str r4, [fp, #-32]
mov r4, r10
str r10, [fp, #-16]
str r5, [fp, #-36]
str r6, [fp, #-40]
str r7, [fp, #-44]
str r8, [fp, #-48]
str r9, [fp, #-52]
.L81:
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

wacc_deleteThisStateOnly:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
mov r1, r8
str r4, [fp, #-4]
mov r4, r1
mov r0, r4
bl wacc_freeBoard
mov r10, r0
mov r1, r10
str r9, [fp, #-8]
mov r9, r1
mov r1, r5
mov r7, r1
mov r0, r7
bl wacc_freePointers
str r8, [fp, #-12]
mov r8, r0
mov r1, r8
mov r9, r1
mov r1, r6
ldr r6, [fp, #-8]
str r5, [fp, #-16]
mov r5, r1
mov r0, r5
bl _freepair
mov r1, r4
str r4, [fp, #-20]
ldr r4, [fp, #-4]
str r10, [fp, #-24]
mov r10, r1
mov r0, r10
bl _freepair
mov r1, #1
str r9, [fp, #-28]
mov r9, r1
mov r0, r9
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

wacc_freePointers:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#40
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_freePointersRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_freePointersRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_freePointersRow
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, r7
str r7, [fp, #-24]
ldr r7, [fp, #-4]
str r8, [fp, #-28]
mov r8, r1
mov r0, r8
bl _freepair
mov r1, r6
str r6, [fp, #-32]
ldr r6, [fp, #-16]
str r5, [fp, #-36]
mov r5, r1
mov r0, r5
bl _freepair
mov r1, #1
str r4, [fp, #-40]
mov r4, r1
mov r0, r4
b 0f
0:
ldr r12, =#40
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

wacc_freePointersRow:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
mov r1, r9
mov r7, r1
mov r0, r7
bl _freepair
mov r1, r4
mov r8, r1
mov r0, r8
bl _freepair
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

wacc_deleteChildrenStateRecursively:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_deleteChildrenStateRecursivelyRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_deleteChildrenStateRecursivelyRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_deleteChildrenStateRecursivelyRow
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, #1
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
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

wacc_deleteChildrenStateRecursivelyRow:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_deleteStateTreeRecursively
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_deleteStateTreeRecursively
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_deleteStateTreeRecursively
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, #1
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
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

wacc_askForAMove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#72
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #8]
mov r1, r10
mov r6, r1
mov r1, r9
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L82
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #8]
str r9, [fp, #-12]
mov r9, r1
mov r0, r4
mov r1, r9
bl wacc_askForAMoveHuman
str r7, [fp, #-16]
mov r7, r0
mov r1, r7
str r8, [fp, #-20]
mov r8, r1
str r10, [fp, #-20]
ldr r10, [fp, #-8]
str r4, [fp, #-24]
ldr r4, [fp, #-4]
str r7, [fp, #-28]
ldr r7, [fp, #-16]
str r8, [fp, #-32]
ldr r8, [fp, #-20]
str r9, [fp, #-36]
ldr r9, [fp, #-12]
str r5, [fp, #-40]
str r6, [fp, #-44]
b .L83
.L82:
mov r1, r4
mov r6, r1
mov r1, r10
mov r5, r1
mov r1, r9
mov r9, r1
mov r1, r7
mov r8, r1
mov r1, r8
mov r7, r1
mov r0, r6
mov r1, r5
mov r2, r9
mov r3, r8
push {r7}
bl wacc_askForAMoveAI
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-48]
ldr r10, [fp, #0]
str r4, [fp, #-52]
ldr r4, [fp, #0]
str r7, [fp, #-56]
ldr r7, [fp, #0]
str r8, [fp, #-60]
ldr r8, [fp, #0]
str r9, [fp, #-64]
ldr r9, [fp, #0]
str r5, [fp, #-68]
str r6, [fp, #-72]
.L83:
mov r1, #1
mov r6, r1
mov r0, r6
b 0f
0:
ldr r12, =#72
adds sp, sp, r12
pop {r9}
pop {r8}
pop {r7}
pop {r6}
pop {r5}
pop {r4}
b 1f
.ltorg
1:
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_placeMove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#64
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
mov r9, r2
mov r7, r3
mov r1, #0
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, r9
mov r5, r1
mov r1, #2
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
movle r5, #1
movgt r5, #0
cmp r5, #1
bne .L86
str r9, [fp, #-12]
ldr r9, [r10, #0]
mov r1, r9
str r10, [fp, #-8]
ldr r10, [fp, #-4]
cmp r10, #0
bleq _errNull
str r7, [fp, #-16]
mov r7, r1
mov r1, r8
str r8, [fp, #-20]
ldr r8, [fp, #-12]
str r6, [fp, #-24]
mov r6, r1
mov r1, #1
str r5, [fp, #-28]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L84
str r4, [fp, #-32]
ldr r4, [r7, #0]
mov r1, r4
cmp r7, #0
bleq _errNull
str r10, [fp, #-4]
ldr r10, [fp, #-24]
mov r10, r1
str r10, [fp, #-24]
ldr r10, [fp, #-4]
ldr r4, [fp, #-32]
str r5, [fp, #-36]
ldr r5, [fp, #-28]
str r6, [fp, #-40]
ldr r6, [fp, #-24]
str r8, [fp, #-12]
ldr r8, [fp, #-20]
b .L85
.L84:
ldr r8, [r7, #4]
mov r1, r8
cmp r7, #0
bleq _errNull
mov r6, r1
.L85:
str r10, [fp, #-4]
ldr r10, [fp, #-8]
str r4, [fp, #-32]
ldr r4, [fp, #-4]
str r7, [fp, #-44]
ldr r7, [fp, #-16]
ldr r9, [fp, #-12]
str r5, [fp, #-28]
b .L87
.L86:
ldr r5, [r4, #4]
mov r1, r5
cmp r4, #0
bleq _errNull
mov r6, r1
.L87:
mov r1, r7
mov r9, r1
mov r1, #2
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
movle r9, #1
movgt r9, #0
cmp r9, #1
b 1f
.ltorg
1:
bne .L90
ldr r4, [r6, #0]
mov r1, r4
cmp r6, #0
bleq _errNull
mov r10, r1
mov r1, r7
mov r6, r1
mov r1, #1
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
cmp r6, #1
bne .L88
mov r1, r10
cmp r10, #0
bleq _errNull
mov r4, r1
str r4, [r10, #0]
str r6, [fp, #-48]
ldr r6, [fp, #0]
str r5, [fp, #-52]
b .L89
.L88:
mov r1, r10
cmp r10, #0
bleq _errNull
mov r5, r1
str r5, [r10, #4]
.L89:
str r10, [fp, #-56]
ldr r10, [fp, #0]
str r7, [fp, #-60]
ldr r7, [fp, #0]
str r9, [fp, #-64]
ldr r9, [fp, #0]
b .L91
.L90:
mov r1, r10
cmp r6, #0
bleq _errNull
mov r9, r1
str r9, [r6, #4]
.L91:
mov r1, #1
mov r7, r1
mov r0, r7
b 0f
0:
ldr r12, =#64
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

wacc_notifyMove:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#92
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
mov r9, r2
mov r7, r3
ldr r8, [fp, #12]
ldr r6, [fp, #8]
mov r1, r10
mov r5, r1
mov r1, r9
str r4, [fp, #-4]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
cmp r5, #1
bne .L92
mov r1, r10
str r10, [fp, #-8]
ldr r10, [fp, #-4]
str r9, [fp, #-12]
mov r9, r1
mov r1, r7
str r7, [fp, #-16]
ldr r7, [fp, #-8]
str r8, [fp, #-20]
mov r8, r1
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-12]
str r5, [fp, #-28]
mov r5, r1
mov r1, r4
str r4, [fp, #-32]
ldr r4, [fp, #-16]
str r10, [fp, #-4]
mov r10, r1
mov r1, r9
str r9, [fp, #-36]
ldr r9, [fp, #-20]
str r7, [fp, #-8]
mov r7, r1
mov r1, r8
str r8, [fp, #-40]
ldr r8, [fp, #-24]
str r6, [fp, #-12]
mov r6, r1
str r5, [fp, #-44]
ldr r5, [fp, #-36]
mov r0, r5
str r4, [fp, #-16]
ldr r4, [fp, #-40]
mov r1, r4
str r10, [fp, #-48]
ldr r10, [fp, #-44]
mov r2, r10
str r9, [fp, #-20]
ldr r9, [fp, #-48]
mov r3, r9
push {r7}
push {r6}
bl wacc_notifyMoveAI
str r7, [fp, #-52]
mov r7, r0
mov r1, r7
str r8, [fp, #-24]
mov r8, r1
str r10, [fp, #-44]
ldr r10, [fp, #-8]
str r4, [fp, #-40]
ldr r4, [fp, #-4]
str r6, [fp, #-56]
ldr r6, [fp, #-24]
str r7, [fp, #-60]
ldr r7, [fp, #-16]
str r8, [fp, #-64]
ldr r8, [fp, #-20]
str r9, [fp, #-48]
ldr r9, [fp, #-12]
str r5, [fp, #-36]
b .L93
.L92:
mov r1, r4
mov r5, r1
mov r1, r10
mov r9, r1
mov r1, r9
mov r8, r1
mov r1, r8
mov r7, r1
b 1f
.ltorg
1:
mov r1, r6
mov r6, r1
mov r0, r5
mov r1, r9
mov r2, r8
mov r3, r7
push {r6}
bl wacc_notifyMoveHuman
mov r4, r0
mov r1, r4
mov r10, r1
str r10, [fp, #-68]
ldr r10, [fp, #0]
str r4, [fp, #-72]
ldr r4, [fp, #0]
str r6, [fp, #-76]
ldr r6, [fp, #0]
str r7, [fp, #-80]
ldr r7, [fp, #0]
str r8, [fp, #-84]
ldr r8, [fp, #0]
str r9, [fp, #-88]
ldr r9, [fp, #0]
str r5, [fp, #-92]
.L93:
mov r1, #1
mov r5, r1
mov r0, r5
b 0f
0:
ldr r12, =#92
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

wacc_oppositeSymbol:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#32
subs sp, sp, r12
push {r10}
push {r4}
push {r7}
push {r9}
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, #120
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L96
mov r1, #111
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-4]
str r7, [fp, #-8]
str r9, [fp, #-12]
b .L97
.L96:
mov r1, r4
mov r9, r1
mov r1, #111
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
cmp r9, #1
bne .L94
mov r1, #120
mov r10, r1
mov r0, r10
b 0f
str r10, [fp, #-16]
str r7, [fp, #-20]
str r9, [fp, #-24]
b .L95
.L94:
ldr r1, =.L.str36
mov r9, r1
mov r0, r9
bl _prints
mov r1, #-1
mov r7, r1
mov r0, r7
bl exit
str r7, [fp, #-28]
str r9, [fp, #-32]
.L95:
.L97:
0:
ldr r12, =#32
adds sp, sp, r12
pop {r9}
pop {r7}
pop {r4}
pop {r10}
mov sp, fp
pop {fp}
pop {pc}
.ltorg

wacc_symbolAt:
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
mov r10, r1
mov r9, r2
mov r1, #0
mov r7, r1
mov r1, r7
mov r8, r1
mov r1, r10
mov r6, r1
mov r1, #2
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
movle r6, #1
movgt r6, #0
cmp r6, #1
bne .L100
str r10, [fp, #-4]
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-8]
mov r9, r1
mov r1, r7
str r7, [fp, #-12]
ldr r7, [fp, #-4]
str r8, [fp, #-16]
mov r8, r1
mov r1, #1
str r6, [fp, #-20]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
moveq r8, #1
movne r8, #0
cmp r8, #1
bne .L98
str r5, [fp, #-24]
ldr r5, [r9, #0]
mov r1, r5
cmp r9, #0
bleq _errNull
str r4, [fp, #-28]
ldr r4, [fp, #-16]
mov r4, r1
str r4, [fp, #-16]
ldr r4, [fp, #-28]
ldr r5, [fp, #-24]
str r6, [fp, #-32]
ldr r6, [fp, #-20]
str r7, [fp, #-4]
ldr r7, [fp, #-12]
str r8, [fp, #-36]
ldr r8, [fp, #-16]
b .L99
.L98:
ldr r8, [r9, #4]
mov r1, r8
cmp r9, #0
bleq _errNull
mov r8, r1
.L99:
ldr r10, [fp, #-4]
str r9, [fp, #-40]
ldr r9, [fp, #-8]
str r5, [fp, #-24]
str r6, [fp, #-20]
b .L101
.L100:
ldr r6, [r4, #4]
mov r1, r6
cmp r4, #0
bleq _errNull
mov r8, r1
.L101:
mov r1, #0
mov r5, r1
mov r1, r5
mov r9, r1
mov r1, r9
mov r10, r1
mov r1, #2
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
movle r10, #1
movgt r10, #0
cmp r10, #1
bne .L104
ldr r6, [r8, #0]
mov r1, r6
b 1f
.ltorg
1:
cmp r8, #0
bleq _errNull
mov r5, r1
mov r1, r9
mov r4, r1
mov r1, #1
str r8, [fp, #-16]
mov r8, r1
mov r1, r4
mov r2, r8
cmp r1, r2
moveq r4, #1
movne r4, #0
cmp r4, #1
bne .L102
ldr r6, [r5, #0]
mov r1, r6
cmp r5, #0
bleq _errNull
mov r9, r1
str r4, [fp, #-44]
ldr r4, [fp, #0]
str r8, [fp, #-48]
ldr r8, [fp, #-16]
b .L103
.L102:
ldr r8, [r5, #4]
mov r1, r8
cmp r5, #0
bleq _errNull
mov r9, r1
.L103:
str r10, [fp, #-52]
ldr r10, [fp, #0]
str r5, [fp, #-56]
ldr r5, [fp, #0]
str r7, [fp, #-60]
ldr r7, [fp, #0]
b .L105
.L104:
ldr r7, [r8, #4]
mov r1, r7
cmp r8, #0
bleq _errNull
mov r9, r1
.L105:
mov r1, r9
mov r5, r1
mov r0, r5
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

wacc_containEmptyCell:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#40
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_containEmptyCellRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_containEmptyCellRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r10, r1
mov r1, r9
str r9, [fp, #-20]
mov r9, r1
mov r0, r9
bl wacc_containEmptyCellRow
str r7, [fp, #-24]
mov r7, r0
mov r1, r7
str r8, [fp, #-28]
mov r8, r1
mov r1, r6
str r6, [fp, #-32]
mov r6, r1
mov r1, r10
str r5, [fp, #-36]
mov r5, r1
mov r1, r6
mov r2, r5
orr r6, r1, r2
mov r1, r8
str r4, [fp, #-40]
mov r4, r1
mov r1, r6
mov r2, r4
orr r6, r1, r2
mov r0, r6
b 0f
0:
ldr r12, =#40
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

wacc_containEmptyCellRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#16
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r1, #0
str r8, [fp, #-8]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r5
mov r6, r1
mov r1, #0
str r5, [fp, #-12]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r7
mov r2, r6
orr r7, r1, r2
mov r1, r9
str r4, [fp, #-16]
mov r4, r1
mov r1, #0
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r7
mov r2, r4
orr r7, r1, r2
mov r0, r7
b 0f
0:
ldr r12, =#16
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

wacc_hasWon:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#364
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
mov r1, #1
mov r7, r1
mov r1, #1
mov r8, r1
mov r0, r9
mov r1, r7
mov r2, r8
bl wacc_symbolAt
mov r6, r0
mov r1, r6
mov r5, r1
mov r1, r4
str r4, [fp, #-4]
mov r4, r1
mov r1, #1
str r10, [fp, #-8]
mov r10, r1
mov r1, #2
str r9, [fp, #-12]
mov r9, r1
mov r0, r4
mov r1, r10
mov r2, r9
bl wacc_symbolAt
str r7, [fp, #-16]
mov r7, r0
mov r1, r7
str r8, [fp, #-20]
mov r8, r1
mov r1, r6
str r6, [fp, #-24]
ldr r6, [fp, #-4]
str r5, [fp, #-28]
mov r5, r1
mov r1, #1
str r4, [fp, #-32]
mov r4, r1
mov r1, #3
str r10, [fp, #-36]
mov r10, r1
mov r0, r5
mov r1, r4
mov r2, r10
bl wacc_symbolAt
str r9, [fp, #-40]
mov r9, r0
mov r1, r9
str r7, [fp, #-44]
mov r7, r1
mov r1, r6
str r8, [fp, #-48]
mov r8, r1
mov r1, #2
str r6, [fp, #-4]
mov r6, r1
mov r1, #1
str r5, [fp, #-52]
mov r5, r1
mov r0, r8
mov r1, r6
mov r2, r5
bl wacc_symbolAt
str r4, [fp, #-56]
mov r4, r0
mov r1, r4
str r10, [fp, #-60]
mov r10, r1
mov r1, r9
str r9, [fp, #-64]
ldr r9, [fp, #-4]
str r7, [fp, #-68]
mov r7, r1
mov r1, #2
str r8, [fp, #-72]
mov r8, r1
mov r1, #2
str r6, [fp, #-76]
mov r6, r1
mov r0, r7
mov r1, r8
mov r2, r6
bl wacc_symbolAt
str r5, [fp, #-80]
mov r5, r0
mov r1, r5
b 1f
.ltorg
1:
str r4, [fp, #-84]
mov r4, r1
mov r1, r9
str r10, [fp, #-88]
mov r10, r1
mov r1, #2
str r9, [fp, #-4]
mov r9, r1
mov r1, #3
str r7, [fp, #-92]
mov r7, r1
mov r0, r10
mov r1, r9
mov r2, r7
bl wacc_symbolAt
str r8, [fp, #-96]
mov r8, r0
mov r1, r8
str r6, [fp, #-100]
mov r6, r1
mov r1, r5
str r5, [fp, #-104]
ldr r5, [fp, #-4]
str r4, [fp, #-108]
mov r4, r1
mov r1, #3
str r10, [fp, #-112]
mov r10, r1
mov r1, #1
str r9, [fp, #-116]
mov r9, r1
mov r0, r4
mov r1, r10
mov r2, r9
bl wacc_symbolAt
str r7, [fp, #-120]
mov r7, r0
mov r1, r7
str r8, [fp, #-124]
mov r8, r1
mov r1, r5
str r6, [fp, #-128]
mov r6, r1
mov r1, #3
str r5, [fp, #-4]
mov r5, r1
mov r1, #2
str r4, [fp, #-132]
mov r4, r1
mov r0, r6
mov r1, r5
mov r2, r4
bl wacc_symbolAt
str r10, [fp, #-136]
mov r10, r0
mov r1, r10
str r9, [fp, #-140]
mov r9, r1
mov r1, r7
str r7, [fp, #-144]
ldr r7, [fp, #-4]
str r8, [fp, #-148]
mov r8, r1
mov r1, #3
str r6, [fp, #-152]
mov r6, r1
mov r1, #3
str r5, [fp, #-156]
mov r5, r1
mov r0, r8
mov r1, r6
mov r2, r5
bl wacc_symbolAt
str r4, [fp, #-160]
mov r4, r0
mov r1, r4
str r10, [fp, #-164]
mov r10, r1
mov r1, r9
str r9, [fp, #-168]
ldr r9, [fp, #-28]
str r7, [fp, #-4]
mov r7, r1
mov r1, r8
str r8, [fp, #-172]
ldr r8, [fp, #-8]
str r6, [fp, #-176]
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r5
str r5, [fp, #-180]
ldr r5, [fp, #-48]
str r4, [fp, #-184]
mov r4, r1
mov r1, r8
str r10, [fp, #-188]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
b 1f
.ltorg
1:
mov r1, r7
mov r2, r4
and r7, r1, r2
mov r1, r9
str r9, [fp, #-28]
ldr r9, [fp, #-68]
str r7, [fp, #-192]
mov r7, r1
mov r1, r8
str r8, [fp, #-8]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r6
str r6, [fp, #-196]
ldr r6, [fp, #-192]
mov r2, r7
and r6, r1, r2
mov r1, r5
str r5, [fp, #-48]
ldr r5, [fp, #-88]
str r4, [fp, #-200]
mov r4, r1
mov r1, r10
str r10, [fp, #-204]
ldr r10, [fp, #-8]
str r9, [fp, #-68]
mov r9, r1
mov r1, r4
mov r2, r9
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r7
str r7, [fp, #-208]
ldr r7, [fp, #-108]
str r8, [fp, #-212]
mov r8, r1
mov r1, r10
str r6, [fp, #-192]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r1, r4
mov r2, r8
and r4, r1, r2
mov r1, r5
str r5, [fp, #-88]
ldr r5, [fp, #-128]
str r4, [fp, #-216]
mov r4, r1
mov r1, r10
str r10, [fp, #-8]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r9
str r9, [fp, #-220]
ldr r9, [fp, #-216]
mov r2, r4
and r9, r1, r2
mov r1, r7
str r7, [fp, #-108]
ldr r7, [fp, #-192]
mov r2, r9
orr r7, r1, r2
mov r1, r8
str r8, [fp, #-224]
ldr r8, [fp, #-148]
str r6, [fp, #-228]
mov r6, r1
mov r1, r5
str r5, [fp, #-128]
ldr r5, [fp, #-8]
str r4, [fp, #-232]
mov r4, r1
mov r1, r6
mov r2, r4
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r10
str r10, [fp, #-236]
ldr r10, [fp, #-168]
str r9, [fp, #-216]
mov r9, r1
mov r1, r5
str r7, [fp, #-192]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
mov r1, r6
mov r2, r9
and r6, r1, r2
mov r1, r8
str r8, [fp, #-148]
ldr r8, [fp, #-188]
str r6, [fp, #-240]
mov r6, r1
mov r1, r5
str r5, [fp, #-8]
mov r5, r1
b 1f
.ltorg
1:
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r4
str r4, [fp, #-244]
ldr r4, [fp, #-240]
mov r2, r6
and r4, r1, r2
mov r1, r10
str r10, [fp, #-168]
ldr r10, [fp, #-192]
mov r2, r4
orr r10, r1, r2
mov r1, r9
str r9, [fp, #-248]
ldr r9, [fp, #-28]
str r7, [fp, #-252]
mov r7, r1
mov r1, r8
str r8, [fp, #-188]
ldr r8, [fp, #-8]
str r6, [fp, #-256]
mov r6, r1
mov r1, r7
mov r2, r6
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r5
str r5, [fp, #-260]
ldr r5, [fp, #-88]
str r4, [fp, #-240]
mov r4, r1
mov r1, r8
str r10, [fp, #-192]
mov r10, r1
mov r1, r4
mov r2, r10
cmp r1, r2
moveq r4, #1
movne r4, #0
mov r1, r7
mov r2, r4
and r7, r1, r2
mov r1, r9
str r9, [fp, #-28]
ldr r9, [fp, #-148]
str r7, [fp, #-264]
mov r7, r1
mov r1, r8
str r8, [fp, #-8]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r6
str r6, [fp, #-268]
ldr r6, [fp, #-264]
mov r2, r7
and r6, r1, r2
mov r1, r5
str r5, [fp, #-88]
ldr r5, [fp, #-192]
mov r2, r6
orr r5, r1, r2
mov r1, r4
str r4, [fp, #-272]
ldr r4, [fp, #-48]
str r10, [fp, #-276]
mov r10, r1
mov r1, r9
str r9, [fp, #-148]
ldr r9, [fp, #-8]
str r7, [fp, #-280]
mov r7, r1
mov r1, r10
mov r2, r7
cmp r1, r2
moveq r10, #1
movne r10, #0
mov r1, r8
str r8, [fp, #-284]
ldr r8, [fp, #-108]
str r6, [fp, #-264]
mov r6, r1
mov r1, r9
str r5, [fp, #-192]
mov r5, r1
mov r1, r6
mov r2, r5
cmp r1, r2
moveq r6, #1
movne r6, #0
mov r1, r10
mov r2, r6
and r10, r1, r2
mov r1, r4
str r4, [fp, #-48]
ldr r4, [fp, #-168]
str r10, [fp, #-288]
mov r10, r1
mov r1, r9
str r9, [fp, #-8]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
mov r1, r7
str r7, [fp, #-292]
ldr r7, [fp, #-288]
b 1f
.ltorg
1:
mov r2, r10
and r7, r1, r2
mov r1, r8
str r8, [fp, #-108]
ldr r8, [fp, #-192]
mov r2, r7
orr r8, r1, r2
mov r1, r6
str r6, [fp, #-296]
ldr r6, [fp, #-68]
str r5, [fp, #-300]
mov r5, r1
mov r1, r4
str r4, [fp, #-168]
ldr r4, [fp, #-8]
str r10, [fp, #-304]
mov r10, r1
mov r1, r5
mov r2, r10
cmp r1, r2
moveq r5, #1
movne r5, #0
mov r1, r9
str r9, [fp, #-308]
ldr r9, [fp, #-128]
str r7, [fp, #-288]
mov r7, r1
mov r1, r4
str r8, [fp, #-192]
mov r8, r1
mov r1, r7
mov r2, r8
cmp r1, r2
moveq r7, #1
movne r7, #0
mov r1, r5
mov r2, r7
and r5, r1, r2
mov r1, r6
str r6, [fp, #-68]
ldr r6, [fp, #-188]
str r5, [fp, #-312]
mov r5, r1
mov r1, r4
str r4, [fp, #-8]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
mov r1, r10
str r10, [fp, #-316]
ldr r10, [fp, #-312]
mov r2, r5
and r10, r1, r2
mov r1, r9
str r9, [fp, #-128]
ldr r9, [fp, #-192]
mov r2, r10
orr r9, r1, r2
mov r1, r7
str r7, [fp, #-320]
ldr r7, [fp, #-28]
str r8, [fp, #-324]
mov r8, r1
mov r1, r6
str r6, [fp, #-188]
ldr r6, [fp, #-8]
str r5, [fp, #-328]
mov r5, r1
mov r1, r8
mov r2, r5
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r1, r4
str r4, [fp, #-332]
ldr r4, [fp, #-108]
str r10, [fp, #-312]
mov r10, r1
mov r1, r6
str r9, [fp, #-192]
mov r9, r1
mov r1, r10
mov r2, r9
cmp r1, r2
moveq r10, #1
movne r10, #0
mov r1, r8
mov r2, r10
and r8, r1, r2
mov r1, r7
str r7, [fp, #-28]
ldr r7, [fp, #-188]
str r8, [fp, #-336]
mov r8, r1
mov r1, r6
str r6, [fp, #-8]
mov r6, r1
mov r1, r8
mov r2, r6
cmp r1, r2
moveq r8, #1
movne r8, #0
mov r1, r5
str r5, [fp, #-340]
ldr r5, [fp, #-336]
mov r2, r8
and r5, r1, r2
mov r1, r4
str r4, [fp, #-108]
ldr r4, [fp, #-192]
mov r2, r5
b 1f
.ltorg
1:
orr r4, r1, r2
mov r1, r10
str r10, [fp, #-344]
ldr r10, [fp, #-68]
str r9, [fp, #-348]
mov r9, r1
mov r1, r7
str r7, [fp, #-188]
ldr r7, [fp, #-8]
str r8, [fp, #-352]
mov r8, r1
mov r1, r9
mov r2, r8
cmp r1, r2
moveq r9, #1
movne r9, #0
mov r1, r6
str r6, [fp, #-356]
ldr r6, [fp, #-108]
str r5, [fp, #-336]
mov r5, r1
mov r1, r7
str r4, [fp, #-192]
mov r4, r1
mov r1, r5
mov r2, r4
cmp r1, r2
moveq r5, #1
movne r5, #0
mov r1, r9
mov r2, r5
and r9, r1, r2
mov r1, r10
str r10, [fp, #-68]
ldr r10, [fp, #-148]
str r9, [fp, #-360]
mov r9, r1
mov r1, r7
str r7, [fp, #-8]
mov r7, r1
mov r1, r9
mov r2, r7
cmp r1, r2
moveq r9, #1
movne r9, #0
mov r1, r8
str r8, [fp, #-364]
ldr r8, [fp, #-360]
mov r2, r9
and r8, r1, r2
mov r1, r6
str r6, [fp, #-108]
ldr r6, [fp, #-192]
mov r2, r8
orr r6, r1, r2
mov r0, r6
b 0f
0:
ldr r12, =#364
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

wacc_allocateNewBoard:
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
bl wacc_allocateNewRow
mov r4, r0
mov r1, r4
mov r10, r1
bl wacc_allocateNewRow
mov r9, r0
mov r1, r9
mov r7, r1
bl wacc_allocateNewRow
mov r8, r0
mov r1, r8
mov r6, r1
mov r0, #8
bl malloc
mov r5, r0
mov r1, r10
cmp r5, #0
bleq _errNull
str r4, [fp, #-4]
mov r4, r1
str r4, [r5, #0]
mov r1, r7
cmp r5, #0
bleq _errNull
str r10, [fp, #-8]
mov r10, r1
str r10, [r5, #4]
mov r1, r5
str r9, [fp, #-12]
mov r9, r1
str r7, [fp, #-16]
mov r0, #8
bl malloc
mov r7, r0
mov r1, r9
cmp r7, #0
bleq _errNull
str r8, [fp, #-20]
mov r8, r1
str r8, [r7, #0]
mov r1, r6
cmp r7, #0
bleq _errNull
str r6, [fp, #-24]
mov r6, r1
str r6, [r7, #4]
mov r1, r7
str r5, [fp, #-28]
mov r5, r1
mov r1, r5
mov r4, r1
mov r0, r4
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

wacc_allocateNewRow:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r0, #8
bl malloc
mov r4, r0
mov r1, #0
cmp r4, #0
bleq _errNull
mov r10, r1
str r10, [r4, #0]
mov r1, #0
cmp r4, #0
bleq _errNull
mov r9, r1
str r9, [r4, #4]
mov r1, r4
mov r7, r1
mov r0, #8
bl malloc
mov r8, r0
mov r1, r7
cmp r8, #0
bleq _errNull
mov r6, r1
str r6, [r8, #0]
mov r1, #0
cmp r8, #0
bleq _errNull
mov r5, r1
str r5, [r8, #4]
mov r1, r8
str r4, [fp, #-4]
mov r4, r1
mov r1, r4
mov r10, r1
mov r0, r10
b 0f
0:
ldr r12, =#4
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

wacc_freeBoard:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#40
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_freeRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_freeRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_freeRow
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, r7
str r7, [fp, #-24]
ldr r7, [fp, #-4]
str r8, [fp, #-28]
mov r8, r1
mov r0, r8
bl _freepair
mov r1, r6
str r6, [fp, #-32]
ldr r6, [fp, #-16]
str r5, [fp, #-36]
mov r5, r1
mov r0, r5
bl _freepair
mov r1, #1
str r4, [fp, #-40]
mov r4, r1
mov r0, r4
b 0f
0:
ldr r12, =#40
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

wacc_freeRow:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
mov r1, r9
mov r7, r1
mov r0, r7
bl _freepair
mov r1, r4
mov r8, r1
mov r0, r8
bl _freepair
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

wacc_printAiData:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#4
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r4, r0
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r4, #4]
mov r1, r7
cmp r4, #0
bleq _errNull
mov r8, r1
mov r1, r8
mov r6, r1
mov r0, r6
bl wacc_printStateTreeRecursively
mov r5, r0
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, #0
mov r10, r1
mov r0, r10
bl exit
0:
ldr r12, =#4
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

wacc_printStateTreeRecursively:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#72
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
moveq r10, #1
movne r10, #0
cmp r10, #1
bne .L106
mov r1, #1
mov r7, r1
mov r0, r7
b 0f
str r10, [fp, #-4]
str r7, [fp, #-8]
str r9, [fp, #-12]
b .L107
.L106:
ldr r9, [r4, #0]
mov r1, r9
cmp r4, #0
bleq _errNull
mov r7, r1
ldr r10, [r7, #0]
mov r1, r10
cmp r7, #0
bleq _errNull
mov r8, r1
ldr r6, [r7, #4]
mov r1, r6
cmp r7, #0
bleq _errNull
mov r5, r1
ldr r9, [r4, #4]
mov r1, r9
cmp r4, #0
bleq _errNull
str r7, [fp, #-16]
mov r7, r1
mov r1, #118
mov r10, r1
mov r0, r10
bl _printc
mov r1, #61
str r8, [fp, #-20]
mov r8, r1
mov r0, r8
bl _printc
mov r1, r7
mov r6, r1
mov r0, r6
bl _printi
mov r1, r5
str r5, [fp, #-24]
ldr r5, [fp, #-20]
str r4, [fp, #-28]
mov r4, r1
mov r0, r4
bl wacc_printBoard
mov r9, r0
mov r1, r9
str r7, [fp, #-32]
mov r7, r1
mov r1, r10
str r10, [fp, #-36]
ldr r10, [fp, #-24]
str r8, [fp, #-40]
mov r8, r1
mov r0, r8
bl wacc_printChildrenStateTree
str r6, [fp, #-44]
mov r6, r0
mov r1, r6
mov r7, r1
mov r1, #112
str r5, [fp, #-20]
mov r5, r1
mov r0, r5
bl _printc
mov r1, #1
str r4, [fp, #-48]
mov r4, r1
mov r0, r4
b 0f
str r4, [fp, #-52]
ldr r4, [fp, #-28]
str r10, [fp, #-24]
str r5, [fp, #-56]
b 1f
.ltorg
1:
str r6, [fp, #-60]
str r7, [fp, #-64]
str r8, [fp, #-68]
str r9, [fp, #-72]
.L107:
0:
ldr r12, =#72
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

wacc_printChildrenStateTree:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_printChildrenStateTreeRow
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_printChildrenStateTreeRow
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_printChildrenStateTreeRow
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, #1
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
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

wacc_printChildrenStateTreeRow:
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
ldr r10, [r4, #0]
mov r1, r10
cmp r4, #0
bleq _errNull
mov r9, r1
ldr r7, [r9, #0]
mov r1, r7
cmp r9, #0
bleq _errNull
mov r8, r1
ldr r6, [r9, #4]
mov r1, r6
cmp r9, #0
bleq _errNull
mov r5, r1
ldr r10, [r4, #4]
mov r1, r10
cmp r4, #0
bleq _errNull
str r9, [fp, #-4]
mov r9, r1
mov r1, r8
mov r7, r1
mov r0, r7
bl wacc_printStateTreeRecursively
str r8, [fp, #-8]
mov r8, r0
mov r1, r8
mov r6, r1
mov r1, r5
str r5, [fp, #-12]
mov r5, r1
mov r0, r5
bl wacc_printStateTreeRecursively
str r4, [fp, #-16]
mov r4, r0
mov r1, r4
mov r6, r1
mov r1, r9
mov r10, r1
mov r0, r10
bl wacc_printStateTreeRecursively
str r9, [fp, #-20]
mov r9, r0
mov r1, r9
mov r6, r1
mov r1, #1
str r7, [fp, #-24]
mov r7, r1
mov r0, r7
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
    
