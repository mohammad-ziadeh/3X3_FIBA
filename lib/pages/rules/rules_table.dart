import 'package:flutter/material.dart';

class RulesTable extends StatelessWidget {
  const RulesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildComparisonTable(),
    );
  }
}

Widget _buildComparisonTable() {
  return Table(
    border: TableBorder(
      horizontalInside: BorderSide(
        color: Colors.grey.shade300,
        style: BorderStyle.solid,
        width: 1.0,
      ),
    ),
    children: [
      TableRow(
        children: [
          _buildTableCell('RULE', bold: true),
          _buildTableCell('3X3', bold: true),
          _buildTableCell('BASKETBALL', bold: true),
        ],
      ),

      _buildDataRow('HOOP', '1', '2'),
      _buildDataRow('COURT', 'HALF', 'FULL'),
      _buildDataRow('PLAYERS', '3-A-SIDE', '5-A-SIDE'),
      _buildDataRow('BALL', '3X3', 'BASKETBALL'),
      _buildDataRow('PLAYING TIME', '10\'', '4 X 10\''),
      _buildDataRow('GAME OVER', '21 PTS', 'N/A'),
      _buildDataRow('SHOT-CLOCK', '12"', '24"'),
      _buildDataRow('FIELD GOALS', '1 OR 2 PTS', '2 OR 3 PTS'),
      _buildDataRow('AFTER SCORING', 'NO BREAK', 'INBOUND'),
    ],
  );
}

Widget _buildTableCell(String text, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: 16,
      ),
    ),
  );
}

TableRow _buildDataRow(String rule, String threeXThree, String basketball) {
  return TableRow(
    children: [
      _buildTableCell(rule),
      _buildTableCell(threeXThree),
      _buildTableCell(basketball),
    ],
  );
}
