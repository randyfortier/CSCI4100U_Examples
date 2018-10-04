package ca.uoit.csci4100u.intentsandui;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

public class SelectProfileActivity extends AppCompatActivity
                                   implements AdapterView.OnItemClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_profile);

        // create some dummy data
        ArrayList<Profile> profiles = new ArrayList<>();
        profiles.add(new Profile("Jack Skellington", "905-111-1111", "skele@northpole.net"));
        profiles.add(new Profile("Freddie Kruger", "905-222-2222", "skele@northpole.net"));
        profiles.add(new Profile("Slender Man", "905-333-3333", "skele@northpole.net"));
        profiles.add(new Profile("Lestat de Lioncourt", "905-444-4444", "skele@northpole.net"));
        profiles.add(new Profile("Michael Meyers", "905-555-5555", "skele@northpole.net"));

        // populate the list view
        ListView profileList = (ListView)findViewById(R.id.listProfiles);
        ProfileListAdapter profileAdapter = new ProfileListAdapter(this, profiles);
        profileList.setAdapter(profileAdapter);

        // add this activity as an item click listener
        profileList.setOnItemClickListener(this);

        Intent callingIntent = getIntent();
        String message = callingIntent.getStringExtra("message");
    }

    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Profile profile = (Profile)parent.getItemAtPosition(position);
        String selectedName = profile.getName();

        Log.i("IntentsAndUI", "User selected name: " + selectedName);

        Toast.makeText(parent.getContext(),
                       "User selected name: " + selectedName,
                       Toast.LENGTH_SHORT).show();

        Intent resultIntent = new Intent(Intent.ACTION_PICK);
        resultIntent.putExtra("profileName", selectedName);
        setResult(RESULT_OK, resultIntent);
        finish();
    }
}
