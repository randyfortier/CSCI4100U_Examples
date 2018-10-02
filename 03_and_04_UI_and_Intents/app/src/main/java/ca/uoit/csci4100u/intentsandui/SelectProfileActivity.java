package ca.uoit.csci4100u.intentsandui;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ListView;

import java.util.ArrayList;

public class SelectProfileActivity extends AppCompatActivity {

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
    }
}
