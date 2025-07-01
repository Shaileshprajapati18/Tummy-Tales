package com.example.demo.Activities.PutOnPlate;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.Activities.KickCount.KickCount1Activity;
import com.example.demo.R;

public class PutOnPlate1Activity extends AppCompatActivity {

    TextView bite_breakdown;
    ImageView breakfast,lunch;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_put_on_plate1);

        bite_breakdown=findViewById(R.id.bite_breakdown);
        breakfast=findViewById(R.id.breakfast);
        lunch=findViewById(R.id.lunch);

        bite_breakdown.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(PutOnPlate1Activity.this, BiteBreakdown1Activity.class));
            }
        });

        breakfast.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(PutOnPlate1Activity.this, PutOnPlate3Activity.class));
            }
        });

        lunch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(PutOnPlate1Activity.this, KickCount1Activity.class));
            }
        });
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}