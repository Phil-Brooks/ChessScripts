using Chess

include("best.jl")

olddictfl = raw"D:\lc0\lc0black10.txt"
fixdictfl = raw"D:\lc0\julia\lc0black10.txt"

odct = Best.getdict(olddictfl)
fdict = Dict{String,Best.Bmresps}()

for (key, value) in odct
    nkey = fen(fromfen(key))
    fdict[nkey] = value
end

Best.savedict(fixdictfl, fdict)