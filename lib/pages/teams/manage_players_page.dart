import 'package:flutter/material.dart';
import 'package:fiba_3x3/services/team_service.dart';
import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManagePlayersPage extends StatefulWidget {
  final Map<String, dynamic> team;

  const ManagePlayersPage({Key? key, required this.team}) : super(key: key);

  @override
  State<ManagePlayersPage> createState() => _ManagePlayersPageState();
}

class _ManagePlayersPageState extends State<ManagePlayersPage> {
  late TeamService _teamService;
  List<dynamic> assignedPlayers = [];
  List<int> selectedPlayerIds = [];
  List<AppUser> allPlayers = [];
  List<AppUser> filteredPlayers = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _teamService = TeamService();

    assignedPlayers = widget.team['players'] ?? [];
    selectedPlayerIds =
        assignedPlayers.map<int>((p) => p['user_id'] as int).toList();

    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final players = await _teamService.getPlayers();
      setState(() {
        allPlayers = players;
        filteredPlayers = allPlayers;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _filterPlayers(String query) {
    setState(() {
      filteredPlayers =
          allPlayers
              .where(
                (player) =>
                    player.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  Future<void> _updateTeamPlayers() async {
    final int teamId = widget.team['id'];
    final originallyAssigned =
        assignedPlayers.map<int>((p) => p['user_id'] as int).toList();

    final toAdd =
        selectedPlayerIds
            .where((id) => !originallyAssigned.contains(id))
            .toList();
    final toRemove =
        originallyAssigned
            .where((id) => !selectedPlayerIds.contains(id))
            .toList();

    try {
      for (int id in toAdd) {
        await _teamService.addPlayerToTeam(teamId: teamId, userId: id);
      }

      for (int id in toRemove) {
        await _teamService.removePlayerFromTeam(teamId: teamId, userId: id);
      }

      // Update assignedPlayers locally to match selectedPlayerIds
      setState(() {
        assignedPlayers =
            allPlayers
                .where((player) => selectedPlayerIds.contains(player.id))
                .map((player) => {'user_id': player.id, 'name': player.name})
                .toList();

        // Update the original team map players list to keep it consistent
        widget.team['players'] = assignedPlayers;
      });

      // Send the updated assignedPlayers back to the previous screen
      Navigator.pop(context, assignedPlayers);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${toAdd.length} player(s) added, ${toRemove.length} removed.',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: () {}),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Players for ${widget.team['name']}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Player',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterPlayers,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadPlayers,
                child: Skeletonizer(
                  enabled: _loading,
                  child:
                      _error != null
                          ? Center(
                            child: Text('Error loading players: $_error'),
                          )
                          : filteredPlayers.isEmpty
                          ? const Center(child: Text('No players found'))
                          : ListView.builder(
                            itemCount: filteredPlayers.length,
                            itemBuilder: (context, index) {
                              final player = filteredPlayers[index];
                              final isSelected = selectedPlayerIds.contains(
                                player.id,
                              );

                              return CheckboxListTile(
                                title: Text(player.name),
                                value: isSelected,
                                onChanged: (bool? checked) {
                                  setState(() {
                                    if (checked == true) {
                                      if (!selectedPlayerIds.contains(
                                        player.id,
                                      )) {
                                        selectedPlayerIds.add(player.id);
                                      }
                                    } else {
                                      selectedPlayerIds.remove(player.id);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed:
                      selectedPlayerIds.isEmpty ? null : _updateTeamPlayers,
                  child: const Text('Update Team'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
