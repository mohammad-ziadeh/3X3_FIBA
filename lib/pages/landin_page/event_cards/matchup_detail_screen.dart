import 'package:fiba_3x3/services/matchup_events_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MatchupDetailScreen extends StatefulWidget {
  final int matchupId;

  const MatchupDetailScreen({super.key, required this.matchupId});

  @override
  State<MatchupDetailScreen> createState() => _MatchupDetailScreenState();
}

class _MatchupDetailScreenState extends State<MatchupDetailScreen> {
  late Future<Matchup> _matchupFuture;

  @override
  void initState() {
    super.initState();
    _matchupFuture = MatchupService().fetchMatchupDetails(widget.matchupId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = isDark ? Colors.grey[900] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchup Details'),
        backgroundColor: isDark ? Colors.black : Colors.blueGrey[800],
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder<Matchup>(
        future: _matchupFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading matchup: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          final matchup = snapshot.data!;
          final matchTime =
              matchup.matchTime != null
                  ? DateFormat(
                    'EEEE, MMM d • h:mm a',
                  ).format(matchup.matchTime!)
                  : 'To Be Determined';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${matchup.teamA.name} vs ${matchup.teamB.name}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInfoRow(
                          icon: Icons.access_time,
                          label: 'Scheduled',
                          value: matchTime,
                          color: textColor,
                          theme: theme,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.location_on,
                          label: 'Location',
                          value: matchup.location ?? 'TBD',
                          color: textColor,
                          theme: theme,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.stars,
                          label: 'Round',
                          value: matchup.round ?? 'N/A',
                          color: textColor,
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color.withOpacity(0.8), size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: color.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
