package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Courtney on 2/4/17.
 */

public class SecondFragment extends Fragment {


    ListView listView;
    ListViewAdapter adapter;
    ArrayList<HashMap<String,String>> arrayList;
    static String NAME = "event_name";
    static String DATE = "date";
    private static final String URL = "https://calvarycorvallis.ccbchurch.com/api.php?srv=public_calendar_listing&date_start=2017-03-05";
    View myView;
    private static final String PASSWORD = "bonnc123";
    private static final String USERNAME = "bonncosu";

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.second_layout, container, false);

        new DownloadXML().execute(URL);

        return myView;
    }

    protected class DownloadXML extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls) {
            try {
                return loadXmlFromNetwork(urls[0]);
            } catch (IOException e) {
                return e.toString();
            } catch (XmlPullParserException e) {
                return e.toString();
            }
        }

        @Override
        protected void onPostExecute(String result) {
            listView = (ListView) myView.findViewById(R.id.listview);
          //  adapter = new ListViewAdapter(getActivity(), arrayList);
           // listView.setAdapter(adapter);

            TextView text = (TextView) myView.findViewById(R.id.textView3);
            text.setText(result);
            System.out.println(result);
        }

    }

    private String loadXmlFromNetwork(String urlString) throws XmlPullParserException, IOException {
        InputStream stream = null;
        XMLParser xmlParser = new XMLParser();
        List<XMLParser.Entry> entries = null;
        String event_name = null;
        String date = null;
        Calendar rightNow = Calendar.getInstance();
        DateFormat formatter = new SimpleDateFormat("MMM dd h:mmaa");

        StringBuilder htmlString = new StringBuilder();
       // htmlString.append("<h3>" + getResources().getString(R.string.page_title) + "</h3>");
       // htmlString.append("<em>" + getResources().getString(R.string.updated) + " " + formatter.format(rightNow.getTime()) + "</em>");

        try {
            stream = downloadUrl(urlString);
            entries = xmlParser.parse(stream);
        } finally {
            if (stream != null) {
                stream.close();
            }
         }

         for (XMLParser.Entry entry : entries) {
             htmlString.append("<p>" + entry.event_name + entry.date + "</p>");
         }

         return htmlString.toString();
    }

    private InputStream downloadUrl(String urlString) throws IOException {
        String authorization = buildAuthString(USERNAME, PASSWORD);
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Authorization", authorization);
        conn.setReadTimeout(10000);
        conn.setConnectTimeout(15000);
        conn.setRequestMethod("GET");
        conn.setDoInput(true);
        conn.connect();
        return conn.getInputStream();
    }

    private String buildAuthString(String username, String password) {
        String login = username+ ":" + password;
        return "Basic " + new String(Base64.encode(login.getBytes(), Base64.DEFAULT));
    }
}
