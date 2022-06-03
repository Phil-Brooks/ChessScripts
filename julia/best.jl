module Best

using Chess
using DelimitedFiles

include("leela.jl")
include("openexp.jl")


struct Bmresps
    BestMove::String
    Replies::Array{String}
end

function loaddict(lns)
    ans = Dict{String,Bmresps}()
    # need to process each line
    for ln in lns
        bits = split(ln,"|")
        cfen = bits[1]
        bm = bits[2]
        rsstr = bits[3]
        rs = rsstr=="" ? [] : split(rsstr,",")
        bmrs = Bmresps(bm, rs)
        ans[cfen] = bmrs
    end

    ans
end

function getdict(fl)
    if isfile(fl)
        lns = readlines(fl)
        loaddict(lns)
    else
        Dict{String,Bmresps}()
    end
end

function doln(k, v)
    if length(v.Replies) == 0
        k * "|" * v.BestMove * "|"
    else
        rs = reduce((a, b) -> a * "," * b, v.Replies)
        k * "|" * v.BestMove * "|" * rs
    end
end

function savedict(fl, dct)
    lns = doln.(keys(dct), values(dct))
    writedlm(fl, lns)
end

function addboard(bd, dct)
    if !haskey(dct,fen(bd))
        bm = Leela.getbestmove(bd)
        nbd = domove(bd, bm)
        sans = OpenExp.getmoves(fen(nbd))
        bmresp = Best.Bmresps(bm, sans)
        dct[fen(bd)] = bmresp
    end
end

function expandmove(m, b, dct)
    bd = domove(b, m)
    addboard(bd, dct)
end

function expandkey(k, v, dct)
    bd = fromfen(k)
    nbd = v.BestMove== "" ? bd : domove(bd, v.BestMove)
    for r in v.Replies
        expandmove(r,nbd, dct)
    end
    dct

end

function expand(dct)
    #need to copy as keeps going forever
    odct = deepcopy(dct)
    for (key, value) in odct
        expandkey(key, value, dct)
    end
    dct
end


end