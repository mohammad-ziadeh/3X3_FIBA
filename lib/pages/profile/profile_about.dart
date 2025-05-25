import 'package:flutter/material.dart';

class PlayerAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double labelFontSize = screenWidth > 600 ? 20 : 16;
    final double valueFontSize = screenWidth > 600 ? 24 : 16;

    Widget _buildDetailRow({required String label, required String value}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelFontSize,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: valueFontSize,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _buildDetailRow(label: 'Nationality', value: 'Jordan 🇯🇴'),
                  const Divider(),

                  _buildDetailRow(label: 'Hometown', value: 'Aqaba, Jordan'),
                  const Divider(),

                  _buildDetailRow(label: 'Gender', value: 'Male'),
                  const Divider(),

                  _buildDetailRow(label: 'Age', value: '19'),
                  const Divider(),

                  _buildDetailRow(label: 'Height', value: '-'),
                  const Divider(),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isLargeScreen = constraints.maxWidth > 600;
                      final double titleFontSize = isLargeScreen ? 20 : 16;
                      final double valueFontSizeLarge = isLargeScreen ? 26 : 20;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ranking Points',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'World Ranking',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Nationality: Jordan',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Country: Jordan',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: valueFontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'N/A',
                                style: TextStyle(
                                  fontSize: valueFontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'N/A',
                                style: TextStyle(
                                  fontSize: valueFontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'N/A',
                                style: TextStyle(
                                  fontSize: valueFontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
