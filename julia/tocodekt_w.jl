using Chess
using DelimitedFiles

include("best.jl")

bestdictfl = raw"D:\lc0\julia\lc0white10.txt"
codefl1 = raw"D:\Github\BestWhiteAnd\app\src\main\java\com\example\bestwhiteand\ChessData1.kt"
codefl2 = raw"D:\Github\BestWhiteAnd\app\src\main\java\com\example\bestwhiteand\ChessData2.kt"
codefl3 = raw"D:\Github\BestWhiteAnd\app\src\main\java\com\example\bestwhiteand\ChessData3.kt"
codefl4 = raw"D:\Github\BestWhiteAnd\app\src\main\java\com\example\bestwhiteand\ChessData4.kt"

lines = readlines(bestdictfl)
dct = Best.loaddict(lines)

function tocod(k,v)
    bd = fromfen(k)
    bm = v.BestMove
    nbd = domove(bd, bm)
    bmfen = fen(nbd)
    rsa = v.Replies
    rbda = length(rsa)==0 ? [] : map(r -> fen(domove(nbd, r)), rsa) 
    nln =
        k * "|" *
        bm * ":" * bmfen * ";" *
        (length(rsa)==0 ? "" : reduce((a,b) -> a * "," * b, rsa)) * ";" *
        (length(rbda)==0 ? "" : reduce((a,b) -> a * "," * b, rbda))
    
    pref = "        \""
    suf = "\","
    ans = pref * nln * suf
    ans
end

arrlines = tocod.(keys(dct), values(dct))

start1 =
    [
    "package com.example.bestwhiteand"
    ""
    "class ChessData1(){"
    "    val lines = arrayOf("
    ]
start2 =
    [
    "package com.example.bestwhiteand"
    ""
    "class ChessData2(){"
    "    val lines = arrayOf("
    ]
start3 =
    [
    "package com.example.bestwhiteand"
    ""
    "class ChessData3(){"
    "    val lines = arrayOf("
    ]
start4 =
    [
    "package com.example.bestwhiteand"
    ""
    "class ChessData4(){"
    "    val lines = arrayOf("
    ]
nd = 
    [
    "    )"
    "}"
    ]


mid = length(arrlines)÷4
mid2 = 2*mid
mid3 = 3*mid
arrlines1 = arrlines[1:mid]
arrlines2 = arrlines[mid+1:mid2]
arrlines3 = arrlines[mid2+1:mid3]
arrlines4 = arrlines[mid3+1:end]

codelines1 = vcat(start1,vcat(arrlines1, nd))
writedlm(codefl1,codelines1,quotes=false)
codelines2 = vcat(start2,vcat(arrlines2, nd))
writedlm(codefl2,codelines2,quotes=false)
codelines3 = vcat(start3, vcat(arrlines3, nd))
writedlm(codefl3,codelines3,quotes=false)
codelines4 = vcat(start4,vcat(arrlines4, nd))
writedlm(codefl4,codelines4,quotes=false)