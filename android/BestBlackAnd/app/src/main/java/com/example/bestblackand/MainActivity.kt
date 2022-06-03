package com.example.bestblackand

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.*

const val TAG = "MainActivity"

class MainActivity : AppCompatActivity(), ChessDelegate {

    private var chessModel = ChessModel()
    private lateinit var chessView: ChessView
    private lateinit var bmButton: Button
    private lateinit var rsListView: ListView
    private lateinit var bkButton: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        chessView = findViewById<ChessView>(R.id.chess_view)
        chessView.chessDelegate = this
        bmButton = findViewById<Button>(R.id.best_button)
        bmButton.setText("Best Move - " + getBestMove())
        bmButton.setOnClickListener{
            showBestMove()
        }
        rsListView = findViewById<ListView>(R.id.listview)
        val adapter = ArrayAdapter(this,android.R.layout.simple_list_item_1,getResps())
        rsListView.adapter = adapter
        rsListView.onItemClickListener = AdapterView.OnItemClickListener { adapterView, view, position, id ->
            val resp = adapterView.getItemAtPosition(position) as String
            val rid = adapterView.getItemIdAtPosition(position)
            //Log.d(TAG,"click item $resp its position $rid")
            val nfen = getRespFen(rid.toInt())
            //Log.d(TAG, "nfen : $nfen")
            replaceFen(nfen)
            chessView.invalidate()
            bmButton.setText("Best Move - " + getBestMove())
            val nadapter = ArrayAdapter(this,android.R.layout.simple_list_item_1,getResps())
            rsListView.adapter = nadapter
            rsListView.invalidate()
        }
        bkButton = findViewById<Button>(R.id.back_button)
        bkButton.setOnClickListener{
            doBack()
            chessView.invalidate()
            bmButton.setText("Best Move - " + getBestMove())
            val nadapter = ArrayAdapter(this,android.R.layout.simple_list_item_1,getResps())
            rsListView.adapter = nadapter
            rsListView.invalidate()
        }

        }

    fun showBestMove() {
        val bmfen = getBestMoveFen()
        setBoard(bmfen)
    }

    override fun piecAt(col: Int, row: Int): ChessPiece? {
        return chessModel.piecAt(col,row)
    }

    override fun replaceFen(fen: String) {
        chessModel.replaceFen(fen)
    }

    override fun setBoard(fen: String) {
        chessModel.setBoard(fen)
        findViewById<ChessView>(R.id.chess_view).invalidate()
    }

    override fun getBestMove(): String {
        return chessModel.getBestMove()
    }

    override fun getBestMoveFen(): String {
        return chessModel.getBestMoveFen()
    }

    override fun getResps(): List<String> {
        return chessModel.getResps()
    }

    override fun getRespFen(id: Int): String {
        return chessModel.getRespFen(id)
    }

    override fun doBack() {
        chessModel.doBack()
    }

}