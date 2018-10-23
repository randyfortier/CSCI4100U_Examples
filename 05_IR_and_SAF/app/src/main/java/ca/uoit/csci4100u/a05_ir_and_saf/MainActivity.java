package ca.uoit.csci4100u.a05_ir_and_saf;

import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import org.json.JSONArray;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

public class MainActivity extends AppCompatActivity
                          implements DataLoaded {

    public static int OPEN_TEXT_DOC_REQUEST = 1;

    //private String baseUrl = "http://services.aonaware.com/DictService/DictService.asmx/Define?word=";
    private String baseUrl = "http://api.openweathermap.org/data/2.5/weather?lat=52&lon=81&units=metric&APPID=d469c49ee247c7dff53bfcad6a7585b4";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void showDefinition(String definition) {
        EditText txtMeaning = (EditText)findViewById(R.id.txtMeaning);
        txtMeaning.setText(definition);
    }

    public void showContent(String content) {
        EditText txtContent = (EditText)findViewById(R.id.txtContent);
        txtContent.setText(content);
    }

    public void findMeaning(View view) {
        EditText txtName = (EditText)findViewById(R.id.txtName);
        String name = txtName.getText().toString();

        String url = baseUrl + name.toLowerCase();

        // download the web service response
        DownloadMeaningTask downloadTask = new DownloadMeaningTask();
        downloadTask.execute(url);
    }

    public void loadData(View view) {
        Intent openTextDoc = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        openTextDoc.addCategory(Intent.CATEGORY_OPENABLE);
        openTextDoc.setType("text/*");
        startActivityForResult(openTextDoc, OPEN_TEXT_DOC_REQUEST);
    }

    @Override
    public void onActivityResult(int requestCode,
                                 int responseCode,
                                 Intent resultIntent) {
        if ((requestCode == OPEN_TEXT_DOC_REQUEST) &&
                (responseCode == RESULT_OK) &&
                (resultIntent != null)) {

            Uri uri = resultIntent.getData();

            LoadFileTask loadFileTask = new LoadFileTask(this);
            loadFileTask.setDataLoadedHandler(this);
            loadFileTask.execute(uri);
        }
    }

    class DownloadMeaningTask extends AsyncTask<String, Void, String> {
        private Exception exception = null;

        /**
         * Accessing JSON-based APIs
         *
         * Example web service:  http://api.openweathermap.org/data/2.5/weather?lat=52&lon=81&units=metric&APPID=YOUR KEY GOES HERE
         *
         * The format returned by this service is called JSON.  You can find out more about
         * JSON at http://guide.couchdb.org/draft/json.html.
         *
         */

        @Override
        protected String doInBackground(String... params) {
            try {
                // test only, you would read from the URL as in the examples
                String jsonData = "{\"coord\":{\"lon\":81,\"lat\":52},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10n\"}],\"base\":\"stations\",\"main\":{\"temp\":3.98,\"pressure\":997.22,\"humidity\":75,\"temp_min\":3.98,\"temp_max\":3.98,\"sea_level\":1027.87,\"grnd_level\":997.22},\"wind\":{\"speed\":9.68,\"deg\":198.007},\"rain\":{\"3h\":0.3075},\"clouds\":{\"all\":92},\"dt\":1539877940,\"sys\":{\"message\":0.0033,\"country\":\"RU\",\"sunrise\":1539824785,\"sunset\":1539862490},\"id\":1492811,\"name\":\"Selivërstovo\",\"cod\":200}";

                JSONObject results = new JSONObject(jsonData);
                String weatherShort = results.getJSONArray("weather").getJSONObject(0).getString("main");
                return weatherShort;
                // if the data is in an array, instead of a dictionary
            /*
            JSONArray arr = results.getJSONArray("jokes");
            for (int i = 0; i < arr.length(); i++) {
                String jokeSetup = arr.getJSONObject(i).getString("joke_setup");
            }
            */
            } catch(Exception e) {
                this.exception = e;
                e.printStackTrace();
            }
            /*
            try {
                URL url = new URL(params[0]);

                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder docBuilder = dbFactory.newDocumentBuilder();
                Document document = docBuilder.parse(url.openStream());
                document.getDocumentElement().normalize();

                NodeList definitions = document.getElementsByTagName("Definition");
                if ((definitions.getLength() > 0) &&
                        (definitions.item(0).getNodeType() == Node.ELEMENT_NODE)) {
                    Element defElement = (Element)definitions.item(0);

                    NodeList wordDefNodes = defElement.getElementsByTagName("WordDefinition");
                    String definitionResult = "";
                    for (int i = 0; i < wordDefNodes.getLength(); i++) {
                        definitionResult += wordDefNodes.item(i).getTextContent() + "\n";
                    }
                    return definitionResult;
                }
            } catch (Exception e) {
                this.exception = e;
                e.printStackTrace();
            }
            */
            return null;
        }

        @Override
        protected void onPostExecute(String definition) {
            if (exception != null) {
                return;
            }

            showDefinition(definition);
        }
    }
}
