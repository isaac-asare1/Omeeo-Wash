import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/screens/core/chat/chat_tab_screen.dart';
import 'package:ommeoWash/screens/core/home/home_tab_screen.dart';
import 'package:ommeoWash/screens/core/orders/orders_tab_screen.dart';
import 'package:ommeoWash/screens/core/profile/profile_tab_screen.dart';

class Core extends StatefulWidget {
  const Core({super.key});

  @override
  State<Core> createState() => _CoreState();
}

class _CoreState extends State<Core> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': const HomeTabScreen()},
      {'page': const OrdersTabScreen()},
      {'page': const ChatTabScreen()},
      {'page': const ProfileTabScreen()},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 20,

        /// backgroundColor: lightGreen,
        unselectedItemColor: hintTextColor,
        selectedItemColor: lightGreen,
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listCheck),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.commentDots),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
