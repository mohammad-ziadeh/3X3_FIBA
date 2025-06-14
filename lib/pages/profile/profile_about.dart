import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlayerAboutPage extends StatefulWidget {
  const PlayerAboutPage({super.key});

  @override
  State<PlayerAboutPage> createState() => _PlayerAboutPageState();
}

class _PlayerAboutPageState extends State<PlayerAboutPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double labelFontSize = screenWidth > 600 ? 20 : 16;
    final double valueFontSize = screenWidth > 600 ? 24 : 16;

    Widget buildDetailRow({required String label, required String value}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: labelFontSize)),
          Text(value, style: TextStyle(fontSize: valueFontSize)),
        ],
      );
    }

    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    buildDetailRow(label: 'Nationality', value: 'Jordan 🇯🇴'),
                    const Divider(),
                    buildDetailRow(label: 'Hometown', value: 'Aqaba, Jordan'),
                    const Divider(),
                    buildDetailRow(label: 'Gender', value: 'Male'),
                    const Divider(),
                    buildDetailRow(label: 'Age', value: '19'),
                    const Divider(),
                    buildDetailRow(label: 'Height', value: '-'),
                    const Divider(),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isLargeScreen = constraints.maxWidth > 600;
                        final double titleFontSize = isLargeScreen ? 20 : 16;
                        final double valueFontSizeLarge =
                            isLargeScreen ? 26 : 20;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ranking Points',
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'World Ranking',
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Nationality: Jordan',
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Country: Jordan',
                                  style: TextStyle(fontSize: titleFontSize),
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
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'N/A',
                                  style: TextStyle(
                                    fontSize: valueFontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'N/A',
                                  style: TextStyle(
                                    fontSize: valueFontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'N/A',
                                  style: TextStyle(
                                    fontSize: valueFontSizeLarge,
                                    fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
