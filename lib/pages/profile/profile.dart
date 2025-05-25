import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:fiba_3x3/pages/profile/profile_about.dart';
import 'package:fiba_3x3/pages/profile/profile_events.dart';

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
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: Text('Profile', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
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
  const _ProfileInfoRow({Key? key}) : super(key: key);

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
  const _TopPortion({Key? key}) : super(key: key);

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
                    color: Colors.black,
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
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber,
                    child: Text('1'),
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
