import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaBar extends StatelessWidget {
  const SocialMediaBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          // Logo Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/3x3Logo.svg', height: 30),
            ],
          ),

          const SizedBox(height: 16),

          ExpansionTile(
            title: Text(
              '3x3',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            iconColor: Colors.white,
            textColor: Colors.white,
            children: _buildMenuItems(context, section: '3x3'),
          ),

          ExpansionTile(
            title: Text(
              'Events',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            iconColor: Colors.white,
            textColor: Colors.white,
            children: _buildEventItems(context),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.youtube, 'YouTube'),
              _buildSocialIcon(FontAwesomeIcons.facebook, 'Facebook'),
              _buildSocialIcon(FontAwesomeIcons.instagram, 'Instagram'),
              _buildSocialIcon(FontAwesomeIcons.tiktok, 'TikTok'),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(
    BuildContext context, {
    required String section,
  }) {
    final Map<String, List<String>> menu = {
      '3x3': [
        'Vision',
        'Organization',
        'Ball',
        'Rules',
        'Referees',
        'Competition network',
        'Pro career',
        'Documents',
        'FAQ',
        'Glossary',
      ],
      'Events': ['Quick links', 'Calendar', 'How to Qualify'],
    };

    final List<String> items = menu[section] ?? [];

    return items.map((item) {
      return ListTile(
        title: Text(
          item,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      );
    }).toList();
  }

  List<Widget> _buildEventItems(BuildContext context) {
    return [
      ListTile(
        title: Text(
          'Quick links',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ),
      ListTile(
        title: Text(
          'Calendar',
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ),
      ListTile(
        title: Text(
          'How to Qualify',

          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ),
    ];
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          FaIcon(icon, size: 24, color: Colors.white),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
