import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/screens/core/orders/orders_tab_screen.dart';

class ChatTabScreen extends StatelessWidget {
  const ChatTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CoreAppBar(title: 'Chat'),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText('No chats'),
                SizedBox(height: 5),
                Text(
                  'When you contact a washer, you will see your conversations with them there.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
