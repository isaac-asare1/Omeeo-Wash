import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

class ChatTabScreen extends StatelessWidget {
  const ChatTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: CustomText('Chats Tab')),
    );
  }
}
