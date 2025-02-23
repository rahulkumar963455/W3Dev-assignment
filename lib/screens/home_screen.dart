import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings =
    InitializationSettings(android: androidInitSettings);

    _notificationsPlugin.initialize(initSettings);
  }

  Future<void> _sendNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id',
      'Local Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      _titleController.text,
      _messageController.text,
      details,
    );

    _titleController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
            Center(child: Text("Home Screen", style: TextStyle(fontSize: 24))),
            ProfileScreen(),
            SettingsScreen(
              titleController: _titleController,
              messageController: _messageController,
              sendNotification: _sendNotification,
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
          return Center(
              child: Text("No user found", style: TextStyle(fontSize: 18)));
        }

        final user = users.last;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user.userprofilepic.isNotEmpty
                    ? NetworkImage(user.userprofilepic)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
              SizedBox(height: 10),
              Text(user.username,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(user.useremail,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }
}

// Settings Screen Widget (Send Local Notification)
class SettingsScreen extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController messageController;
  final VoidCallback sendNotification;

  SettingsScreen({
    required this.titleController,
    required this.messageController,
    required this.sendNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Notification Title"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: messageController,
            decoration: InputDecoration(labelText: "Notification Message"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: sendNotification,
            child: Text("Send Notification"),
          ),
        ],
      ),
    );
  }
}
