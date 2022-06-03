package com.example.bestblackand

class ChessModel {
    var piecesBox = mutableSetOf<ChessPiece>()
    val fenStart = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -"
    val chessDict = ChessDict()
    var de = chessDict.getEntry(fenStart)
    var fens = mutableListOf<String>(fenStart)


    init{
        reset()
    }

    fun reset() {
        setBoard(fenStart)
        fens.clear()
        fens.add(fenStart)
        }

    fun piecAt(col:Int,row:Int):ChessPiece? {
        for (piece in piecesBox){
            if (col==piece.col && row==piece.row) return piece
        }
        return null
    }

    fun replaceFen(fen:String){
        fens.add(fen)
        setBoard(fen)
        de = chessDict.getEntry(fen)
    }

    fun setBoard(fen:String) {
        val bits = fen.split(" ")
        val bdstr:String = bits[0]
        val rows = bdstr.split("/")

        piecesBox.removeAll(piecesBox)
        for (row in 0..7){
            val rwstr = rows[7-row]
            var col =0
            for (ch in rwstr){
                when(ch){
                    'R' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.ROOK,R.drawable.wr))
                    'N' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.KNIGHT,R.drawable.wn))
                    'B' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.BISHOP,R.drawable.wb))
                    'Q' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.QUEEEN,R.drawable.wq))
                    'K' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.KING,R.drawable.wk))
                    'P' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.WHITE, ChessRank.PAWN,R.drawable.wp))
                    'r' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.ROOK,R.drawable.br))
                    'n' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.KNIGHT,R.drawable.bn))
                    'b' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.BISHOP,R.drawable.bb))
                    'q' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.QUEEEN,R.drawable.bq))
                    'k' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.KING,R.drawable.bk))
                    'p' -> piecesBox.add(ChessPiece(col,row, ChessPlayer.BLACK, ChessRank.PAWN,R.drawable.bp))
                    else -> {col += ch.digitToInt()-1}
                }
                col += 1
            }
        }
    }

    fun getBestMove():String {
        de?:return "NOT FOUND"
        return de!!.bestMove
    }

    fun getBestMoveFen():String {
        de?:return "NOT FOUND"
        return de!!.bestMoveFen
    }

    fun getResps():List<String> {
        de?:return emptyList()
        return de!!.resps
    }

    fun getRespFen(id:Int):String {
        de?:return "NOT FOUND"
        return de!!.respFens[id]
    }

    fun doBack(){
        if (fens.count()>1){
            fens.removeAt(fens.count()-1)
            val fen = fens[fens.count()-1]
            setBoard(fen)
            de = chessDict.getEntry(fen)
        }
    }

    override fun toString(): String {
        var desc = " \n"
        for (row in 7 downTo 0) {
            desc += "$row"
            for (col in 0..7) {
                val piece = piecAt(col,row)
                if(piece==null) {
                    desc += " ."
                } else{
                    val white = piece.player == ChessPlayer.WHITE
                    desc += " "
                    when(piece.rank){
                        ChessRank.KING -> desc += if (white) "k" else "K"
                        ChessRank.QUEEEN -> desc += if (white) "q" else "Q"
                        ChessRank.ROOK -> desc += if (white) "r" else "R"
                        ChessRank.BISHOP -> desc += if (white) "b" else "B"
                        ChessRank.KNIGHT -> desc += if (white) "n" else "N"
                        ChessRank.PAWN -> desc += if (white) "p" else "P"
                    }
                }
            }
            desc += "\n"
        }
        desc += "  0 1 2 3 4 5 6 7"
        return desc
    }
}