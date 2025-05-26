import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';

class SearchPlayer extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const SearchPlayer({super.key, required this.onToggleTheme});

  @override
  State<SearchPlayer> createState() => _SearchPlayerState();
}

class _SearchPlayerState extends State<SearchPlayer>
    with SingleTickerProviderStateMixin {
  final SearchController _controller = SearchController();
  String selectedSeason = 'Any season';
  String selectedLevel = 'Any level';

  final List<String> seasons = ['Any season', '2024', '2025'];
  final List<String> levels = ['Any level', 'Male', 'Female', 'Kids'];

  final List<String> suggestions = [
    'New York Open',
    'Paris City Jam',
    'FIBA World Tour',
    'Tokyo Streetball',
    'Local League',
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 43, 43, 53)
              : Colors.white,
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
          if (MediaQuery.of(context).size.width < 600)
            Builder(
              builder:
                  (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'SEARCH FOR 3X3 PLAYERS WORLDWIDE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.2,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start typing and select the search type (e.g. by name, by city, by country or by organizer) from the suggestions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SearchAnchor.bar(
              barLeading: Icon(Icons.search, color: Colors.black),
              barBackgroundColor: WidgetStateProperty.all(Colors.white),
              barHintText: 'Search for players (minimum 3 characters)',
              barTextStyle: WidgetStateProperty.all(
                TextStyle(color: Colors.black),
              ),
              barHintStyle: WidgetStateProperty.all(
                TextStyle(color: Color(0xFF757575)),
              ),
              suggestionsBuilder: (context, controller) {
                final query = controller.text.toLowerCase();
                final filtered =
                    suggestions
                        .where((s) => s.toLowerCase().contains(query))
                        .toList();
                return filtered.map((s) {
                  return ListTile(
                    title: Text(s),
                    onTap: () {
                      controller.text = s;
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: s.length),
                      );
                      Navigator.of(context).pop();
                    },
                  );
                }).toList();
              },
              searchController: _controller,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField2<String>(
                    style: TextStyle(color: Colors.white),
                    value: selectedSeason,
                    items:
                        seasons
                            .map(
                              (season) => DropdownMenuItem(
                                value: season,
                                child: Text(season),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSeason = value;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField2<String>(
                    style: TextStyle(color: Colors.white),
                    value: selectedLevel,
                    items:
                        levels
                            .map(
                              (level) => DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedLevel = value;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
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
                      tabs: const [
                        Tab(text: 'ALL PLAYERS'),
                        Tab(text: 'MEN'),
                        Tab(text: 'WOMEN'),
                        Tab(text: 'U18 MEN'),
                        Tab(text: 'U18 WOMEN'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: Text(
                            'Found 0 players',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Found 0 players',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Found 0 players',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Found 0 players',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Found 0 players',
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const CustomDrawer(),
    );
  }
}
