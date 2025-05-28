import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleTheme;

  const ResponsiveAppBar({Key? key, required this.onToggleTheme})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 790;

    return AppBar(
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
            child: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
          ),
          const SizedBox(width: 20),
        ],
      ),
      actions: [
        if (isWideScreen)
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _AppBarMenuItem(title: 'HOME', route: '/home'),
                  _AppBarMenuItem(title: 'PROFILE', route: '/profile'),
                  _AppBarMenuItem(title: '3x3'),
                  _AppBarMenuItem(title: 'EVENTS', route: '/search-event'),
                  _AppBarMenuItem(title: 'BALL INFO', route: '/ball-info'),
                  _AppBarMenuItem(title: 'RULES', route: '/rules'),
                  _AppBarMenuItem(title: 'PLAYERS', route: '/search-player'),
                  _AppBarMenuItem(title: 'ORGANIZERS'),
                  _AppBarMenuItem(title: 'FEDERATIONS'),
                  IconButton(
                    icon: Icon(Icons.brightness_6),
                    onPressed: onToggleTheme,
                  ),
                ],
              ),
            ),
          )
        else
          Builder(
            builder:
                (context) => Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.brightness_6),
                      onPressed: onToggleTheme,
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ],
                ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarMenuItem extends StatelessWidget {
  final String title;
  final String? route;

  const _AppBarMenuItem({required this.title, this.route, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          route != null ? () => Navigator.of(context).pushNamed(route!) : null,
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
