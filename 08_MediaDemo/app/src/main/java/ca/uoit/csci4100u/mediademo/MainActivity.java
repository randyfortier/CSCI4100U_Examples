package ca.uoit.csci4100u.mediademo;

import android.content.res.AssetFileDescriptor;
import android.content.res.Resources;
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import java.io.IOException;

public class MainActivity extends AppCompatActivity
                          implements SurfaceHolder.Callback {

    public static final String VIDEO_URL = "https://archive.org/download/WildlifeSampleVideo/Wildlife.mp4";

    private SoundPool soundPool;
    private int plopSoundId;
    private Resources resources;
    private MediaPlayer musicMediaPlayer;
    private MediaPlayer videoPlayer;
    private SurfaceView surfaceView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        surfaceView = findViewById(R.id.surfaceView);
        surfaceView.getHolder().addCallback(this);

        initializeAudio();
        initializeVideo();
    }

    private void initializeAudio() {
        // create a sound pool for playing sound effects
        SoundPool.Builder spBuilder = new SoundPool.Builder();
        spBuilder.setMaxStreams(20);
        soundPool = spBuilder.build();

        // load sound effects
        resources = getResources();
        AssetFileDescriptor plopFd = resources.openRawResourceFd(R.raw.plop);
        plopSoundId = soundPool.load(plopFd, 1);

        // create a media player for the music
        musicMediaPlayer = new MediaPlayer();

        // load the music
        AssetFileDescriptor backgroundSongFd = resources.openRawResourceFd(R.raw.bensound_summer);
        try {
            musicMediaPlayer.setDataSource(
                    backgroundSongFd.getFileDescriptor(),
                    backgroundSongFd.getStartOffset(),
                    backgroundSongFd.getLength());

            musicMediaPlayer.prepare(); // synchronous
            musicMediaPlayer.setLooping(true);
            musicMediaPlayer.start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void initializeVideo() {
        videoPlayer = new MediaPlayer();

        try {
            videoPlayer.setDataSource(VIDEO_URL);
            videoPlayer.setScreenOnWhilePlaying(true);
            videoPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mediaPlayer) {
                    int width = mediaPlayer.getVideoWidth();
                    int height = mediaPlayer.getVideoHeight();

                    if (width > 0 && height > 0) {
                        surfaceView.getHolder().setFixedSize(width, height);
                    }

                    mediaPlayer.start();
                }
            });
            videoPlayer.prepareAsync();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        float x = e.getX();
        float y = e.getY();

        if (e.getAction() == MotionEvent.ACTION_DOWN) {
            soundPool.play(plopSoundId,
                    1.0f,
                    1.0f,
                    0,
                    0,
                    1.0f);
            Log.i("MediaDemo", "Plop sound effect!");
            return true;
        }

        return false;
    }

    @Override
    public void onPause() {
        super.onPause();
        musicMediaPlayer.pause();
    }

    @Override
    public void onResume() {
        super.onResume();
        musicMediaPlayer.start();
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        videoPlayer.setDisplay(holder);
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {

    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {

    }
}
