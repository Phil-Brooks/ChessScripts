module OpenExp

using HTTP
using HTTP.URIs
using JSON

function getmoves(ifen)
    cfen = escapeuri(ifen)
    addr = "https://explorer.lichess.ovh/masters?fen=" * cfen
    resp = HTTP.get(addr)
    str = String(resp.body)
    jobj = JSON.Parser.parse(str)
    moves = jobj["moves"]
    sans = map(m -> m["san"], moves)
    sans
end

# looks like generates rubbish options!
function getbestmoveblack(ifen)
    ifen = "rnbqkbnr/pppp1ppp/4p3/8/3PP3/8/PPP2PPP/RNBQKBNR b KQkq -"
    cfen = escapeuri(ifen)
    addr = "https://explorer.lichess.ovh/masters?fen=" * cfen
    resp = HTTP.get(addr)
    str = String(resp.body)
    jobj = JSON.Parser.parse(str)
    moves = jobj["moves"]
    sans = map(m -> m["san"], moves)
    bs = map(m -> m["black"], moves)
    ws = map(m -> m["white"], moves)
    ds = map(m -> m["draws"], moves)
    ts = map((w,b,d)-> w+b+d, ws,bs,ds)
    bts = [(b,t) for (b,t) in zip(bs,ts)]
    function f(tup) 
        (b,t) = tup
        b>10
    end
    fbts = filter(((b,t),)->b>10, bts)
    ss = map(((b,t),)->b//t, fbts)
    (e,i) = findmax(ss)

end



end