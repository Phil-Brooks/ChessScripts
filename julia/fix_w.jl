bestdictfl = raw"D:\lc0\julia\d4.txt"

function dct2fens(k,v)
    bd = fromfen(k)
    bm = v.BestMove
    nbd = bm=="" ? bd : domove(bd, bm)
    rsa = v.Replies
    rbda = length(rsa)==0 ? [] : map(r -> fen(domove(nbd, r)), rsa) 
end

dct = Best.getdict(bestdictfl)
ofens = reduce(hcat, dct2fens.(dct))
oset = Set(ofens)
iset = Set(map((k,v) -> k, dct))

odct = deepcopy(dct)
orphans = setdiff(iset, oset)

function remov(o)
    fenstar = fen(startboard())
    if o!=fenstar
        delete!(odct, o)
    end
end

for o in orphans
    remov(o)
end

Best.savedict(bestdictfl, odct)