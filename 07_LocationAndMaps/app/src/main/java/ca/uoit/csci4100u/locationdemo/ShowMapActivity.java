package ca.uoit.csci4100u.locationdemo;

import android.content.Intent;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class ShowMapActivity extends FragmentActivity implements OnMapReadyCallback {

    private GoogleMap map;

    double latitude;
    double longitude;
    String locationName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_map);

        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

        // get the search data
        Intent callingIntent = getIntent();
        latitude = callingIntent.getDoubleExtra("latitude", 0.0);
        longitude = callingIntent.getDoubleExtra("longitude", 0.0);
        locationName = callingIntent.getStringExtra("locationName");

        setupMapIfNeeded();
    }

    private void setupMapIfNeeded() {
        if (map == null) {
            SupportMapFragment fragment = ((SupportMapFragment)getSupportFragmentManager().findFragmentById(R.id.map));
            fragment.getMapAsync(new OnMapReadyCallback() {
                @Override
                public void onMapReady(GoogleMap googleMap) {
                    map = googleMap;
                    if (map != null) {
                        showMapLocation();
                    }
                }
            });

        }
    }

    private void showMapLocation() {
        LatLng position = new LatLng(latitude, longitude);

        // marker
        map.addMarker(new MarkerOptions().position(position).title(locationName));

        // centre camera
        map.animateCamera(CameraUpdateFactory.newLatLng(position));

        // configuration
        map.setTrafficEnabled(true);
        map.setBuildingsEnabled(true);
        map.setMapType(GoogleMap.MAP_TYPE_SATELLITE);

        // controls
        map.getUiSettings().setZoomControlsEnabled(true);
        map.getUiSettings().setZoomGesturesEnabled(true);
    }

    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        map = googleMap;

        // Add a marker in Sydney and move the camera
        LatLng sydney = new LatLng(-34, 151);
        map.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));
        map.moveCamera(CameraUpdateFactory.newLatLng(sydney));
    }
}
