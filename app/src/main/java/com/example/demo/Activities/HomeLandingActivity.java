package com.example.demo.Activities;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.Activities.DailyTales.TrakerViewActivity;
import com.example.demo.Activities.WhatToExpect.FactsAndFlash.YouBadyAndBodyActivity;
import com.example.demo.Activities.WhatToExpect.WeekLandingPageActivity;
import com.example.demo.R;

public class HomeLandingActivity extends AppCompatActivity {

    ImageView dailyTales, whatToExpect;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_home_landing);

        dailyTales = findViewById(R.id.dailyTales);
        whatToExpect = findViewById(R.id.whatToExpect);

        dailyTales.setOnClickListener(v -> {
            startActivity(new Intent(HomeLandingActivity.this, TrakerViewActivity.class));
        });

        whatToExpect.setOnClickListener(v -> {
            startActivity(new Intent(HomeLandingActivity.this, WeekLandingPageActivity.class));
        });

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}