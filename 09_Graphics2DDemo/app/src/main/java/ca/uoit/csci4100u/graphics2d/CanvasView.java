package ca.uoit.csci4100u.graphics2d;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.os.Handler;

import java.io.IOException;
import java.io.InputStream;

public class CanvasView extends View {
    private Bitmap spriteSheet;
    private int row, col;

    final int SPRITE_WIDTH  = 64;
    final int SPRITE_HEIGHT = 64;

    final int SPEED = 30;

    private Handler handler;

    private Runnable animationThread = new Runnable() {
        @Override
        public void run() {
            // redraw
            invalidate();
        }
    };

    public CanvasView(Context context) {
        super(context);

        initializeAnimation();
    }

    public CanvasView(Context context, AttributeSet attribs) {
        super(context, attribs);

        initializeAnimation();
    }

    private void initializeAnimation() {
        row = 0;
        col = 0;

        // load the image into a bitmap
        spriteSheet = BitmapFactory.decodeResource(getResources(), R.drawable.explosion);

        // unscale the bitmap (Android scales bitmaps, based on screen density
        spriteSheet = Bitmap.createScaledBitmap(spriteSheet, SPRITE_WIDTH * 4, SPRITE_HEIGHT * 4, false);

        handler = new Handler();
    }

    private void drawAnimationFrame(Canvas canvas) {
        // create a brush
        Paint blackFill = new Paint();
        blackFill.setARGB(255, 0, 0, 0);
        blackFill.setStyle(Paint.Style.FILL);

        // determine the source and destination boundaries
        int left = col * SPRITE_WIDTH;
        int top = row * SPRITE_HEIGHT;
        Rect source = new Rect(left, top, left + SPRITE_WIDTH, top + SPRITE_HEIGHT);
        RectF dest = new RectF(200, 1200, 200 + SPRITE_WIDTH*2, 1200 + SPRITE_HEIGHT*2);

        // draw the current frame
        canvas.drawBitmap(spriteSheet, source, dest, null);
    }

    private void nextFrame() {
        // advance to the next column
        col++;

        // wrap to next row, if necessary
        if (col >= 4) {
            row++;
            col = 0;
        }

        // wrap up to top row, if necessary
        if (row >= 4) {
            row = 0;
        }
    }

    @Override
    protected void onDraw(Canvas canvas) {
        // fill background gray
        canvas.drawRGB(150, 150, 150);

        // draw in black, unfilled shapes
        Paint blackLine = new Paint();
        blackLine.setARGB(255, 0, 0, 0);
        blackLine.setStyle(Paint.Style.STROKE);

        // draw a black line
        canvas.drawLine(100, 550, 600, 800, blackLine);

        // draw in blue, unfilled shapes
        Paint blueLine = new Paint();
        blueLine.setARGB(255, 0, 0, 255);
        blueLine.setStyle(Paint.Style.STROKE);

        // draw a blue rectangle
        RectF bounds = new RectF(100, 800, 300, 950);
        canvas.drawRect(bounds, blueLine);

        // draw in green, filled shapes
        Paint greenFill = new Paint();
        greenFill.setARGB(255, 0, 255, 0);
        greenFill.setStyle(Paint.Style.FILL);

        // draw a green filled rectangle
        bounds = new RectF(400, 100, 500, 250);
        canvas.drawRect(bounds, greenFill);

        // draw in yellow, filled shapes
        Paint yellowFill = new Paint();
        yellowFill.setARGB(255, 255, 255, 0);
        yellowFill.setStyle(Paint.Style.FILL);

        // draw a yellow filled rounded rectangle
        bounds = new RectF(100, 400, 300, 450);
        canvas.drawRoundRect(bounds, 10f, 10f, yellowFill);

        // draw in cyan, filled shapes
        Paint cyanFill = new Paint();
        cyanFill.setARGB(255, 0, 255, 255);
        cyanFill.setStyle(Paint.Style.FILL);

        // draw a cyan filled circle
        canvas.drawCircle(500, 1000, 150, cyanFill);

        // draw in magenta, filled shapes
        Paint magentaFill = new Paint();
        magentaFill.setARGB(255, 255, 0, 255);
        magentaFill.setStyle(Paint.Style.FILL);

        // draw a magenta filled oval/ellipse
        bounds = new RectF(450, 400, 750, 450);
        canvas.drawOval(bounds, magentaFill);

        // draw in red, filled shapes
        Paint redFill = new Paint();
        redFill.setARGB(255, 255, 0, 0);
        redFill.setStyle(Paint.Style.FILL);

        // draw a red pie
        bounds = new RectF(650, 200, 820, 380);
        canvas.drawArc(bounds, 60, 290, true, redFill);

        // draw some black text
        Paint font = new Paint();
        font.setTextSize(72f);
        font.setARGB(255, 0, 0, 0);
        font.setStyle(Paint.Style.STROKE);
        canvas.drawText("2D Graphics Sample", 500, 600, font);

        // draw the next frame of our animation
        drawAnimationFrame(canvas);

        // delay before next frame
        handler.postDelayed(animationThread, SPEED);
        nextFrame();
    }

}
