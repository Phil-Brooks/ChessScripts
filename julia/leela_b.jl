using Chess

include("openexp.jl")
include("best.jl")

bestdictfl = raw"D:\lc0\julia\e6.txt"

function initialise()
    bd = startboard()
    sans = OpenExp.getmoves(fen(bd))
    bmresp = Best.Bmresps("", sans)
    dct = Dict{String,Best.Bmresps}(fen(bd) => bmresp)
    Best.savedict(bestdictfl, dct)
    #add e6 replies
    function dosan(san)
        cbd = domove(bd, san)
        bm = "e6"
        nbd = domove(cbd, bm)
        nsans = OpenExp.getmoves(fen(nbd))
        nbmresp = Best.Bmresps(bm, nsans)
        dct[fen(cbd)] = nbmresp
        Best.savedict(bestdictfl, dct)
    end
    dosan.(sans)
end

dct = Best.getdict(bestdictfl)

if length(dct)==0
    initialise()
else
    ndct = Best.expand(dct)
    Best.savedict(bestdictfl, ndct)
end
