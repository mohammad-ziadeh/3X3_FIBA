import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:fiba_3x3/pages/profile/profile_about.dart';
import 'package:fiba_3x3/pages/profile/profile_events.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const ProfilePage({super.key, required this.onToggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(onToggleTheme: widget.onToggleTheme),
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Mohammad ziadeh",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  const _ProfileInfoRow(),
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
                              Tab(text: 'ABOUT'),
                              Tab(text: 'ACTIVITY'),
                              Tab(text: 'RANKING'),
                              Tab(text: 'SOCIAL MEDIA'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              PlayerAboutPage(),

                              PlayedEventsPage(),
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
          ),
        ],
      ),
      endDrawer: const CustomDrawer(),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow();

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Rank", 1),
    ProfileInfoItem("Points", 3000),
    ProfileInfoItem("Team Rank", 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            _items
                .map(
                  (item) => Expanded(
                    child: Row(
                      children: [
                        if (_items.indexOf(item) != 0) const VerticalDivider(),
                        Expanded(child: _singleItem(context, item)),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Text(item.title, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: 1200,
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Image.network(
            'https://images.unsplash.com/photo-1504450758481-7338eba7524a?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1542309667-2a115d1f54c6?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: -27,

                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.network(
                          'https://lottie.host/68c96857-fb87-4515-ae31-4176e26840e6/EEQKgYEzBh.json',
                          repeat: true,
                          animate: true,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          top: 70,

                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
