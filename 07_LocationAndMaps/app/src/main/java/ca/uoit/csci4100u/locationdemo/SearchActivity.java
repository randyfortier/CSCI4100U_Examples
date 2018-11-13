package ca.uoit.csci4100u.locationdemo;

import android.location.Location;
import android.location.LocationListener;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class SearchActivity extends AppCompatActivity
                            implements LocationListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);
    }

    public void search(View source) {
        EditText txtLocation = findViewById(R.id.txtLocation);
        String location = txtLocation.getText().toString();

        // show the results on a map
        // TODO
    }

    private void showLocationName(Location location) {
        Log.d("LocationDemo", "showing location: " + location);

        // TODO: geocode to get the name, display the name
    }

    public void onLocationChanged(Location location) {
        showLocationName(location);
    }

    public void onProviderEnabled(String provider) {
        Log.d("LocationDemo", "Provider enabled: " + provider);
    }

    public void onProviderDisabled(String provider) {
        Log.d("LocationDemo", "Provider disabled: " + provider);
    }

    public void onStatusChanged(String provider, int status, Bundle extras) {
        Log.d("LocationDemo", "Provider status changed: " + provider);
    }
}
