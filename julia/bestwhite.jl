using Chess

include(raw"D:\Github\ChessScripts\julia\best.jl")

bestdictfl = raw"D:\lc0\julia\d4.txt"

dct = Best.getdict(bestdictfl)
cbd = startboard()
bmrs = dct[fen(cbd)]

function setbd(bd)
    global cbd = bd
    global bmrs = haskey(dct, fen(cbd)) ? dct[fen(cbd)] : Best.Bmresps("NOT FOUND", [])
    println(bmrs)
    cbd
end

function b()
    println(bmrs)
    domove(cbd, bmrs.BestMove)
end

function f(fn)
    setbd(fromfen(fn))
end

function n(r)
    if r==""
        setbd(startboard())
    else
        nbd = bmrs.BestMove=="" ? cbd : domove(cbd, bmrs.BestMove)
        setbd(domove(nbd, r))
    end
end

function a()
    Best.addboard(cbd, dct)
    Best.savedict(bestdictfl, dct)
    setbd(cbd)
end

function sb(bm)
    Best.setbm(bm, cbd, dct)
    Best.savedict(bestdictfl, dct)
    setbd(cbd)
end

Base.:!(r::String) = n(r)
Base.:!(r::Integer) = n(r==0 ? "" : bmrs.Replies[r])

# Options
# !n - move forward based on nth response
# !0 - go to start
# b() - play best move
# a() - add for missing board
# f(fen) - go to board of the FEN fen
# sb(bm) - replace best move with bm
