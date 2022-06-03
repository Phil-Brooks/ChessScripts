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

end