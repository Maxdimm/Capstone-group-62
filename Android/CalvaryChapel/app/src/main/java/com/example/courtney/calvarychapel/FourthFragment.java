package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Courtney on 2/4/17.
 * Events Page
 */

public class FourthFragment extends Fragment {

    View myView;
    ListView listView;
    ListViewAdapter adapter;
    ArrayList<HashMap<String,String>> arrayList;
    static String NAME = "event_name";
    static String DATE = "date";

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.fourth_layout, container, false);

       // new DownloadXML().execute();

        return myView;
    }

    protected class DownloadXML extends AsyncTask<Void, Void, Void> {
        @Override
        protected Void doInBackground(Void... params) {
            //code here

            return null;
        }

        @Override
        protected void onPostExecute(Void args) {
            listView = (ListView) myView.findViewById(R.id.listview);
            adapter = new ListViewAdapter(getActivity(), arrayList);
            listView.setAdapter(adapter);
        }

    }
}


