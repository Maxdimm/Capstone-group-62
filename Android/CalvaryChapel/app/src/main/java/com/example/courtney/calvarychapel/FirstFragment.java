package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by Courtney on 2/4/17.
 */



public class FirstFragment extends Fragment {

    View myView;
    TextView txtJson;
    private static final String TAG_TITLE = "title";

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.first_layout, container, false);

        txtJson = (TextView) myView.findViewById(R.id.bulletinText);
     //   txtJson.setText("Hey there");

        new JSONTask().execute();

        return myView;
    }


    protected class JSONTask extends AsyncTask<Void, Void, JSONObject> {

        @Override
        protected JSONObject doInBackground(Void... params) {

            HttpURLConnection connection = null;
            BufferedReader reader = null;

            try {
                URL url = new URL("https://jsonplaceholder.typicode.com/todos/1");
                connection = (HttpURLConnection) url.openConnection();
                connection.connect();

                InputStream stream = connection.getInputStream();

                reader = new BufferedReader(new InputStreamReader(stream));

                StringBuffer buffer = new StringBuffer();
                String line = "";

                while ((line = reader.readLine()) != null) {
                    buffer.append(line + "\n");
                    Log.d("Response: ", "> " + line);
                }

                return new JSONObject(buffer.toString());

            } catch (Exception e) {
                Log.e("App", "JSONTask", e);
            } finally {
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }

            return null;
        }

        @Override
        protected void onPostExecute(JSONObject response) {

            if (response != null) {
                try {
                    txtJson.setText("Title: " + response.getString(TAG_TITLE));
                    Log.e("App", "Success: " + response.getString("yourJsonElement"));

                } catch (JSONException ex) {
                    Log.e("App", "Failure", ex);
                }
            }

        }

    }
}
