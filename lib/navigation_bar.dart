import 'dart:io';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Home/home.dart';
import 'package:crime_analysis_flutter/view/Profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'view/Recent Complains/recent_complains.dart';

class NaviGationBar extends StatefulWidget {
  final SelectedTab tab;
  const NaviGationBar({super.key, this.tab = SelectedTab.home});

  @override
  State<NaviGationBar> createState() => _NaviGationBarState();
}

class _NaviGationBarState extends State<NaviGationBar> {
  late SelectedTab _selectedTab;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = SelectedTab.values[i];
    });
  }

  @override
  void initState() {
    _selectedTab = widget.tab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        extendBody: false,
        body: SafeArea(
            child: _selectedTab == SelectedTab.home
                ? HomeScreen()
                : _selectedTab == SelectedTab.favourites
                    ? RecentComplains()
                    : ProfileScreen()),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.security_outlined,
              ),
              activeIcon: Icon(Icons.security),
              label: 'Recent',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedTab.index,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.main,
          onTap: _handleIndexChanged,
        ),
      ),
    );
  }
}

enum SelectedTab { home, favourites, profile }
