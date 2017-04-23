package com.example.courtney.calvarychapel;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Courtney on 4/13/17.
 */

public class ListViewAdapter extends BaseAdapter {

    Context context;
    LayoutInflater inflater;
    ArrayList<HashMap<String, String>> data;
    HashMap<String, String> resultp = new HashMap<String, String>();

    public ListViewAdapter(Context context, ArrayList<HashMap<String, String>> arraylist) {
        this.context = context;
        data = arraylist;
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    public View getView(final int position, View convertView, ViewGroup parent) {
        TextView eventName;
        TextView eventDate;

        inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View itemView = inflater.inflate(R.layout.listview_item, parent, false);

        resultp = data.get(position);

        eventName = (TextView) itemView.findViewById(R.id.eventname);
        eventDate = (TextView) itemView.findViewById(R.id.eventdate);

        eventName.setText(resultp.get(SecondFragment.NAME));
        eventDate.setText((resultp.get(SecondFragment.DATE)));

        itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resultp = data.get(position);
                Intent intent = new Intent(context, SingleItemView.class);
                intent.putExtra("eventname", resultp.get(SecondFragment.NAME));
                intent.putExtra("eventdate", resultp.get(SecondFragment.DATE));
                context.startActivity(intent);
            }
        });

        return itemView;
    }

}
