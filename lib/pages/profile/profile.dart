import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fiba_3x3/widgets/appBar.dart';
import 'package:fiba_3x3/widgets/custom_drawer.dart';
import 'package:fiba_3x3/pages/profile/profile_about.dart';
import 'package:fiba_3x3/pages/profile/profile_events.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:fiba_3x3/services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const ProfilePage({super.key, required this.onToggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Profile? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final service = ProfileService();
      final result = await service.fetchProfile();

      setState(() {
        profile = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Failed to load profile: $e");
    }
  }

  Future<void> _refreshProfile(BuildContext context) async {
    try {
      final service = ProfileService();
      final updatedProfile = await service.fetchProfile();

      if (mounted) {
        setState(() {
          profile = updatedProfile;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to refresh profile: $e')));
    }
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
      body: RefreshIndicator(
        onRefresh: () => _refreshProfile(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: _TopPortion(
                  profile: profile,
                  onImageChanged: () => _refreshProfile(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      isLoading ? "Loading..." : profile?.name ?? "Guest",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ProfileInfoRow(profile: profile, loading: isLoading),
                    const SizedBox(height: 20),
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
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PlayerAboutPage(profile: profile),
                          PlayedEventsPage(profile: profile),
                          Center(child: Text('${profile?.points ?? 0} Points')),
                          const Center(child: Text('Coming Soon')),
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

      endDrawer: const CustomDrawer(),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final Profile? profile;
  final bool loading;

  const _ProfileInfoRow({Key? key, this.profile, required this.loading})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      ProfileInfoItem("Rank", profile?.rank ?? "N/A"),
      ProfileInfoItem("Points", profile?.points ?? 0),
      ProfileInfoItem("Team Rank", "N/A"),
    ];

    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            items.map((item) {
              return Expanded(
                child: Row(
                  children: [
                    if (items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                ),
              );
            }).toList(),
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
  final dynamic value;

  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatefulWidget {
  final Profile? profile;
  final VoidCallback onImageChanged;

  const _TopPortion({Key? key, this.profile, required this.onImageChanged})
    : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<_TopPortion> {
  bool isLoading = true;

  Future<void> _changeImage(BuildContext context, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        File imageFile = File(pickedFile.path);

        await ProfileService().uploadProfileImage(type, imageFile);

        widget.onImageChanged();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to upload $type image')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Skeletonizer(
          enabled: isLoading,
          child: GestureDetector(
            onTap: () => _changeImage(context, "background_url"),
            child: Container(
              width: double.infinity,
              height: 300,
              margin: const EdgeInsets.only(bottom: 60),
              child:
                  widget.profile?.backgroundUrl != null
                      ? Image.network(
                        widget.profile!.backgroundUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/profile_cover_image3.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      : Image.asset(
                        'assets/images/profile_cover_image3.jpg',
                        fit: BoxFit.cover,
                      ),
            ),
          ),
        ),
        Skeletonizer(
          enabled: isLoading,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => _changeImage(context, "avatar_url"),
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              widget.profile?.avatarUrl != null
                                  ? NetworkImage(widget.profile!.avatarUrl)
                                  : const AssetImage(
                                        'assets/images/profile-male.png',
                                      )
                                      as ImageProvider,
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
                                  shadows: const [
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
          ),
        ),
      ],
    );
  }
}
