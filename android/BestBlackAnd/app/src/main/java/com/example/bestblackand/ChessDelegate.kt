package com.example.bestblackand

interface ChessDelegate {
    fun piecAt(col:Int,row:Int):ChessPiece?
    fun replaceFen(fen:String)
    fun setBoard(fen:String)
    fun getBestMove():String
    fun getBestMoveFen():String
    fun getResps():List<String>
    fun getRespFen(id:Int):String
    fun doBack()
}