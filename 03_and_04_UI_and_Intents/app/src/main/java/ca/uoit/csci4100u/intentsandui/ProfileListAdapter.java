package ca.uoit.csci4100u.intentsandui;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

public class ProfileListAdapter extends ArrayAdapter<Profile> {
    private Context context;
    private List<Profile> data;

    public ProfileListAdapter(Context context, List<Profile> data) {
        super(context, 0, data);

        this.context = context;
        this.data = data;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        // potentially reuse the list item view
        View listItem = convertView;
        if (listItem == null) {
            listItem = LayoutInflater.from(context).inflate(R.layout.profile_list_view_item,
                                                            parent,
                                                            false);
        }

        // collect the data to be inserted
        Profile profile = data.get(position);

        // populate the UI
        TextView name = listItem.findViewById(R.id.labelName);
        name.setText(profile.getName());

        TextView phone = listItem.findViewById(R.id.labelPhone);
        phone.setText(profile.getPhone());

        TextView email = listItem.findViewById(R.id.labelEmail);
        email.setText(profile.getEmail());

        return listItem;
    }
}
