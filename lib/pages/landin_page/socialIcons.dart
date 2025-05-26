import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialFollowSection extends StatelessWidget {
  const SocialFollowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'FOLLOW FIBA 3X3',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900 , letterSpacing: -1,),
            textAlign: TextAlign.center,
          ),
        ),

        _buildSocialCard(
          backgroundColor: Color(0xFFe30613),
          icon: FontAwesomeIcons.youtube,
          title: '1,030,441',
          subtitle: 'YOUTUBE SUBSCRIBERS',
          buttonText: 'Subscribe now',
        ),
        SizedBox(height: 20),
        _buildSocialCard(
          backgroundColor: Color(0xFF3b5998),
          icon: FontAwesomeIcons.facebook,
          title: '2,025,000',
          subtitle: 'FACEBOOK FOLLOWERS',
          buttonText: 'Follow us',
        ),
        SizedBox(height: 20),
        _buildSocialCard(
          backgroundColor: Color(0xFFe1306C),
          icon: FontAwesomeIcons.instagram,
          title: '764,000',
          subtitle: 'INSTAGRAM FOLLOWERS',
          buttonText: 'Follow us',
        ),
        SizedBox(height: 20),
        _buildSocialCard(
          backgroundColor: const Color.fromARGB(255, 26, 26, 26),
          icon: FontAwesomeIcons.tiktok,
          title: '2,836,000',
          subtitle: 'TIKTOK FOLLOWERS',
          buttonText: 'Follow us',
        ),
      ],
    );
  }

  Widget _buildSocialCard({
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              FaIcon(icon, color: Colors.white, size: 32),
              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      letterSpacing: -1,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 14,letterSpacing: -1, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),

        Positioned(
          
          right: 25,
          bottom: -3,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 9,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: backgroundColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,letterSpacing: -1,),
            ),
          ),
        ),
      ],
    );
  }
}
