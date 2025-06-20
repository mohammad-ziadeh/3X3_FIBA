import 'package:fiba_3x3/services/event_service.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: event.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.imageUrl ?? 'https://picsum.photos/600/220',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              event.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Location: ${event.location}'),
            Text('Date: ${event.startDate} - ${event.endDate}'),
            Text('Event Code: ${event.eventCode}'),
          ],
        ),
      ),
    );
  }
}
