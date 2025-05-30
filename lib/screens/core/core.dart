import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';
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

  bool _shouldExit = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        if (!didPop) {
          _showExitDialog();
        }
      },

      child: Scaffold(
        body: _pages[_selectedPageIndex]["page"],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            // splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            iconSize: 20,

            unselectedItemColor: hintTextColor,
            selectedItemColor: lightPurple,
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
        ),
      ),
    );
  }

  Future<void> _showExitDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            //title: const Text("Exit App?"),
            content: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText('Exit App', color: hintTextColor),
                  SizedBox(height: 10),
                  const Text("Are you sure you want to close the app?"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: CustomText(
                  "No",
                  fontSize: FontSizes.ml,
                  color: lightPurple,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const CustomText(
                  "Yes",
                  fontSize: FontSizes.ml,
                  color: lightPurple,
                ),
              ),
            ],
          ),
    );

    setState(() {
      _shouldExit = result ?? false;
    });

    if (_shouldExit) {
      SystemNavigator.pop();
    }
  }
}
