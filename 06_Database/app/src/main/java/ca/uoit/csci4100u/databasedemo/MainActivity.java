package ca.uoit.csci4100u.databasedemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.List;

public class MainActivity extends AppCompatActivity {
    private List<Contact> contacts;
    private int contactIndex;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView results = (TextView)findViewById(R.id.lblResult);

        ContactDBHelper dbHelper = new ContactDBHelper(this);

        // test the model
        dbHelper.deleteAllContacts();

        Contact bsmith = dbHelper.createContact("Bob",
                                                "Smith",
                "bsmith@uoit.ca",
                "555-111-1111");
        Contact jdoe = dbHelper.createContact("Jane",
                "Doe",
                "jdoe@gmail.com",
                "555-222-2222");
        Contact deleteme = dbHelper.createContact("Tobey",
                "Deleted",
                "nosuchaddress@email.com",
                "000-000-0000");

        // test deletion
        long idToBeDeleted = deleteme.getId();
        dbHelper.deleteContact(idToBeDeleted);

        // test update
        jdoe.setPhone("905-721-8668");
        jdoe.setEmail("jdoe@uoit.ca");
        dbHelper.updateContact(jdoe);

        // show the current contact
        this.contacts = dbHelper.getAllContacts();
        this.contactIndex = -1;

        Log.i("06_Databse", "Retrieved all contacts");

        nextContact();
    }

    public void previous(View view) {
        previousContact();
    }

    public void next(View view) {
        nextContact();
    }

    private void nextContact() {
        this.contactIndex++;

        if (this.contactIndex >= this.contacts.size()) {
            this.contactIndex = 0;
        }

        displayContact(this.contacts.get(this.contactIndex));
    }

    private void previousContact() {
        this.contactIndex--;

        if (this.contactIndex < 0) {
            this.contactIndex = this.contacts.size() - 1;
        }

        displayContact(this.contacts.get(this.contactIndex));
    }

    private void displayContact(Contact contact) {
        TextView txtFirstName = findViewById(R.id.txtFirstName);
        TextView txtLastName = findViewById(R.id.txtLastName);
        TextView txtEMail = findViewById(R.id.txtEMail);
        TextView txtPhone = findViewById(R.id.txtPhone);

        txtFirstName.setText(contact.getFirstName());
        txtLastName.setText(contact.getLastName());
        txtEMail.setText(contact.getEmail());
        txtPhone.setText(contact.getPhone());
    }
}
