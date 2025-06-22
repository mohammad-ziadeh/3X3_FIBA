import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fiba_3x3/services/storage_service.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

class TeamService {
  Future<String> fetchToken() async {
    final storage = kIsWeb ? WebStorage() : MobileStorage();
    return await storage.read(key: 'token') ?? '';
  }

  // Future<Map<String, dynamic>> addCustomPlayerToTeam({
  //   required int teamId,
  //   required String playerName,
  // }) async {
  //   final token = await fetchToken();

  //   final response = await http.post(
  //     Uri.parse('${ApiConfig.baseUrl}/api/teams/$teamId/custom-players'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //     body: jsonEncode({'name': playerName}),
  //   );

  //   if (response.statusCode == 201) {
  //     return {'success': true};
  //   } else {
  //     final body = jsonDecode(response.body);
  //     return {
  //       'success': false,
  //       'error': body['message'] ?? 'Failed to add custom player',
  //     };
  //   }
  // }

  Future<Map<String, dynamic>> createTeam({
    required String name,
    required String location,
  }) async {
    final token = await fetchToken();

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/teams'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'name': name, 'location': location}),
    );

    if (response.statusCode == 201) {
      return {'success': true, 'team': jsonDecode(response.body)};
    } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'error': body['message'] ?? 'Failed to create team',
      };
    }
  }

  Future<Map<String, dynamic>> updateTeam(
    int teamId, {
    required String name,
    required String location,
  }) async {
    final token = await fetchToken();

    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/api/teams/$teamId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'name': name, 'location': location}),
    );

    if (response.statusCode == 200) {
      return {'success': true, 'team': jsonDecode(response.body)};
    } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'error': body['message'] ?? 'Failed to update team',
      };
    }
  }

  Future<bool> deleteTeam(int teamId) async {
    final token = await fetchToken();

    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/api/teams/$teamId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return response.statusCode == 204;
  }

  Future<List<dynamic>> getCoachTeams() async {
    final token = await fetchToken();

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/teams'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<Map<String, dynamic>> addPlayerToTeam({
    required int teamId,
    required int userId,
    String role = 'player',
  }) async {
    final token = await fetchToken();

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/teams/$teamId/players'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'user_id': userId, 'role': role}),
    );

    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'error': body['message'] ?? 'Failed to add player',
      };
    }
  }

  Future<List<AppUser>> getPlayers() async {
    final token = await fetchToken();

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/users?role=player'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((u) => AppUser.fromJson(u)).toList();
    } else {
      throw Exception(
        'Failed to fetch players: ${response.statusCode} ${response.body}',
      );
    }
  }

  Future<void> removePlayerFromTeam({
    required int teamId,
    required int userId,
  }) async {
    final token = await fetchToken();

    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/api/teams/$teamId/players/$userId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['message'] == 'Player removed from team') {
        return;
      } else {
        throw Exception(body['message'] ?? 'Failed to remove player');
      }
    } else {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to remove player');
    }
  }

  Future<void> assignTeamToEvent({
    required int teamId,
    required int eventId,
  }) async {
    final token = await fetchToken();

    final response = await http.post(
      Uri.parse(
        '${ApiConfig.baseUrl}/api/teams/$teamId/events/$eventId/assign',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to assign team to event');
    }
  }

  Future<String?> getUserRole() async {
    final storage = kIsWeb ? WebStorage() : MobileStorage();
    final userJson = await storage.read(key: 'user');
    if (userJson == null) return null;
    final userMap = jsonDecode(userJson);
    return userMap['role'] as String?;
  }


}

class AppUser {
  final int id;
  final String name;

  AppUser({required this.id, required this.name});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(id: json['id'], name: json['name']);
  }
}
