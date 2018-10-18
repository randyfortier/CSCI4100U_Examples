package ca.uoit.csci4100u.a05_ir_and_saf;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

public class MainActivity extends AppCompatActivity {

    private String baseUrl = "http://services.aonaware.com/DictService/DictService.asmx/Define?word=";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void showDefinition(String definition) {
        EditText txtMeaning = (EditText)findViewById(R.id.txtMeaning);
        txtMeaning.setText(definition);
    }

    public void findMeaning(View view) {
        EditText txtName = (EditText)findViewById(R.id.txtName);
        String name = txtName.getText().toString();

        String url = baseUrl + name.toLowerCase();

        // download the web service response
        DownloadMeaningTask downloadTask = new DownloadMeaningTask();
        downloadTask.execute(url);
    }

    class DownloadMeaningTask extends AsyncTask<String, Void, String> {
        private Exception exception = null;

        @Override
        protected String doInBackground(String... params) {
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
