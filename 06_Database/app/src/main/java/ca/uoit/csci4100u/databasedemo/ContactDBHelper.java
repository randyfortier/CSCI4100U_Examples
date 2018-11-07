package ca.uoit.csci4100u.databasedemo;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

public class ContactDBHelper extends SQLiteOpenHelper {
    public static final int DATABASE_VERSION = 1;
    public static final String DATABASE_FILENAME = "contacts.db";
    public static final String TABLE_NAME = "contacts";

    // how to create the database
    public static final String CREATE_STATEMENT = "" +
            "CREATE TABLE " + TABLE_NAME + " (" +
            "  _id integer primary key autoincrement," +
            "  firstName text not null," +
            "  lastName text not null," +
            "  email text null," +
            "  phone text null" +
            ")";

    // how to destroy the database
    public static final String DROP_STATEMENT = "" +
            "DROP TABLE " + TABLE_NAME;

    public ContactDBHelper(Context context) {
        super(context, DATABASE_FILENAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CREATE_STATEMENT);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        if (oldVersion < newVersion) {
            // upgrade

        } else {
            // downgrade

        }

        db.execSQL(DROP_STATEMENT);
        db.execSQL(CREATE_STATEMENT);
    }

    public Contact createContact(String firstName,
                                 String lastName,
                                 String email,
                                 String phone) {

        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("firstName", firstName);
        values.put("lastName", lastName);
        values.put("email", email);
        values.put("phone", phone);

        long id = db.insert(TABLE_NAME, null, values);

        //  wrap everything up into an entity object
        Contact newContact = new Contact();
        newContact.setFirstName(firstName);
        newContact.setLastName(lastName);
        newContact.setEmail(email);
        newContact.setPhone(phone);
        newContact.setId(id);

        return newContact;
    }

    public Contact getContact(long id) {
        SQLiteDatabase db = this.getReadableDatabase();

        Contact contact = null;

        String[] columns = new String[] {
                "_id",
                "firstName",
                "lastName",
                "email",
                "phone"
        };

        String[] args = new String[] {
                "" + id
        };

        Cursor cursor = db.query(TABLE_NAME, columns,
                                "_id = ?", args,
                                "", "",
                                "");

        if (cursor.getCount() >= 1) {
            cursor.moveToFirst();

            String firstName = cursor.getString(1);
            String lastName = cursor.getString(2);
            String email = cursor.getString(3);
            String phone = cursor.getString(4);

            contact = new Contact();
            contact.setFirstName(firstName);
            contact.setLastName(lastName);
            contact.setEmail(email);
            contact.setPhone(phone);
            contact.setId(id);
        }

        return contact;
    }

    public List<Contact> getAllContacts() {
        SQLiteDatabase db = this.getReadableDatabase();

        String[] columns = new String[] {
                "_id",
                "firstName",
                "lastName",
                "email",
                "phone"
        };

        String[] args = new String[] {
        };

        Cursor cursor = db.query(TABLE_NAME, columns,
                "", args,
                "", "",
                "lastName");

        List<Contact> contacts = new ArrayList<>();

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            long id = cursor.getLong(0);
            String firstName = cursor.getString(1);
            String lastName = cursor.getString(2);
            String email = cursor.getString(3);
            String phone = cursor.getString(4);

            Contact contact = new Contact();
            contact.setFirstName(firstName);
            contact.setLastName(lastName);
            contact.setEmail(email);
            contact.setPhone(phone);
            contact.setId(id);

            contacts.add(contact);

            cursor.moveToNext();
        }

        return contacts;
    }

    public boolean updateContact(Contact contact) {
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("firstName", contact.getFirstName());
        values.put("lastName", contact.getLastName());
        values.put("email", contact.getEmail());
        values.put("phone", contact.getPhone());

        String[] args = new String[] {
                "" + contact.getId()
        };

        int numRowsAffected = db.update(TABLE_NAME, values,
                                        "_id = ?", args);

        return (numRowsAffected == 1);
    }

    public boolean deleteContact(long id) {
        SQLiteDatabase db = this.getWritableDatabase();

        String[] args = new String[] {
                "" + id
        };

        int numRowsAffected = db.delete(TABLE_NAME,
                                        "_id = ?", args);

        return (numRowsAffected == 1);
    }

    public void deleteAllContacts() {
        SQLiteDatabase db = this.getWritableDatabase();

        db.delete(TABLE_NAME, "", new String[] {});
    }
}
