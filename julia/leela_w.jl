using Chess

include("best.jl")
include("openexp.jl")

bestdictfl = raw"D:\lc0\julia\d4.txt"

function initialise()
    bd = startboard()
    bm = "d4"
    nbd = domove(bd, bm)
    sans = OpenExp.getmoves(fen(nbd))
    bmresp = Best.Bmresps(bm, sans)
    dct = Dict{String,Best.Bmresps}(fen(bd) => bmresp)
    Best.savedict(bestdictfl, dct)
end

dct = Best.getdict(bestdictfl)

if length(dct)==0
    initialise()
else
    ndct = Best.expand(dct)
    Best.savedict(bestdictfl, ndct)
end
