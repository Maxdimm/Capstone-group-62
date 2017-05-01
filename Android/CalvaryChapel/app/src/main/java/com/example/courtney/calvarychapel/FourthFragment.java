package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;

/**
 * Created by Courtney on 2/4/17.
 * Messages Page
 */

public class FourthFragment extends Fragment {

    View myView;
    WebView myWebView;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.fourth_layout, container, false);

        String videoLink = "<html><iframe id=\"ls_embed_1493363421\" src=\"https://livestream.com/accounts/18343788/events/7279945/videos/154327352/player?width=960&height=540&enableInfo=false&defaultDrawer=&autoPlay=true&mute=false\" width=\"960\" height=\"540\" frameborder=\"0\" scrolling=\"no\" allowfullscreen> </iframe></html>";

        myWebView = (WebView) myView.findViewById(R.id.messagesView);

        WebSettings webSettings = myWebView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        myWebView.getSettings().setLoadWithOverviewMode(true);
        myWebView.getSettings().setUseWideViewPort(true);
        myWebView.getSettings().setBuiltInZoomControls(true);
        myWebView.loadData(videoLink, "text/html", "utf-8");

        return myView;
    }
}


