package com.example.demo.Activities;

import static android.service.controls.ControlsProviderService.TAG;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.demo.R;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthCredential;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.GoogleAuthProvider;

public class LoginActivity extends AppCompatActivity {

    private static final int RC_SIGN_IN = 9001; // Request code for Google Sign-In
    private GoogleSignInClient mGoogleSignInClient;
    Button loginButton;
    TextView loginRedirect;
    ImageView signInWithGoogle;
    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_login);

        loginButton = findViewById(R.id.loginButton);
        loginRedirect = findViewById(R.id.registerRedirect);
        signInWithGoogle = findViewById(R.id.signInWithGoogle);
        mAuth = FirebaseAuth.getInstance();

        // Configure Google Sign-In with ID token
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestIdToken(getString(R.string.default_web_client_id)) // Required for Firebase
                .requestEmail() // Request email access
                .build();

        mGoogleSignInClient = GoogleSignIn.getClient(this, gso);

        // Check if user is already signed in
        FirebaseUser currentUser = mAuth.getCurrentUser();
        GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(this);
        if (account != null && currentUser != null) {
            // User is already signed in, navigate to SettingsActivity
            startActivity(new Intent(LoginActivity.this, SettingsActivity.class));
            finish();
        }

        // Login button click listener (unchanged)
        loginButton.setOnClickListener(v -> {
            startActivity(new Intent(LoginActivity.this, WelcomeActivity.class));
        });

        // Register redirect click listener (unchanged)
        loginRedirect.setOnClickListener(v -> {
            startActivity(new Intent(LoginActivity.this, SIgnUpActivity.class));
        });

        // Google Sign-In button click listener
        signInWithGoogle.setOnClickListener(v -> signInWithGoogle());

        // Handle window insets for edge-to-edge display (unchanged)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    // Initiate Google Sign-In
    private void signInWithGoogle() {
        Intent signInIntent = mGoogleSignInClient.getSignInIntent();
        startActivityForResult(signInIntent, RC_SIGN_IN);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == RC_SIGN_IN) {
            if (data != null) {
                try {
                    GoogleSignInAccount account = GoogleSignIn.getSignedInAccountFromIntent(data).getResult(ApiException.class);
                    if (account != null) {
                        firebaseAuthWithGoogle(account);
                    } else {
                        Toast.makeText(this, "Google Sign-In failed: No account selected", Toast.LENGTH_LONG).show();
                    }
                } catch (ApiException e) {
                    Log.e(TAG, "Google Sign-In failed: " + e.getStatusCode(), e);
                    Toast.makeText(this, "Google Sign-In failed: " + e.getMessage(), Toast.LENGTH_LONG).show();
                }
            } else {
                Toast.makeText(this, "Google Sign-In failed: No data received", Toast.LENGTH_LONG).show();
            }
        }
    }

    private void firebaseAuthWithGoogle(GoogleSignInAccount account) {
        AuthCredential credential = GoogleAuthProvider.getCredential(account.getIdToken(), null);
        mAuth.signInWithCredential(credential)
                .addOnCompleteListener(this, task -> {
                    if (task.isSuccessful()) {
                        FirebaseUser user = mAuth.getCurrentUser();
                        if (user != null) {
                            checkAndStoreUserData(user, account.getDisplayName(), account.getEmail(), "", "google");
                        } else {
                            Toast.makeText(LoginActivity.this, "Firebase authentication failed: User not found", Toast.LENGTH_LONG).show();
                        }
                    } else {
                        Log.e(TAG, "Firebase auth with Google failed: " + task.getException(), task.getException());
                        Toast.makeText(LoginActivity.this, "Firebase authentication failed: " + task.getException().getMessage(), Toast.LENGTH_LONG).show();
                    }
                });
    }

    private void checkAndStoreUserData(FirebaseUser user, String fullName, String email, String phone, String authMethod) {
        if (user == null) {
            Toast.makeText(LoginActivity.this, "User not authenticated", Toast.LENGTH_SHORT).show();
            return;
        }
        // Navigate to SettingsActivity (added to complete the flow)
        startActivity(new Intent(LoginActivity.this, SettingsActivity.class));
        finish();
    }
}