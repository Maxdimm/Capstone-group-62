package com.example.courtney.calvarychapel;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

/**
 * Created by Courtney on 4/13/17.
 */

public class SingleItemView extends Activity {
    String eventname;
    String eventdate;
    String position;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.singleitemview);

        Intent i = getIntent();

        eventname = i.getStringExtra("eventname");
        eventdate = i.getStringExtra("eventdate");

        TextView txtName = (TextView) findViewById(R.id.eventname);
        TextView txtDate = (TextView) findViewById(R.id.eventdate);

        txtName.setText(eventname);
        txtDate.setText(eventdate);
    }
}
