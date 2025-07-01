package com.example.demo.Activities.WhatToExpect.FactsAndFlash;

import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.viewpager.widget.ViewPager;

import com.example.demo.R;

public class YouBadyAndBodyActivity extends AppCompatActivity {

    ViewPager viewPager;
    SliderAdapter sliderAdapter;
    ImageView nextButton,backButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_you_bady_and_body);

        viewPager = findViewById(R.id.slider);
        nextButton = findViewById(R.id.next_button);
        backButton = findViewById(R.id.back_button);


        sliderAdapter = new SliderAdapter(this);
        viewPager.setAdapter(sliderAdapter);

        nextButton.setOnClickListener(v -> {
            int currentPosition = viewPager.getCurrentItem();
            if (currentPosition < sliderAdapter.getCount() - 1) {
                viewPager.setCurrentItem(currentPosition + 1);
            }
        });

        backButton.setOnClickListener(v -> {
            int currentPosition = viewPager.getCurrentItem();
            if (currentPosition < sliderAdapter.getCount() + 1) {
                viewPager.setCurrentItem(currentPosition - 1);
            }
        });
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

    }
}