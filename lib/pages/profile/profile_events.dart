import 'package:flutter/material.dart';

class PlayedEventsPage extends StatelessWidget {
  const PlayedEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                rows:
                    events.map((event) {
                      return DataRow(
                        cells: [
                          DataCell(Text(event['event'])),
                          DataCell(Text(event['date'])),
                          DataCell(Text(event['category'])),
                          DataCell(Text(event['team'])),
                          DataCell(Text(event['standings'])),
                          DataCell(Text(event['rankingPoints'])),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
