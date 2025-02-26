import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_assignmentt/models/user_model.dart';
import 'package:my_assignmentt/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_services/google_signin.dart';
import '../providers/user_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false; // To track sign-in progress

  Future<void> saveUserData(AppUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setString('useremail', user.useremail);
    await prefs.setString('userprofilepic', user.userprofilepic);
    await prefs.setBool('isLoggedIn', true); // Save login status
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      isLoading = true; // Show progress indicator
    });

    try {
      UserCredential? userCredential = await GoogleSignInService().signInWithGoogle();
      if (userCredential != null) {
        final user = userCredential.user;
        if (user != null) {
          print("User Signed In: ${user.displayName}");
          print(user.email);

          final newUser = AppUser(
            username: user.displayName ?? "Unknown",
            useremail: user.email ?? "No Email",
            userprofilepic: user.photoURL ?? "",
          );

          // Save user data in SharedPreferences
          await saveUserData(newUser);

          final userProvider = Provider.of<UserProvider>(context, listen: false);
          await userProvider.addUser(newUser);

          // Navigate to HomeScreen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      }
    } catch (e) {
      print("Sign-in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in. Try again!")),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Show loader if signing in
            : ElevatedButton(
          onPressed: isLoading ? null : _signInWithGoogle,
          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}
