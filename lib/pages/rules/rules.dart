import 'package:fiba_3x3/pages/rules/pdf_scrore.dart';
import 'package:fiba_3x3/pages/rules/rules_table.dart';
import 'package:fiba_3x3/pages/rules/pdf_rules.dart';
import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class RulesPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const RulesPage({super.key, required this.onToggleTheme});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _ytController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _ytController = YoutubePlayerController.fromVideoId(
      videoId: 'mu_Ogwqyyic',
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        loop: true,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _ytController.close();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildYouTubePlayer() {
    return YoutubePlayerControllerProvider(
      controller: _ytController,
      child: YoutubePlayer(aspectRatio: 16 / 9, controller: _ytController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: widget.onToggleTheme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/dunk.jpg',
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    "RULES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: const [
                  RuleCard(
                    icon: Icons.sports_basketball_outlined,
                    title: 'Simple',
                    description: '1 hoop,\n1 half court\n2 teams of 3 + 1 sub',
                  ),
                  SizedBox(height: 16),
                  RuleCard(
                    icon: Icons.flash_on,
                    title: 'Fast',
                    description:
                        '10-minute game\n12-second shot-clock\nNo break after scoring\nNo half-time\nNo quarters',
                  ),
                  SizedBox(height: 16),
                  RuleCard(
                    icon: Icons.music_note_outlined,
                    title: 'Entertaining',
                    description:
                        'Game over at 21 pts\nFirst to 2 pts wins OT\nNon-stop music',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _buildYouTubePlayer(),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'MAIN DIFFERENCES 3x3 vs Basketball',
              style: TextStyle(
                fontSize: 24,
                textBaseline: TextBaseline.alphabetic,
                fontWeight: FontWeight.w900,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            RulesTable(),
            const SizedBox(height: 30),
            Column(
              children: [
                SizedBox(
                  height: 48,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    labelColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [Tab(text: 'RULES'), Tab(text: 'SCORE SHEETS')],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    controller: _tabController,
                    children: [PdfList(), ScoreList()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: const CustomDrawer(),
    );
  }
}

class RuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const RuleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(253, 253, 253, 253)
                  : null,
        ),
        child: Column(
          children: [
            Icon(icon, size: 55, color: Colors.yellow[700]),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
