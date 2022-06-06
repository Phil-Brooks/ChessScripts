module Stock

using Chess
using Chess.UCI

function getbestmove(bd)
    sf = runengine("d:\\lc0\\stockfish_15\\stockfish_15_x64_avx2.exe")
    setoption(sf, "Threads", 12)
    newgame(sf)
    setboard(sf, bd)
    ans = search(sf, "go movetime 10000", infoaction=nothing)
    bm = ans.bestmove
    quit(sf)
    movetosan(bd, bm)
end

end