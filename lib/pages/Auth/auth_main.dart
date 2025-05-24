import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fiba_3x3/pages/Auth/signUp/gender_and_birth.dart';
import 'package:fiba_3x3/pages/Auth/login/login.dart';
import 'package:fiba_3x3/pages/Auth/signUp/sign_up_form.dart';
import 'package:animations/animations.dart';

class AuthMain extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const AuthMain({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<AuthMain> createState() => _AuthMainState();
}

class _AuthMainState extends State<AuthMain> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      LoginPage(onNext: () => _navigateTo(1)),
      StepOnePage(onNext: () => _navigateTo(2)),
      SignUpStepTwo(onBack: () => _navigateTo(0)),
    ]);
  }

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/3x3Logo.svg', height: 53),
        leading:
            _selectedIndex > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigate back to the previous page
                    if (_selectedIndex == 2) {
                      _navigateTo(1);
                    } else if (_selectedIndex == 1) {
                      _navigateTo(0);
                    }
                  },
                )
                : null,
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),
    );
  }
}
