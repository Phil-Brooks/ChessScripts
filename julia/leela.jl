module Leela

using Chess
using Chess.UCI

function getbestmove(bd)
    lc0 = runengine("d:\\lc0\\lc0.exe")
    newgame(lc0)
    setboard(lc0, bd)
    ans = search(lc0, "go movetime 10000", infoaction=nothing)
    bm = ans.bestmove
    quit(lc0)
    movetosan(bd, bm)
end

end