import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipeapp/screens/sections/favorites_section.dart';
import 'package:recipeapp/screens/sections/home_section.dart';
import 'package:recipeapp/screens/sections/imc_section.dart';
import 'package:recipeapp/screens/sections/settings_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  //TODO: implement LogOut

  // TextButton(
  // child: const Text('Log out'),
  // onPressed: () {
  // AuthService.logOut();
  // Navigator.pushNamedAndRemoveUntil(
  // context, '/', (Route<dynamic> route) => false);
  // },
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const <Widget>[
            HomeSection(),
            FavoritesSection(),
            ImcSection(),
            SettingsSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarTheme(
        data:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.black),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/icons/homeIcon.svg',
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/icons/hearthIcon.svg',
                ),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/icons/imcIcon.svg',
                ),
              ),
              label: 'IMC',
            ),
            BottomNavigationBarItem(
              icon: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/icons/settingsIcon.svg',
                ),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
