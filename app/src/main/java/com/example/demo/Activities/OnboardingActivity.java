package com.example.demo.Activities;

import android.content.Intent;
import android.os.Bundle;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.R;

public class OnboardingActivity extends AppCompatActivity {

    Button loginButton,createAccount;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_onboarding);
        loginButton = findViewById(R.id.loginButton);
        createAccount = findViewById(R.id.createAccount);

        Window window= getWindow();
        window.setStatusBarColor(getResources().getColor(R.color.white));

        loginButton.setOnClickListener(v -> {
            startActivity(new Intent(OnboardingActivity.this, LoginActivity.class));
        });

        createAccount.setOnClickListener(v -> {
            startActivity(new Intent(OnboardingActivity.this, SIgnUpActivity.class));
        });

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}