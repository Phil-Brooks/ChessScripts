package com.example.bestwhiteand

class ChessDict {
    val lns = ChessData1().lines + ChessData2().lines + ChessData3().lines + ChessData4().lines

    fun convFen(ln:String):String{
        val bits = ln.split("|")
        return bits[0]
    }

    fun convEntry(ln:String):ChessDictEnt{
        val bits0 = ln.split("|")
        val destr = bits0[1]
        val bits1 = destr.split(";")
        val bits10 = bits1[0].split(":")
        val bm = bits10[0]
        val bmfen = bits10[1]
        val resps = bits1[1].split(",")
        val respFens = bits1[2].split(",")
        return ChessDictEnt(bm,bmfen,resps, respFens)
    }

    val dct = lns.map{convFen(it) to convEntry(it)}.toMap()

    fun getEntry(fen:String):ChessDictEnt?{
        return dct[fen]
    }
}