import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.all(16),
              color: const Color.fromARGB(255, 34, 34, 34),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 70,
                    child: SvgPicture.asset('assets/images/3x3Logo.svg'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    padding: const EdgeInsets.only(bottom: 8, left: 13),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerMenuItem(title: 'HOME'),
                  _DrawerMenuItem(title: '3x3'),
                  _DrawerMenuItem(
                    title: 'EVENTS',
                    onTap: () {
                      Navigator.of(context).pushNamed('/search-event');
                    },
                  ),
                  _DrawerMenuItem(title: 'RANKINGS'),
                  _DrawerMenuItem(title: 'OLYMPICS'),
                  _DrawerMenuItem(title: 'NEWS'),
                  _DrawerMenuItem(
                    title: 'PLAYERS',
                    onTap: () {
                      Navigator.of(context).pushNamed('/search-player');
                    },
                  ),
                  _DrawerMenuItem(title: 'ORGANIZERS'),
                  _DrawerMenuItem(title: 'FEDERATIONS'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              height: 70,
              width: double.infinity,
              child: const Text(
                'FIBA.BASKETBALL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _DrawerMenuItem({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.white,
        size: 18,
      ),
      onTap: onTap ?? () => Navigator.of(context).pop(),
    );
  }
}
