import 'package:flutter/material.dart';
import 'package:my_assignmentt/auth_services/google_signin.dart';
import 'package:my_assignmentt/screens/show_notifications.dart';
import 'package:my_assignmentt/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _logout(context);
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Get user provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Delete all users from the database

    // Clear SharedPreferences login state
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Sign out from Google
    await GoogleSignInService().signOut();

    // Navigate to SignInScreen and clear navigation history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false, // Remove all previous screens from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Screens"),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ShowNotificationScreen()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
              Tab(icon: Icon(Icons.settings), text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SettingsScreen(),
            ProfileScreen(),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => _showLogoutDialog(context),
                    child: Text("Logout", style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                  Text("Help Us", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Screen Widget
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final users = userProvider.users;
        if (users.isEmpty) {
          return Center(child: Text("No user found", style: TextStyle(fontSize: 18)));
        }

        final user = users.last;

        return Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user.userprofilepic.isNotEmpty
                    ? NetworkImage(user.userprofilepic)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
              SizedBox(height: 20),
              Text(user.username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(user.useremail, style: TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}

// Settings Screen Widget
class SettingsScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Notification Title",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: "Notification Message",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text;
              final message = _messageController.text;
              if (title.isNotEmpty && message.isNotEmpty) {
                final notification = NotificationData(
                  title: title,
                  message: message,
                  timestamp: DateTime.now().toString(),
                );
                Provider.of<UserProvider>(context, listen: false).addNotification(notification);
                _titleController.clear();
                _messageController.clear();
              }
            },
            child: Text("Send Notification"),
          ),
        ],
      ),
    );
  }
}
