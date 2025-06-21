import 'package:flutter/material.dart';
import 'package:fiba_3x3/services/team_service.dart';

class EditTeamPage extends StatefulWidget {
  final Map<String, dynamic>? team;

  const EditTeamPage({Key? key, this.team}) : super(key: key);

  @override
  State<EditTeamPage> createState() => _EditTeamPageState();
}

class _EditTeamPageState extends State<EditTeamPage> {
  final TeamService _teamService = TeamService();
  late TextEditingController nameController;
  late TextEditingController locationController;
  late bool isEditMode;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.team != null;
    nameController = TextEditingController(text: widget.team?['name'] ?? '');
    locationController =
        TextEditingController(text: widget.team?['location'] ?? '');
  }

  Future<void> _saveTeam() async {
    final name = nameController.text.trim();
    final location = locationController.text.trim();

    if (isEditMode) {
      await _teamService.updateTeam(widget.team!['id'],
          name: name, location: location);
    } else {
      await _teamService.createTeam(name: name, location: location);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Team' : 'Create Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Team Name'),
              validator: (v) => v!.isEmpty ? 'Enter a team name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (v) => v!.isEmpty ? 'Enter location' : null,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveTeam,
                  child: Text(isEditMode ? 'Update' : 'Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
