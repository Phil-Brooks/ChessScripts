using Chess

include(raw"D:\Github\JuliaScripts\best.jl")

bestdictfl = raw"D:\lc0\julia\e6.txt"

dct = Best.getdict(bestdictfl)
cbd = startboard()
bmrs = dct[fen(cbd)]


function dobm()
    domove(cbd, bmrs.BestMove)
end

function n(r)
    if r==""
        global cbd = startboard()
        global bmrs = dct[fen(cbd)]
        println(bmrs)
        cbd
    else
        nbd = bmrs.BestMove=="" ? cbd : domove(cbd, bmrs.BestMove)
        global cbd = domove(nbd, r)
        global bmrs = haskey(dct, fen(cbd)) ? dct[fen(cbd)] : Best.Bmresps("NOT FOUND", [])
        println(bmrs)
        cbd
    end
end

function add()
    Best.addboard(cbd, dct)
    Best.savedict(bestdictfl, dct)
    global bmrs = dct[fen(cbd)]
    println(bmrs)
    cbd
end

Base.:!(r::String) = n(r)
Base.:!(r::Integer) = n(r==0 ? "" : bmrs.Replies[r])

#!0