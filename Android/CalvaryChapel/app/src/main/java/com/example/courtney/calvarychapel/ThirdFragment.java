package com.example.courtney.calvarychapel;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * Created by Courtney on 2/4/17.
 */

public class ThirdFragment extends Fragment {

    View myView;
    WebView myWebView;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        myView = inflater.inflate(R.layout.third_layout, container, false);


        myWebView = (WebView) myView.findViewById(R.id.donationWebView);

        WebSettings webSettings = myWebView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        myWebView.setWebViewClient(new WebViewClient() {
        @Override
                public void onPageFinished(WebView view, String url) {
            myWebView.loadUrl("javascript:(function() { " + "document.getElementsByClassName('site-header')[0].style.display='none'; " + "document.getElementsByClassName('footer-widgets')[0].style.display='none'; " + "document.getElementsByClassName('content')[0].style.display='none'; " + "})()");
            myWebView.setVisibility(View.VISIBLE);
            myWebView.getSettings().setLoadWithOverviewMode(true);
            myWebView.getSettings().setUseWideViewPort(true);
        }
        });

        myWebView.setVisibility(View.GONE);
        myWebView.loadUrl("https://www.calvarycorvallis.org/give/");
        return myView;
    }
}
