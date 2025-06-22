import 'dart:convert';

import 'package:http/http.dart' as http;

class Event {
  final int id;
  final String title;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String eventCode;
  final String? imageUrl;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.eventCode,
    required this.updatedAt,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    String? rawImage = json['image_url'];
    String? imageUrl;

    if (rawImage != null && rawImage.isNotEmpty) {
      final filename = rawImage.split('/').last;

      imageUrl = 'http://192.168.1.159:8000/cors-image/$filename';
    }

    return Event(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      updatedAt: DateTime.parse(json['updated_at']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      eventCode: json['event_code'],
      imageUrl: imageUrl,
    );
  }
}

class EventService {
  final String apiUrl = "http://192.168.1.159:8000/api/events";

  Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Event.fromJson(item)).toList();
    } else {
      throw "Failed to load events";
    }
  }
}
