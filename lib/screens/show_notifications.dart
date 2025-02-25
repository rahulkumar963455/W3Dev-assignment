import 'package:flutter/material.dart';
import 'package:my_assignmentt/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ShowNotificationScreen extends StatelessWidget {
  const ShowNotificationScreen({super.key});

  void _showDeleteDialog(BuildContext context, int notificationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Notification"),
        content: Text("Are you sure you want to delete this notification?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .deleteNotification(notificationId);
              Navigator.pop(context); // Close the dialog after deletion
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.white,
        ),
        child: Consumer<UserProvider>(
          builder: (context, notificationProvider, child) {
            final notifications = notificationProvider.notifications;

            if (notifications.isEmpty) {
              return Center(child: Text("No Notifications Available"));
            }

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(notification.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(notification.message),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (notification.id != null) {
                          _showDeleteDialog(context, notification.id!);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
