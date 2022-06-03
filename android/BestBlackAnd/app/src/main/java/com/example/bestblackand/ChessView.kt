package com.example.bestblackand

import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.view.View
import kotlin.math.min

class ChessView(context: Context?, attrs: AttributeSet?) : View(context, attrs) {
    private val scaleFactor = .8f
    private var originX=20f
    private var originY=50f
    private var cellSide=85f
    private val lightColor = Color.parseColor("#EEEEEEEE")
    private val darkColor = Color.parseColor("#BBBBBBBB")
    private val imgResIDs = setOf(
        R.drawable.bp,
        R.drawable.bn,
        R.drawable.bb,
        R.drawable.br,
        R.drawable.bq,
        R.drawable.bk,
        R.drawable.wp,
        R.drawable.wn,
        R.drawable.wb,
        R.drawable.wr,
        R.drawable.wq,
        R.drawable.wk,
    )
    private val bitmaps = mutableMapOf<Int,Bitmap>()
    private val paint = Paint()

    var chessDelegate: ChessDelegate? = null

    init{
        loadBitmaps()
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
        val smaller = min(widthMeasureSpec,heightMeasureSpec)
        //setMeasuredDimension(smaller,smaller)
        setMeasuredDimension(smaller, 600)
    }

    override fun onDraw(canvas: Canvas?) {
        canvas?:return
        val chessBoardSide = min(width, height) * scaleFactor
        cellSide = chessBoardSide/8f
        originX = (width -chessBoardSide)/2f
        //originY = (canvas.height -chessBoardSide)/2f
        drawChessBoard(canvas)
        drawPieces(canvas)
    }

    private fun drawPieces(canvas: Canvas){
        for (row in 0..7) {
            for (col in 0..7){
                chessDelegate?.piecAt(7-col,7-row)?.let { drawPieceAt(canvas,col,row,it.resID) }
            }
        }
     }

    private fun drawPieceAt(canvas: Canvas,col:Int,row:Int,resID:Int){
        val bitmap = bitmaps[resID]!!
        canvas.drawBitmap(bitmap, null,RectF(originX+col*cellSide,originY+(7-row)*cellSide,originX+(col+1)*cellSide,originY+(8-row)*cellSide),paint)
    }

    private fun loadBitmaps(){
        imgResIDs.forEach {
            bitmaps[it] = BitmapFactory.decodeResource(resources, it)
        }
    }

    private fun drawChessBoard(canvas: Canvas){
        for (row in 0..7) {
            for (col in 0..7) {
                drawSquare(canvas,col,row,(col+row)%2==1)
            }
        }
    }

    private fun drawSquare(canvas: Canvas,col:Int,row:Int,isDark:Boolean){
        paint.color = if (isDark) darkColor else lightColor
        canvas.drawRect(
            originX + col * cellSide,
            originY + row * cellSide,
            originX + (col + 1) * cellSide,
            originY + (row + 1) * cellSide,
            paint
        )

    }
}