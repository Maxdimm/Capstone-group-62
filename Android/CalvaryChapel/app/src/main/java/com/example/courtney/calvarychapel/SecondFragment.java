package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Courtney on 2/4/17.
 * Tutorial for XML Parsing: http://www.androidbegin.com/tutorial/android-xml-parse-images-and-texts-tutorial/
 */

public class SecondFragment extends Fragment {


    ListView listView;
    ListViewAdapter adapter;
    ArrayList<HashMap<String,String>> arrayList;
    static String NAME = "event_name";
    static String DATE = "date";
    private static String timeStamp = new SimpleDateFormat("yyyy.MM.dd").format(new Date());
    private static final String URL = "https://calvarycorvallis.ccbchurch.com/api.php?srv=public_calendar_listing&date_start=2017-03-05";
  //  private static final String URL = "https://calvarycorvallis.ccbchurch.com/api.php?srv=public_calendar_listing&date_start=" + timeStamp;
    View myView;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.second_layout, container, false);

        System.out.println(timeStamp);
        new DownloadXML().execute();

        return myView;
    }


    protected class DownloadXML extends AsyncTask<Void, Void, Void> {
        @Override
        protected Void doInBackground(Void... params) {
            arrayList = new ArrayList<HashMap<String, String>>();

            XMLParser parser = new XMLParser();
            String xml = parser.getXmlFromUrl(URL);
            Document doc = parser.getDomElement(xml);

            try {
                NodeList nl = doc.getElementsByTagName("item");
                for (int i = 0; i < nl.getLength(); i++) {
                    HashMap<String, String> map = new HashMap<String, String>();
                    Element e = (Element) nl.item(i);
                    map.put(NAME, parser.getValue(e, NAME));
                    map.put(DATE, parser.getValue(e, DATE));
                    arrayList.add(map);
                }
            } catch (Exception e) {
                Log.e("Error: ", e.getMessage());
                e.printStackTrace();
            }

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
