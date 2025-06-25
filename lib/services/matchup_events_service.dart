import 'dart:convert';
import 'package:http/http.dart' as http;


class Team {
  final int id;
  final String name;

  Team({required this.id, required this.name});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Matchup {
  final int id;
  final int eventId;
  final Team teamA;
  final Team teamB;
  final DateTime? matchTime;
  final String? location;
  final String? round;

  Matchup({
    required this.id,
    required this.eventId,
    required this.teamA,
    required this.teamB,
    this.matchTime,
    this.location,
    this.round,
  });

  factory Matchup.fromJson(Map<String, dynamic> json) {
    return Matchup(
      id: json['id'],
      eventId: json['event_id'],
      teamA: Team.fromJson(json['team_a']),
      teamB: Team.fromJson(json['team_b']),
      matchTime: json['match_time'] != null ? DateTime.parse(json['match_time']) : null,
      location: json['location'],
      round: json['round'],
    );
  }
}

class EventWithMatchups {
  final int id;
  final String title;
  final String eventCode;
  final List<Team> teams;
  final List<Matchup> matchups;

  EventWithMatchups({
    required this.id,
    required this.title,
    required this.eventCode,
    required this.teams,
    required this.matchups,
  });

  factory EventWithMatchups.fromJson(Map<String, dynamic> json) {
    return EventWithMatchups(
      id: json['id'],
      title: json['title'],
      eventCode: json['event_code'],
      teams: (json['teams'] as List).map((t) => Team.fromJson(t)).toList(),
      matchups: (json['matchups'] as List).map((m) => Matchup.fromJson(m)).toList(),
    );
  }
}





class MatchupService {
  final String baseUrl = "http://192.168.1.159:8000/api";

  Future<List<EventWithMatchups>> fetchEventsWithMatchups() async {
    final response = await http.get(Uri.parse('$baseUrl/matchups'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => EventWithMatchups.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load matchups');
    }
  }

  Future<Matchup> fetchMatchupDetails(int matchupId) async {
    final response = await http.get(Uri.parse('$baseUrl/matchups/$matchupId'));
    if (response.statusCode == 200) {
      return Matchup.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load matchup details');
    }
  }
}