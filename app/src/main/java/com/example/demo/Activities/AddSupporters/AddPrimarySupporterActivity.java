package com.example.demo.Activities.AddSupporters;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageButton;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.Activities.HealthHealthcareActivity;
import com.example.demo.Activities.LifestyePreferencesActivity;
import com.example.demo.R;

public class AddPrimarySupporterActivity extends AppCompatActivity {

    ImageButton foreword_arrow;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_add_primary_supporter);

        foreword_arrow=findViewById(R.id.foreword_arrow);

        foreword_arrow.setOnClickListener(v -> {
                    startActivity(new Intent(AddPrimarySupporterActivity.this, AddSupportersPinActivity.class));
                }
        );
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}