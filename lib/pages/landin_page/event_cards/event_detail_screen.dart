import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fiba_3x3/services/event_service.dart';
import 'package:fiba_3x3/services/team_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  List<Map<String, dynamic>> coachTeams = [];
  int? selectedTeamId;
  bool isLoading = true;
  bool isAssigning = false;
  String? error;
  Map<String, dynamic>? assignedTeam;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  final TeamService _teamService = TeamService();

  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _loadCoachTeams();
  }

  Future<void> _loadUserRole() async {
    final role = await _teamService.getUserRole();
    setState(() {
      userRole = role;
    });
  }

  Future<void> _loadCoachTeams() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final teams = await _teamService.getCoachTeams();
      setState(() {
        coachTeams = List<Map<String, dynamic>>.from(teams);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _assignTeam() async {
    if (selectedTeamId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a team to assign.')),
      );
      return;
    }

    setState(() {
      isAssigning = true;
    });

    try {
      await _teamService.assignTeamToEvent(
        teamId: selectedTeamId!,
        eventId: widget.event.id,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Team successfully assigned to event!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to assign team: $e')));
    } finally {
      setState(() {
        isAssigning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black87;
    final iconColor = isDark ? Colors.white : Colors.black;
    final borderColor = isDark ? Colors.white : Colors.black;

    final imageUrlWithVersion =
        widget.event.imageUrl != null
            ? '${widget.event.imageUrl}?v=${widget.event.updatedAt.millisecondsSinceEpoch}'
            : 'https://picsum.photos/600/220';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title, style: TextStyle(color: Colors.white)),
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
              tag: widget.event.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrlWithVersion, // Use the new URL here
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
              widget.event.title,
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
                    widget.event.location,
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
                  '${dateFormat.format(widget.event.startDate)} to ${dateFormat.format(widget.event.endDate)}',
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
                  'Event Code: ${widget.event.eventCode}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            if (userRole == 'coach' || userRole == 'admin') ...[
              Text(
                'Assign your team to this event',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                'You can only assign one of your teams to this event.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 15),
              if (isLoading)
                Center(child: CircularProgressIndicator(color: iconColor))
              else if (error != null)
                Center(
                  child: Text(
                    'Error loading teams: $error',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                )
              else if (coachTeams.isEmpty)
                Center(
                  child: Text(
                    'You have no teams to assign.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<int>(
                      isExpanded: true,
                      hint: Text(
                        'Select your team',
                        style: TextStyle(color: secondaryTextColor),
                      ),
                      value: selectedTeamId,
                      items:
                          coachTeams.map((team) {
                            return DropdownMenuItem<int>(
                              value: team['id'] as int,
                              child: Text(
                                team['name'] as String,
                                style: TextStyle(color: textColor),
                              ),
                            );
                          }).toList(),
                      onChanged:
                          (value) => setState(() => selectedTeamId = value),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: bgColor,
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 15),

              // Text(
              //   'You selected:',
              //   style: theme.textTheme.titleMedium?.copyWith(
              //     fontWeight: FontWeight.bold,
              //     color: textColor,
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   assignedTeam != null
              //       ? assignedTeam!['name']
              //       : 'No team assigned yet',
              //   style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
              // ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isAssigning ? null : _assignTeam,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: isDark ? Colors.white : Colors.black,
                  ),
                  child:
                      isAssigning
                          ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: isDark ? Colors.black : Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            'Assign Team',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.black : Colors.white,
                            ),
                          ),
                ),
              ),
            ] else ...[
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Please wait for your coach to assign you to this event.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
