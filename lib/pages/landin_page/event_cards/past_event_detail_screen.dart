import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiba_3x3/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastEventDetailScreen extends StatelessWidget {
  final Event event;

  const PastEventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black87;
    final iconColor = isDark ? Colors.white : Colors.black;

    final imageUrlWithVersion =
        event.imageUrl != null
            ? '${event.imageUrl}?v=${event.updatedAt.millisecondsSinceEpoch}'
            : 'https://picsum.photos/600/220';

    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: event.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrlWithVersion,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        width: double.infinity,
                        height: 220,
                        color: isDark ? Colors.black : Colors.white,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        width: double.infinity,
                        height: 220,
                        color: isDark ? Colors.black : Colors.white,
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: iconColor.withOpacity(0.4),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              event.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: iconColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    event.location,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.date_range, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  '${dateFormat.format(event.startDate)} to ${dateFormat.format(event.endDate)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.vpn_key, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  'Event Code: ${event.eventCode}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                'This event has already ended. You can no longer register or participate.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
