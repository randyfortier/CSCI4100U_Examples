package ca.uoit.csci4100u.locationdemo;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

public class SearchActivity extends AppCompatActivity
                            implements LocationListener {

    private LocationManager locationManager;
    private String locationProvider;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        setupLocationServices();
    }

    private void setupLocationServices() {
        requestLocationPermissions();

        locationProvider = LocationManager.GPS_PROVIDER;

        locationManager = (LocationManager)getSystemService(LOCATION_SERVICE);
        if (!locationManager.isProviderEnabled(locationProvider)) {
            String settings = Settings.ACTION_LOCATION_SOURCE_SETTINGS;
            Intent enableGPS = new Intent(settings);
            startActivity(enableGPS);
        } else {
            if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                    == PackageManager.PERMISSION_GRANTED) {
                updateLocation();
            }
        }
    }

    public static final int PERMISSION_REQUEST_LOCATION = 410001;

    private void requestLocationPermissions() {
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {
            // no location permissions given yet

            if (shouldShowRequestPermissionRationale(Manifest.permission.ACCESS_FINE_LOCATION)) {
                // TODO: explain to the user why we need it
            }

            String[] perms = new String[] {
                    Manifest.permission.ACCESS_FINE_LOCATION
            };
            requestPermissions(perms, PERMISSION_REQUEST_LOCATION);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String[] perms,
                                           int[] results) {
        boolean granted = true;

        for (int i = 0; i < results.length; i++) {
            if (results[i] != PackageManager.PERMISSION_GRANTED) {
                granted = false;
            }
        }

        if (granted) {
            updateLocation();
        } else {
            // TODO: Tell the user of any features that will be disabled
        }
    }

    private void updateLocation() {
        Location current = locationManager.getLastKnownLocation(locationProvider);
        showLocationName(current);

        // just to test this ongoing location functionality
        locationManager.requestLocationUpdates(locationProvider, 5000, 10, this);
    }

    public void search(View source) {
        EditText txtLocation = findViewById(R.id.txtLocation);
        String locationText = txtLocation.getText().toString();

        // show the results on a map
        Address address = geocodeForwardLookup(locationText);

        Intent showMap = new Intent(SearchActivity.this, ShowMapActivity.class);
        showMap.putExtra("latitude", address.getLatitude());
        showMap.putExtra("longitude", address.getLongitude());
        showMap.putExtra("locationName", address.getFeatureName());
        startActivity(showMap);
    }

    private String geocodeReverseLookup(Location location) {
        String locationName = "";
        if (Geocoder.isPresent()) {
            Geocoder geocoder = new Geocoder(this, Locale.getDefault());

            try {
                List<Address> results = geocoder.getFromLocation(location.getLatitude(),
                        location.getLongitude(),
                        1);

                if (results.size() > 0) {
                    Address match = results.get(0);
                    String address = match.getAddressLine(0);
                    locationName = address; //match.getFeatureName();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return locationName;
    }

    private Address geocodeForwardLookup(String location) {
        if (Geocoder.isPresent()) {
            Geocoder geocoder = new Geocoder(this, Locale.getDefault());

            try {
                List<Address> results = geocoder.getFromLocationName(location,1);

                if (results.size() > 0) {
                    return results.get(0);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private void showLocationName(Location location) {
        if (location == null) {
            return;
        }

        Log.d("LocationDemo", "showing location: " + location);

        // geocode to get the name, display the name
        String locationName = geocodeReverseLookup(location);

        EditText txtLocation = findViewById(R.id.txtLocation);
        txtLocation.setText(locationName);
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
