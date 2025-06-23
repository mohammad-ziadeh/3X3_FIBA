import 'package:fiba_3x3/services/NotificationService.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationService notificationService;
  late Future<List<UserNotification>> futureNotifications;

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService();
    futureNotifications = notificationService.getNotifications();
  }

  void _refreshNotifications() {
    setState(() {
      futureNotifications = notificationService.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: "Mark all as read",
            onPressed: () async {
              await notificationService.markAllAsRead();
              _refreshNotifications();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: "Delete all",
            onPressed: () async {
              await notificationService.deleteAllNotifications();
              _refreshNotifications();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserNotification>>(
        future: futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notifications = snapshot.data!;
            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications yet.",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
              onRefresh: () async => _refreshNotifications(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  UserNotification notif = notifications[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 45, 58, 65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              notif.readAt == null
                                  ? Icons.notifications_active_outlined
                                  : Icons.notifications_off_outlined,
                              color:
                                  notif.readAt == null
                                      ? Colors.white
                                      : const Color.fromARGB(
                                        255,
                                        197,
                                        197,
                                        197,
                                      ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                notif.message,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.white,
                                  fontWeight:
                                      notif.readAt == null
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Event: ${notif.eventTitle}",
                          style: TextStyle(color: Colors.white70),
                        ),
                        if (notif.startDate != null && notif.endDate != null)
                          Text(
                            "Start: ${notif.startDate!.toLocal().toString().split(' ')[0]} - End: ${notif.endDate!.toLocal().toString().split(' ')[0]}",
                            style: TextStyle(color: Colors.white70),
                          ),

                        if (notif.assignedBy.isNotEmpty)
                          Text(
                            "Assigned by: ${notif.assignedBy}",
                            style: TextStyle(color: Colors.white70),
                          ),
                        if (notif.readAt != null)
                          Text(
                            "Read at: ${notif.readAt!.toLocal().toString().split('.')[0]}",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 194, 194, 194),
                              fontSize: 12,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (notif.readAt == null)
                              IconButton(
                                icon: const Icon(Icons.check_circle_outline),
                                color: Colors.greenAccent,
                                tooltip: "Mark as read",
                                onPressed: () async {
                                  await notificationService.markAsRead(
                                    notif.id,
                                  );
                                  _refreshNotifications();
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.redAccent,
                              tooltip: "Delete",
                              onPressed: () async {
                                await notificationService.deleteNotification(
                                  notif.id,
                                );
                                _refreshNotifications();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }
}
