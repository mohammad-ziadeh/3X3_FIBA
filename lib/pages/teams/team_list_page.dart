import 'package:flutter/material.dart';
import 'package:fiba_3x3/services/team_service.dart';
import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'edit_team_page.dart';
import 'manage_players_page.dart';

class TeamListPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TeamListPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<TeamListPage> createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  final TeamService _teamService = TeamService();
  List<dynamic> _teams = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  Future<void> _loadTeams() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await _teamService.getCoachTeams();
      setState(() => _teams = response);
    } catch (e) {
      setState(() => _error = e.toString());
    }
    setState(() => _loading = false);
  }

  void _navigateToEditTeam(BuildContext context, [Map<String, dynamic>? team]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTeamPage(team: team),
      ),
    ).then((_) => _loadTeams());
  }

  void _navigateToManagePlayers(BuildContext context, Map<String, dynamic> team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ManagePlayersPage(team: team),
      ),
    );
  }

  Future<void> _deleteTeam(int teamId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Team'),
        content: const Text('Are you sure you want to delete this team?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _teamService.deleteTeam(teamId);
      _loadTeams();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Team deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: widget.onToggleTheme),
      endDrawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditTeam(context),
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _teams.isEmpty
                  ? const Center(child: Text('No teams found'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: _teams.length,
                        itemBuilder: (context, index) {
                          final team = _teams[index];
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                team['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0),
                                child: Text(team['location']),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.group_add),
                                    tooltip: 'Add Players',
                                    onPressed: () =>
                                        _navigateToManagePlayers(context, team),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    tooltip: 'Edit Team',
                                    onPressed: () =>
                                        _navigateToEditTeam(context, team),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    tooltip: 'Delete Team',
                                    onPressed: () => _deleteTeam(team['id']),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Optional: navigate to view assigned players
                              },
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}