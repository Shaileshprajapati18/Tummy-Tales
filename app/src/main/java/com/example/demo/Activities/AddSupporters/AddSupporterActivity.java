package com.example.demo.Activities.AddSupporters;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.Activities.HealthHealthcareActivity;
import com.example.demo.Activities.LifestyePreferencesActivity;
import com.example.demo.R;

public class AddSupporterActivity extends AppCompatActivity {

    Button yes;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_add_supporter);

        yes=findViewById(R.id.yes);

        yes.setOnClickListener(v -> {
                    startActivity(new Intent(AddSupporterActivity.this, AddPrimarySupporterActivity.class));
                }
        );
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}