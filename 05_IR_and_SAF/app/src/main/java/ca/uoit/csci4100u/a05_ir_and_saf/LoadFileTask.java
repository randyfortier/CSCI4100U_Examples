package ca.uoit.csci4100u.a05_ir_and_saf;

import android.content.Context;
import android.net.Uri;
import android.os.AsyncTask;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class LoadFileTask extends AsyncTask<Uri, Void, String> {
    private Exception exception = null;
    private Context context;
    private DataLoaded listener;

    public LoadFileTask(Context context) {
        this.context = context;
    }

    public void setDataLoadedHandler(DataLoaded handler) {
        this.listener = handler;
    }

    @Override
    protected String doInBackground(Uri... uri) {
        StringBuilder content = new StringBuilder();
        try {
            InputStream inRaw = context.getContentResolver().openInputStream(uri[0]);
            BufferedReader in = new BufferedReader(new InputStreamReader(inRaw));
            String line = null;
            while ((line = in.readLine()) != null) {
                content.append(line);
            }
            inRaw.close();
        } catch (IOException e) {
            this.exception = e;
            return null;
        }
        return content.toString();
    }

    @Override
    protected void onPostExecute(String data) {
        if (exception != null) {
            exception.printStackTrace();
            return;
        }

        // add the content to the UI
        listener.showContent(data);
    }
}
