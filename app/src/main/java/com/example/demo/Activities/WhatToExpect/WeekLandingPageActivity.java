package com.example.demo.Activities.WhatToExpect;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.RelativeLayout;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.Activities.WhatToExpect.FactsAndFlash.YouBadyAndBodyActivity;
import com.example.demo.R;

public class WeekLandingPageActivity extends AppCompatActivity {

    RelativeLayout factsAndFlash,tipsOfTheWeek,EssentialTesting,setUpForTheBaby,mealsAndDiet;
    ImageButton foreword_arrow;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_week_landing_page);

        foreword_arrow=findViewById(R.id.foreword_arrow);
        factsAndFlash=findViewById(R.id.factsAndFlash);
        tipsOfTheWeek=findViewById(R.id.tipsOfTheWeek);
        EssentialTesting=findViewById(R.id.EssentialTesting);
        setUpForTheBaby=findViewById(R.id.setUpForTheBaby);
        mealsAndDiet=findViewById(R.id.mealsAndDiet);

        factsAndFlash.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(WeekLandingPageActivity.this, YouBadyAndBodyActivity.class));
            }
        });
        tipsOfTheWeek.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(WeekLandingPageActivity.this, TipsofTheWeekActivity.class));
            }
        });
        EssentialTesting.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(WeekLandingPageActivity.this, EssentialTestsActivity.class));
            }
        });
        setUpForTheBaby.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(WeekLandingPageActivity.this, SetUpForTheBabyActivity.class));
            }
        });
        mealsAndDiet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(WeekLandingPageActivity.this, MealsAndDietActivity.class));
            }
        });
        foreword_arrow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}