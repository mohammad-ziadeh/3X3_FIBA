import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlayedEventsPage extends StatefulWidget {
  const PlayedEventsPage({super.key});

  @override
  State<PlayedEventsPage> createState() => _PlayedEventsPageState();
}

class _PlayedEventsPageState extends State<PlayedEventsPage> {
  bool isLoading = true;
  List<Map<String, String>> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    await Future.delayed(const Duration(seconds: 2));

    events = [
      {
        'event': 'WT Marseille 2025',
        'date': 'May 24, 2025',
        'category': 'Open',
        'team': 'Amsterdam',
        'standings': '2',
        'rankingPoints': '0',
      },
      {
        'event': 'WT Amsterdam 2025',
        'date': 'May 17, 2025',
        'category': 'Open',
        'team': 'Amsterdam',
        'standings': '5',
        'rankingPoints': '63,180',
      },
      {
        'event': 'WT Chengdu 2025',
        'date': 'May 3, 2025',
        'category': 'Open',
        'team': 'Amsterdam',
        'standings': '2',
        'rankingPoints': '100,980',
      },
      {
        'event': 'WT Utsunomiya Opener 2025',
        'date': 'Apr 26, 2025',
        'category': 'Open',
        'team': 'Amsterdam',
        'standings': '2',
        'rankingPoints': '113,508',
      },
    ];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Skeletonizer(
          enabled: isLoading,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('EVENT')),
                DataColumn(label: Text('DATE')),
                DataColumn(label: Text('CATEGORY')),
                DataColumn(label: Text('TEAM')),
                DataColumn(label: Text('STANDINGS')),
                DataColumn(label: Text('RANKING POINTS')),
              ],
              rows: List.generate(isLoading ? 6 : events.length, (index) {
                final event =
                    isLoading
                        ? {
                          'event': 'WTAmsterdam2025',
                          'date': 'May24,2025',
                          'category': '..........',
                          'team': '...........',
                          'standings': '............',
                          'rankingPoints': '...........',
                        }
                        : events[index];
                return DataRow(
                  cells: [
                    DataCell(Text(event['event']!)),
                    DataCell(Text(event['date']!)),
                    DataCell(Text(event['category']!)),
                    DataCell(Text(event['team']!)),
                    DataCell(Text(event['standings']!)),
                    DataCell(Text(event['rankingPoints']!)),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
