.data
.text
.global main
main:
push {lr}
push {fp}
mov fp, sp
ldr r12, =#2028
subs sp, sp, r12
push {r10}
push {r4}
push {r5}
push {r6}
push {r7}
push {r8}
push {r9}
mov r1, #0
mov r4, r1
mov r1, r4
mov r10, r1
mov r1, #1
mov r9, r1
mov r1, r9
mov r7, r1
mov r1, #2
mov r8, r1
mov r1, r8
mov r6, r1
mov r1, #3
mov r5, r1
mov r1, r5
str r4, [fp, #-4]
mov r4, r1
mov r1, #4
str r10, [fp, #-8]
mov r10, r1
mov r1, r10
str r9, [fp, #-12]
mov r9, r1
mov r1, #5
str r7, [fp, #-16]
mov r7, r1
mov r1, r7
str r8, [fp, #-20]
mov r8, r1
mov r1, #6
str r6, [fp, #-24]
mov r6, r1
mov r1, r6
str r5, [fp, #-28]
mov r5, r1
mov r1, #7
str r4, [fp, #-32]
mov r4, r1
mov r1, r4
str r10, [fp, #-36]
mov r10, r1
mov r1, #8
str r9, [fp, #-40]
mov r9, r1
mov r1, r9
str r7, [fp, #-44]
mov r7, r1
mov r1, #9
str r8, [fp, #-48]
mov r8, r1
mov r1, r8
str r6, [fp, #-52]
mov r6, r1
mov r1, #10
str r5, [fp, #-56]
mov r5, r1
mov r1, r5
str r4, [fp, #-60]
mov r4, r1
mov r1, #11
str r10, [fp, #-64]
mov r10, r1
mov r1, r10
str r9, [fp, #-68]
mov r9, r1
mov r1, #12
str r7, [fp, #-72]
mov r7, r1
mov r1, r7
str r8, [fp, #-76]
mov r8, r1
mov r1, #13
str r6, [fp, #-80]
mov r6, r1
mov r1, r6
str r5, [fp, #-84]
mov r5, r1
mov r1, #14
str r4, [fp, #-88]
mov r4, r1
mov r1, r4
str r10, [fp, #-92]
mov r10, r1
mov r1, #15
str r9, [fp, #-96]
mov r9, r1
mov r1, r9
str r7, [fp, #-100]
mov r7, r1
b 1f
.ltorg
1:
mov r1, #16
str r8, [fp, #-104]
mov r8, r1
mov r1, r8
str r6, [fp, #-108]
mov r6, r1
mov r1, #17
str r5, [fp, #-112]
mov r5, r1
mov r1, r5
str r4, [fp, #-116]
mov r4, r1
mov r1, #18
str r10, [fp, #-120]
mov r10, r1
mov r1, r10
str r9, [fp, #-124]
mov r9, r1
mov r1, #19
str r7, [fp, #-128]
mov r7, r1
mov r1, r7
str r8, [fp, #-132]
mov r8, r1
mov r1, #20
str r6, [fp, #-136]
mov r6, r1
mov r1, r6
str r5, [fp, #-140]
mov r5, r1
mov r1, #21
str r4, [fp, #-144]
mov r4, r1
mov r1, r4
str r10, [fp, #-148]
mov r10, r1
mov r1, #22
str r9, [fp, #-152]
mov r9, r1
mov r1, r9
str r7, [fp, #-156]
mov r7, r1
mov r1, #23
str r8, [fp, #-160]
mov r8, r1
mov r1, r8
str r6, [fp, #-164]
mov r6, r1
mov r1, #24
str r5, [fp, #-168]
mov r5, r1
mov r1, r5
str r4, [fp, #-172]
mov r4, r1
mov r1, #25
str r10, [fp, #-176]
mov r10, r1
mov r1, r10
str r9, [fp, #-180]
mov r9, r1
mov r1, #26
str r7, [fp, #-184]
mov r7, r1
mov r1, r7
str r8, [fp, #-188]
mov r8, r1
mov r1, #27
str r6, [fp, #-192]
mov r6, r1
mov r1, r6
str r5, [fp, #-196]
mov r5, r1
mov r1, #28
str r4, [fp, #-200]
mov r4, r1
mov r1, r4
str r10, [fp, #-204]
mov r10, r1
mov r1, #29
str r9, [fp, #-208]
mov r9, r1
mov r1, r9
str r7, [fp, #-212]
mov r7, r1
mov r1, #30
str r8, [fp, #-216]
mov r8, r1
mov r1, r8
str r6, [fp, #-220]
mov r6, r1
mov r1, #31
str r5, [fp, #-224]
mov r5, r1
mov r1, r5
str r4, [fp, #-228]
mov r4, r1
mov r1, #32
str r10, [fp, #-232]
mov r10, r1
mov r1, r10
str r9, [fp, #-236]
mov r9, r1
b 1f
.ltorg
1:
mov r1, #33
str r7, [fp, #-240]
mov r7, r1
mov r1, r7
str r8, [fp, #-244]
mov r8, r1
mov r1, #34
str r6, [fp, #-248]
mov r6, r1
mov r1, r6
str r5, [fp, #-252]
mov r5, r1
mov r1, #35
str r4, [fp, #-256]
mov r4, r1
mov r1, r4
str r10, [fp, #-260]
mov r10, r1
mov r1, #36
str r9, [fp, #-264]
mov r9, r1
mov r1, r9
str r7, [fp, #-268]
mov r7, r1
mov r1, #37
str r8, [fp, #-272]
mov r8, r1
mov r1, r8
str r6, [fp, #-276]
mov r6, r1
mov r1, #38
str r5, [fp, #-280]
mov r5, r1
mov r1, r5
str r4, [fp, #-284]
mov r4, r1
mov r1, #39
str r10, [fp, #-288]
mov r10, r1
mov r1, r10
str r9, [fp, #-292]
mov r9, r1
mov r1, #40
str r7, [fp, #-296]
mov r7, r1
mov r1, r7
str r8, [fp, #-300]
mov r8, r1
mov r1, #41
str r6, [fp, #-304]
mov r6, r1
mov r1, r6
str r5, [fp, #-308]
mov r5, r1
mov r1, #42
str r4, [fp, #-312]
mov r4, r1
mov r1, r4
str r10, [fp, #-316]
mov r10, r1
mov r1, #43
str r9, [fp, #-320]
mov r9, r1
mov r1, r9
str r7, [fp, #-324]
mov r7, r1
mov r1, #44
str r8, [fp, #-328]
mov r8, r1
mov r1, r8
str r6, [fp, #-332]
mov r6, r1
mov r1, #45
str r5, [fp, #-336]
mov r5, r1
mov r1, r5
str r4, [fp, #-340]
mov r4, r1
mov r1, #46
str r10, [fp, #-344]
mov r10, r1
mov r1, r10
str r9, [fp, #-348]
mov r9, r1
mov r1, #47
str r7, [fp, #-352]
mov r7, r1
mov r1, r7
str r8, [fp, #-356]
mov r8, r1
mov r1, #48
str r6, [fp, #-360]
mov r6, r1
mov r1, r6
str r5, [fp, #-364]
mov r5, r1
mov r1, #49
str r4, [fp, #-368]
mov r4, r1
mov r1, r4
str r10, [fp, #-372]
mov r10, r1
b 1f
.ltorg
1:
mov r1, #50
str r9, [fp, #-376]
mov r9, r1
mov r1, r9
str r7, [fp, #-380]
mov r7, r1
mov r1, #51
str r8, [fp, #-384]
mov r8, r1
mov r1, r8
str r6, [fp, #-388]
mov r6, r1
mov r1, #52
str r5, [fp, #-392]
mov r5, r1
mov r1, r5
str r4, [fp, #-396]
mov r4, r1
mov r1, #53
str r10, [fp, #-400]
mov r10, r1
mov r1, r10
str r9, [fp, #-404]
mov r9, r1
mov r1, #54
str r7, [fp, #-408]
mov r7, r1
mov r1, r7
str r8, [fp, #-412]
mov r8, r1
mov r1, #55
str r6, [fp, #-416]
mov r6, r1
mov r1, r6
str r5, [fp, #-420]
mov r5, r1
mov r1, #56
str r4, [fp, #-424]
mov r4, r1
mov r1, r4
str r10, [fp, #-428]
mov r10, r1
mov r1, #57
str r9, [fp, #-432]
mov r9, r1
mov r1, r9
str r7, [fp, #-436]
mov r7, r1
mov r1, #58
str r8, [fp, #-440]
mov r8, r1
mov r1, r8
str r6, [fp, #-444]
mov r6, r1
mov r1, #59
str r5, [fp, #-448]
mov r5, r1
mov r1, r5
str r4, [fp, #-452]
mov r4, r1
mov r1, #60
str r10, [fp, #-456]
mov r10, r1
mov r1, r10
str r9, [fp, #-460]
mov r9, r1
mov r1, #61
str r7, [fp, #-464]
mov r7, r1
mov r1, r7
str r8, [fp, #-468]
mov r8, r1
mov r1, #62
str r6, [fp, #-472]
mov r6, r1
mov r1, r6
str r5, [fp, #-476]
mov r5, r1
mov r1, #63
str r4, [fp, #-480]
mov r4, r1
mov r1, r4
str r10, [fp, #-484]
mov r10, r1
mov r1, #64
str r9, [fp, #-488]
mov r9, r1
mov r1, r9
str r7, [fp, #-492]
mov r7, r1
mov r1, #65
str r8, [fp, #-496]
mov r8, r1
mov r1, r8
str r6, [fp, #-500]
mov r6, r1
mov r1, #66
str r5, [fp, #-504]
mov r5, r1
mov r1, r5
str r4, [fp, #-508]
mov r4, r1
b 1f
.ltorg
1:
mov r1, #67
str r10, [fp, #-512]
mov r10, r1
mov r1, r10
str r9, [fp, #-516]
mov r9, r1
mov r1, #68
str r7, [fp, #-520]
mov r7, r1
mov r1, r7
str r8, [fp, #-524]
mov r8, r1
mov r1, #69
str r6, [fp, #-528]
mov r6, r1
mov r1, r6
str r5, [fp, #-532]
mov r5, r1
mov r1, #70
str r4, [fp, #-536]
mov r4, r1
mov r1, r4
str r10, [fp, #-540]
mov r10, r1
mov r1, #71
str r9, [fp, #-544]
mov r9, r1
mov r1, r9
str r7, [fp, #-548]
mov r7, r1
mov r1, #72
str r8, [fp, #-552]
mov r8, r1
mov r1, r8
str r6, [fp, #-556]
mov r6, r1
mov r1, #73
str r5, [fp, #-560]
mov r5, r1
mov r1, r5
str r4, [fp, #-564]
mov r4, r1
mov r1, #74
str r10, [fp, #-568]
mov r10, r1
mov r1, r10
str r9, [fp, #-572]
mov r9, r1
mov r1, #75
str r7, [fp, #-576]
mov r7, r1
mov r1, r7
str r8, [fp, #-580]
mov r8, r1
mov r1, #76
str r6, [fp, #-584]
mov r6, r1
mov r1, r6
str r5, [fp, #-588]
mov r5, r1
mov r1, #77
str r4, [fp, #-592]
mov r4, r1
mov r1, r4
str r10, [fp, #-596]
mov r10, r1
mov r1, #78
str r9, [fp, #-600]
mov r9, r1
mov r1, r9
str r7, [fp, #-604]
mov r7, r1
mov r1, #79
str r8, [fp, #-608]
mov r8, r1
mov r1, r8
str r6, [fp, #-612]
mov r6, r1
mov r1, #80
str r5, [fp, #-616]
mov r5, r1
mov r1, r5
str r4, [fp, #-620]
mov r4, r1
mov r1, #81
str r10, [fp, #-624]
mov r10, r1
mov r1, r10
str r9, [fp, #-628]
mov r9, r1
mov r1, #82
str r7, [fp, #-632]
mov r7, r1
mov r1, r7
str r8, [fp, #-636]
mov r8, r1
mov r1, #83
str r6, [fp, #-640]
mov r6, r1
mov r1, r6
str r5, [fp, #-644]
mov r5, r1
b 1f
.ltorg
1:
mov r1, #84
str r4, [fp, #-648]
mov r4, r1
mov r1, r4
str r10, [fp, #-652]
mov r10, r1
mov r1, #85
str r9, [fp, #-656]
mov r9, r1
mov r1, r9
str r7, [fp, #-660]
mov r7, r1
mov r1, #86
str r8, [fp, #-664]
mov r8, r1
mov r1, r8
str r6, [fp, #-668]
mov r6, r1
mov r1, #87
str r5, [fp, #-672]
mov r5, r1
mov r1, r5
str r4, [fp, #-676]
mov r4, r1
mov r1, #88
str r10, [fp, #-680]
mov r10, r1
mov r1, r10
str r9, [fp, #-684]
mov r9, r1
mov r1, #89
str r7, [fp, #-688]
mov r7, r1
mov r1, r7
str r8, [fp, #-692]
mov r8, r1
mov r1, #90
str r6, [fp, #-696]
mov r6, r1
mov r1, r6
str r5, [fp, #-700]
mov r5, r1
mov r1, #91
str r4, [fp, #-704]
mov r4, r1
mov r1, r4
str r10, [fp, #-708]
mov r10, r1
mov r1, #92
str r9, [fp, #-712]
mov r9, r1
mov r1, r9
str r7, [fp, #-716]
mov r7, r1
mov r1, #93
str r8, [fp, #-720]
mov r8, r1
mov r1, r8
str r6, [fp, #-724]
mov r6, r1
mov r1, #94
str r5, [fp, #-728]
mov r5, r1
mov r1, r5
str r4, [fp, #-732]
mov r4, r1
mov r1, #95
str r10, [fp, #-736]
mov r10, r1
mov r1, r10
str r9, [fp, #-740]
mov r9, r1
mov r1, #96
str r7, [fp, #-744]
mov r7, r1
mov r1, r7
str r8, [fp, #-748]
mov r8, r1
mov r1, #97
str r6, [fp, #-752]
mov r6, r1
mov r1, r6
str r5, [fp, #-756]
mov r5, r1
mov r1, #98
str r4, [fp, #-760]
mov r4, r1
mov r1, r4
str r10, [fp, #-764]
mov r10, r1
mov r1, #99
str r9, [fp, #-768]
mov r9, r1
mov r1, r9
str r7, [fp, #-772]
mov r7, r1
mov r1, #100
str r8, [fp, #-776]
mov r8, r1
mov r1, r8
str r6, [fp, #-780]
mov r6, r1
b 1f
.ltorg
1:
mov r1, #101
str r5, [fp, #-784]
mov r5, r1
mov r1, r5
str r4, [fp, #-788]
mov r4, r1
mov r1, #102
str r10, [fp, #-792]
mov r10, r1
mov r1, r10
str r9, [fp, #-796]
mov r9, r1
mov r1, #103
str r7, [fp, #-800]
mov r7, r1
mov r1, r7
str r8, [fp, #-804]
mov r8, r1
mov r1, #104
str r6, [fp, #-808]
mov r6, r1
mov r1, r6
str r5, [fp, #-812]
mov r5, r1
mov r1, #105
str r4, [fp, #-816]
mov r4, r1
mov r1, r4
str r10, [fp, #-820]
mov r10, r1
mov r1, #106
str r9, [fp, #-824]
mov r9, r1
mov r1, r9
str r7, [fp, #-828]
mov r7, r1
mov r1, #107
str r8, [fp, #-832]
mov r8, r1
mov r1, r8
str r6, [fp, #-836]
mov r6, r1
mov r1, #108
str r5, [fp, #-840]
mov r5, r1
mov r1, r5
str r4, [fp, #-844]
mov r4, r1
mov r1, #109
str r10, [fp, #-848]
mov r10, r1
mov r1, r10
str r9, [fp, #-852]
mov r9, r1
mov r1, #110
str r7, [fp, #-856]
mov r7, r1
mov r1, r7
str r8, [fp, #-860]
mov r8, r1
mov r1, #111
str r6, [fp, #-864]
mov r6, r1
mov r1, r6
str r5, [fp, #-868]
mov r5, r1
mov r1, #112
str r4, [fp, #-872]
mov r4, r1
mov r1, r4
str r10, [fp, #-876]
mov r10, r1
mov r1, #113
str r9, [fp, #-880]
mov r9, r1
mov r1, r9
str r7, [fp, #-884]
mov r7, r1
mov r1, #114
str r8, [fp, #-888]
mov r8, r1
mov r1, r8
str r6, [fp, #-892]
mov r6, r1
mov r1, #115
str r5, [fp, #-896]
mov r5, r1
mov r1, r5
str r4, [fp, #-900]
mov r4, r1
mov r1, #116
str r10, [fp, #-904]
mov r10, r1
mov r1, r10
str r9, [fp, #-908]
mov r9, r1
mov r1, #117
str r7, [fp, #-912]
mov r7, r1
mov r1, r7
str r8, [fp, #-916]
mov r8, r1
b 1f
.ltorg
1:
mov r1, #118
str r6, [fp, #-920]
mov r6, r1
mov r1, r6
str r5, [fp, #-924]
mov r5, r1
mov r1, #119
str r4, [fp, #-928]
mov r4, r1
mov r1, r4
str r10, [fp, #-932]
mov r10, r1
mov r1, #120
str r9, [fp, #-936]
mov r9, r1
mov r1, r9
str r7, [fp, #-940]
mov r7, r1
mov r1, #121
str r8, [fp, #-944]
mov r8, r1
mov r1, r8
str r6, [fp, #-948]
mov r6, r1
mov r1, #122
str r5, [fp, #-952]
mov r5, r1
mov r1, r5
str r4, [fp, #-956]
mov r4, r1
mov r1, #123
str r10, [fp, #-960]
mov r10, r1
mov r1, r10
str r9, [fp, #-964]
mov r9, r1
mov r1, #124
str r7, [fp, #-968]
mov r7, r1
mov r1, r7
str r8, [fp, #-972]
mov r8, r1
mov r1, #125
str r6, [fp, #-976]
mov r6, r1
mov r1, r6
str r5, [fp, #-980]
mov r5, r1
mov r1, #126
str r4, [fp, #-984]
mov r4, r1
mov r1, r4
str r10, [fp, #-988]
mov r10, r1
mov r1, #127
str r9, [fp, #-992]
mov r9, r1
mov r1, r9
str r7, [fp, #-996]
mov r7, r1
mov r1, #128
str r8, [fp, #-1000]
mov r8, r1
mov r1, r8
str r6, [fp, #-1004]
mov r6, r1
mov r1, #129
str r5, [fp, #-1008]
mov r5, r1
mov r1, r5
str r4, [fp, #-1012]
mov r4, r1
mov r1, #130
str r10, [fp, #-1016]
mov r10, r1
mov r1, r10
str r9, [fp, #-1020]
mov r9, r1
mov r1, #131
str r7, [fp, #-1024]
mov r7, r1
mov r1, r7
str r8, [fp, #-1028]
mov r8, r1
mov r1, #132
str r6, [fp, #-1032]
mov r6, r1
mov r1, r6
str r5, [fp, #-1036]
mov r5, r1
mov r1, #133
str r4, [fp, #-1040]
mov r4, r1
mov r1, r4
str r10, [fp, #-1044]
mov r10, r1
mov r1, #134
str r9, [fp, #-1048]
mov r9, r1
mov r1, r9
str r7, [fp, #-1052]
mov r7, r1
b 1f
.ltorg
1:
mov r1, #135
str r8, [fp, #-1056]
mov r8, r1
mov r1, r8
str r6, [fp, #-1060]
mov r6, r1
mov r1, #136
str r5, [fp, #-1064]
mov r5, r1
mov r1, r5
str r4, [fp, #-1068]
mov r4, r1
mov r1, #137
str r10, [fp, #-1072]
mov r10, r1
mov r1, r10
str r9, [fp, #-1076]
mov r9, r1
mov r1, #138
str r7, [fp, #-1080]
mov r7, r1
mov r1, r7
str r8, [fp, #-1084]
mov r8, r1
mov r1, #139
str r6, [fp, #-1088]
mov r6, r1
mov r1, r6
str r5, [fp, #-1092]
mov r5, r1
mov r1, #140
str r4, [fp, #-1096]
mov r4, r1
mov r1, r4
str r10, [fp, #-1100]
mov r10, r1
mov r1, #141
str r9, [fp, #-1104]
mov r9, r1
mov r1, r9
str r7, [fp, #-1108]
mov r7, r1
mov r1, #142
str r8, [fp, #-1112]
mov r8, r1
mov r1, r8
str r6, [fp, #-1116]
mov r6, r1
mov r1, #143
str r5, [fp, #-1120]
mov r5, r1
mov r1, r5
str r4, [fp, #-1124]
mov r4, r1
mov r1, #144
str r10, [fp, #-1128]
mov r10, r1
mov r1, r10
str r9, [fp, #-1132]
mov r9, r1
mov r1, #145
str r7, [fp, #-1136]
mov r7, r1
mov r1, r7
str r8, [fp, #-1140]
mov r8, r1
mov r1, #146
str r6, [fp, #-1144]
mov r6, r1
mov r1, r6
str r5, [fp, #-1148]
mov r5, r1
mov r1, #147
str r4, [fp, #-1152]
mov r4, r1
mov r1, r4
str r10, [fp, #-1156]
mov r10, r1
mov r1, #148
str r9, [fp, #-1160]
mov r9, r1
mov r1, r9
str r7, [fp, #-1164]
mov r7, r1
mov r1, #149
str r8, [fp, #-1168]
mov r8, r1
mov r1, r8
str r6, [fp, #-1172]
mov r6, r1
mov r1, #150
str r5, [fp, #-1176]
mov r5, r1
mov r1, r5
str r4, [fp, #-1180]
mov r4, r1
mov r1, #151
str r10, [fp, #-1184]
mov r10, r1
mov r1, r10
str r9, [fp, #-1188]
mov r9, r1
b 1f
.ltorg
1:
mov r1, #152
str r7, [fp, #-1192]
mov r7, r1
mov r1, r7
str r8, [fp, #-1196]
mov r8, r1
mov r1, #153
str r6, [fp, #-1200]
mov r6, r1
mov r1, r6
str r5, [fp, #-1204]
mov r5, r1
mov r1, #154
str r4, [fp, #-1208]
mov r4, r1
mov r1, r4
str r10, [fp, #-1212]
mov r10, r1
mov r1, #155
str r9, [fp, #-1216]
mov r9, r1
mov r1, r9
str r7, [fp, #-1220]
mov r7, r1
mov r1, #156
str r8, [fp, #-1224]
mov r8, r1
mov r1, r8
str r6, [fp, #-1228]
mov r6, r1
mov r1, #157
str r5, [fp, #-1232]
mov r5, r1
mov r1, r5
str r4, [fp, #-1236]
mov r4, r1
mov r1, #158
str r10, [fp, #-1240]
mov r10, r1
mov r1, r10
str r9, [fp, #-1244]
mov r9, r1
mov r1, #159
str r7, [fp, #-1248]
mov r7, r1
mov r1, r7
str r8, [fp, #-1252]
mov r8, r1
mov r1, #160
str r6, [fp, #-1256]
mov r6, r1
mov r1, r6
str r5, [fp, #-1260]
mov r5, r1
mov r1, #161
str r4, [fp, #-1264]
mov r4, r1
mov r1, r4
str r10, [fp, #-1268]
mov r10, r1
mov r1, #162
str r9, [fp, #-1272]
mov r9, r1
mov r1, r9
str r7, [fp, #-1276]
mov r7, r1
mov r1, #163
str r8, [fp, #-1280]
mov r8, r1
mov r1, r8
str r6, [fp, #-1284]
mov r6, r1
mov r1, #164
str r5, [fp, #-1288]
mov r5, r1
mov r1, r5
str r4, [fp, #-1292]
mov r4, r1
mov r1, #165
str r10, [fp, #-1296]
mov r10, r1
mov r1, r10
str r9, [fp, #-1300]
mov r9, r1
mov r1, #166
str r7, [fp, #-1304]
mov r7, r1
mov r1, r7
str r8, [fp, #-1308]
mov r8, r1
mov r1, #167
str r6, [fp, #-1312]
mov r6, r1
mov r1, r6
str r5, [fp, #-1316]
mov r5, r1
mov r1, #168
str r4, [fp, #-1320]
mov r4, r1
mov r1, r4
str r10, [fp, #-1324]
mov r10, r1
b 1f
.ltorg
1:
mov r1, #169
str r9, [fp, #-1328]
mov r9, r1
mov r1, r9
str r7, [fp, #-1332]
mov r7, r1
mov r1, #170
str r8, [fp, #-1336]
mov r8, r1
mov r1, r8
str r6, [fp, #-1340]
mov r6, r1
mov r1, #171
str r5, [fp, #-1344]
mov r5, r1
mov r1, r5
str r4, [fp, #-1348]
mov r4, r1
mov r1, #172
str r10, [fp, #-1352]
mov r10, r1
mov r1, r10
str r9, [fp, #-1356]
mov r9, r1
mov r1, #173
str r7, [fp, #-1360]
mov r7, r1
mov r1, r7
str r8, [fp, #-1364]
mov r8, r1
mov r1, #174
str r6, [fp, #-1368]
mov r6, r1
mov r1, r6
str r5, [fp, #-1372]
mov r5, r1
mov r1, #175
str r4, [fp, #-1376]
mov r4, r1
mov r1, r4
str r10, [fp, #-1380]
mov r10, r1
mov r1, #176
str r9, [fp, #-1384]
mov r9, r1
mov r1, r9
str r7, [fp, #-1388]
mov r7, r1
mov r1, #177
str r8, [fp, #-1392]
mov r8, r1
mov r1, r8
str r6, [fp, #-1396]
mov r6, r1
mov r1, #178
str r5, [fp, #-1400]
mov r5, r1
mov r1, r5
str r4, [fp, #-1404]
mov r4, r1
mov r1, #179
str r10, [fp, #-1408]
mov r10, r1
mov r1, r10
str r9, [fp, #-1412]
mov r9, r1
mov r1, #180
str r7, [fp, #-1416]
mov r7, r1
mov r1, r7
str r8, [fp, #-1420]
mov r8, r1
mov r1, #181
str r6, [fp, #-1424]
mov r6, r1
mov r1, r6
str r5, [fp, #-1428]
mov r5, r1
mov r1, #182
str r4, [fp, #-1432]
mov r4, r1
mov r1, r4
str r10, [fp, #-1436]
mov r10, r1
mov r1, #183
str r9, [fp, #-1440]
mov r9, r1
mov r1, r9
str r7, [fp, #-1444]
mov r7, r1
mov r1, #184
str r8, [fp, #-1448]
mov r8, r1
mov r1, r8
str r6, [fp, #-1452]
mov r6, r1
mov r1, #185
str r5, [fp, #-1456]
mov r5, r1
mov r1, r5
str r4, [fp, #-1460]
mov r4, r1
b 1f
.ltorg
1:
mov r1, #186
str r10, [fp, #-1464]
mov r10, r1
mov r1, r10
str r9, [fp, #-1468]
mov r9, r1
mov r1, #187
str r7, [fp, #-1472]
mov r7, r1
mov r1, r7
str r8, [fp, #-1476]
mov r8, r1
mov r1, #188
str r6, [fp, #-1480]
mov r6, r1
mov r1, r6
str r5, [fp, #-1484]
mov r5, r1
mov r1, #189
str r4, [fp, #-1488]
mov r4, r1
mov r1, r4
str r10, [fp, #-1492]
mov r10, r1
mov r1, #190
str r9, [fp, #-1496]
mov r9, r1
mov r1, r9
str r7, [fp, #-1500]
mov r7, r1
mov r1, #191
str r8, [fp, #-1504]
mov r8, r1
mov r1, r8
str r6, [fp, #-1508]
mov r6, r1
mov r1, #192
str r5, [fp, #-1512]
mov r5, r1
mov r1, r5
str r4, [fp, #-1516]
mov r4, r1
mov r1, #193
str r10, [fp, #-1520]
mov r10, r1
mov r1, r10
str r9, [fp, #-1524]
mov r9, r1
mov r1, #194
str r7, [fp, #-1528]
mov r7, r1
mov r1, r7
str r8, [fp, #-1532]
mov r8, r1
mov r1, #195
str r6, [fp, #-1536]
mov r6, r1
mov r1, r6
str r5, [fp, #-1540]
mov r5, r1
mov r1, #196
str r4, [fp, #-1544]
mov r4, r1
mov r1, r4
str r10, [fp, #-1548]
mov r10, r1
mov r1, #197
str r9, [fp, #-1552]
mov r9, r1
mov r1, r9
str r7, [fp, #-1556]
mov r7, r1
mov r1, #198
str r8, [fp, #-1560]
mov r8, r1
mov r1, r8
str r6, [fp, #-1564]
mov r6, r1
mov r1, #199
str r5, [fp, #-1568]
mov r5, r1
mov r1, r5
str r4, [fp, #-1572]
mov r4, r1
mov r1, #200
str r10, [fp, #-1576]
mov r10, r1
mov r1, r10
str r9, [fp, #-1580]
mov r9, r1
mov r1, #201
str r7, [fp, #-1584]
mov r7, r1
mov r1, r7
str r8, [fp, #-1588]
mov r8, r1
mov r1, #202
str r6, [fp, #-1592]
mov r6, r1
mov r1, r6
str r5, [fp, #-1596]
mov r5, r1
b 1f
.ltorg
1:
mov r1, #203
str r4, [fp, #-1600]
mov r4, r1
mov r1, r4
str r10, [fp, #-1604]
mov r10, r1
mov r1, #204
str r9, [fp, #-1608]
mov r9, r1
mov r1, r9
str r7, [fp, #-1612]
mov r7, r1
mov r1, #205
str r8, [fp, #-1616]
mov r8, r1
mov r1, r8
str r6, [fp, #-1620]
mov r6, r1
mov r1, #206
str r5, [fp, #-1624]
mov r5, r1
mov r1, r5
str r4, [fp, #-1628]
mov r4, r1
mov r1, #207
str r10, [fp, #-1632]
mov r10, r1
mov r1, r10
str r9, [fp, #-1636]
mov r9, r1
mov r1, #208
str r7, [fp, #-1640]
mov r7, r1
mov r1, r7
str r8, [fp, #-1644]
mov r8, r1
mov r1, #209
str r6, [fp, #-1648]
mov r6, r1
mov r1, r6
str r5, [fp, #-1652]
mov r5, r1
mov r1, #210
str r4, [fp, #-1656]
mov r4, r1
mov r1, r4
str r10, [fp, #-1660]
mov r10, r1
mov r1, #211
str r9, [fp, #-1664]
mov r9, r1
mov r1, r9
str r7, [fp, #-1668]
mov r7, r1
mov r1, #212
str r8, [fp, #-1672]
mov r8, r1
mov r1, r8
str r6, [fp, #-1676]
mov r6, r1
mov r1, #213
str r5, [fp, #-1680]
mov r5, r1
mov r1, r5
str r4, [fp, #-1684]
mov r4, r1
mov r1, #214
str r10, [fp, #-1688]
mov r10, r1
mov r1, r10
str r9, [fp, #-1692]
mov r9, r1
mov r1, #215
str r7, [fp, #-1696]
mov r7, r1
mov r1, r7
str r8, [fp, #-1700]
mov r8, r1
mov r1, #216
str r6, [fp, #-1704]
mov r6, r1
mov r1, r6
str r5, [fp, #-1708]
mov r5, r1
mov r1, #217
str r4, [fp, #-1712]
mov r4, r1
mov r1, r4
str r10, [fp, #-1716]
mov r10, r1
mov r1, #218
str r9, [fp, #-1720]
mov r9, r1
mov r1, r9
str r7, [fp, #-1724]
mov r7, r1
mov r1, #219
str r8, [fp, #-1728]
mov r8, r1
mov r1, r8
str r6, [fp, #-1732]
mov r6, r1
b 1f
.ltorg
1:
mov r1, #220
str r5, [fp, #-1736]
mov r5, r1
mov r1, r5
str r4, [fp, #-1740]
mov r4, r1
mov r1, #221
str r10, [fp, #-1744]
mov r10, r1
mov r1, r10
str r9, [fp, #-1748]
mov r9, r1
mov r1, #222
str r7, [fp, #-1752]
mov r7, r1
mov r1, r7
str r8, [fp, #-1756]
mov r8, r1
mov r1, #223
str r6, [fp, #-1760]
mov r6, r1
mov r1, r6
str r5, [fp, #-1764]
mov r5, r1
mov r1, #224
str r4, [fp, #-1768]
mov r4, r1
mov r1, r4
str r10, [fp, #-1772]
mov r10, r1
mov r1, #225
str r9, [fp, #-1776]
mov r9, r1
mov r1, r9
str r7, [fp, #-1780]
mov r7, r1
mov r1, #226
str r8, [fp, #-1784]
mov r8, r1
mov r1, r8
str r6, [fp, #-1788]
mov r6, r1
mov r1, #227
str r5, [fp, #-1792]
mov r5, r1
mov r1, r5
str r4, [fp, #-1796]
mov r4, r1
mov r1, #228
str r10, [fp, #-1800]
mov r10, r1
mov r1, r10
str r9, [fp, #-1804]
mov r9, r1
mov r1, #229
str r7, [fp, #-1808]
mov r7, r1
mov r1, r7
str r8, [fp, #-1812]
mov r8, r1
mov r1, #230
str r6, [fp, #-1816]
mov r6, r1
mov r1, r6
str r5, [fp, #-1820]
mov r5, r1
mov r1, #231
str r4, [fp, #-1824]
mov r4, r1
mov r1, r4
str r10, [fp, #-1828]
mov r10, r1
mov r1, #232
str r9, [fp, #-1832]
mov r9, r1
mov r1, r9
str r7, [fp, #-1836]
mov r7, r1
mov r1, #233
str r8, [fp, #-1840]
mov r8, r1
mov r1, r8
str r6, [fp, #-1844]
mov r6, r1
mov r1, #234
str r5, [fp, #-1848]
mov r5, r1
mov r1, r5
str r4, [fp, #-1852]
mov r4, r1
mov r1, #235
str r10, [fp, #-1856]
mov r10, r1
mov r1, r10
str r9, [fp, #-1860]
mov r9, r1
mov r1, #236
str r7, [fp, #-1864]
mov r7, r1
mov r1, r7
str r8, [fp, #-1868]
mov r8, r1
b 1f
.ltorg
1:
mov r1, #237
str r6, [fp, #-1872]
mov r6, r1
mov r1, r6
str r5, [fp, #-1876]
mov r5, r1
mov r1, #238
str r4, [fp, #-1880]
mov r4, r1
mov r1, r4
str r10, [fp, #-1884]
mov r10, r1
mov r1, #239
str r9, [fp, #-1888]
mov r9, r1
mov r1, r9
str r7, [fp, #-1892]
mov r7, r1
mov r1, #240
str r8, [fp, #-1896]
mov r8, r1
mov r1, r8
str r6, [fp, #-1900]
mov r6, r1
mov r1, #241
str r5, [fp, #-1904]
mov r5, r1
mov r1, r5
str r4, [fp, #-1908]
mov r4, r1
mov r1, #242
str r10, [fp, #-1912]
mov r10, r1
mov r1, r10
str r9, [fp, #-1916]
mov r9, r1
mov r1, #243
str r7, [fp, #-1920]
mov r7, r1
mov r1, r7
str r8, [fp, #-1924]
mov r8, r1
mov r1, #244
str r6, [fp, #-1928]
mov r6, r1
mov r1, r6
str r5, [fp, #-1932]
mov r5, r1
mov r1, #245
str r4, [fp, #-1936]
mov r4, r1
mov r1, r4
str r10, [fp, #-1940]
mov r10, r1
mov r1, #246
str r9, [fp, #-1944]
mov r9, r1
mov r1, r9
str r7, [fp, #-1948]
mov r7, r1
mov r1, #247
str r8, [fp, #-1952]
mov r8, r1
mov r1, r8
str r6, [fp, #-1956]
mov r6, r1
mov r1, #248
str r5, [fp, #-1960]
mov r5, r1
mov r1, r5
str r4, [fp, #-1964]
mov r4, r1
mov r1, #249
str r10, [fp, #-1968]
mov r10, r1
mov r1, r10
str r9, [fp, #-1972]
mov r9, r1
mov r1, #250
str r7, [fp, #-1976]
mov r7, r1
mov r1, r7
str r8, [fp, #-1980]
mov r8, r1
mov r1, #251
str r6, [fp, #-1984]
mov r6, r1
mov r1, r6
str r5, [fp, #-1988]
mov r5, r1
mov r1, #252
str r4, [fp, #-1992]
mov r4, r1
mov r1, r4
str r10, [fp, #-1996]
mov r10, r1
mov r1, #253
str r9, [fp, #-2000]
mov r9, r1
mov r1, r9
str r7, [fp, #-2004]
mov r7, r1
b 1f
.ltorg
1:
mov r1, #254
str r8, [fp, #-2008]
mov r8, r1
mov r1, r8
str r6, [fp, #-2012]
mov r6, r1
mov r1, #255
str r5, [fp, #-2016]
mov r5, r1
mov r1, r5
str r4, [fp, #-2020]
mov r4, r1
ldr r1, =#256
str r10, [fp, #-2024]
mov r10, r1
mov r1, r10
str r9, [fp, #-2028]
mov r9, r1
mov r0, #0
ldr r12, =#2028
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

