import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: CustomText('Profile Tab'),),
    );
  }
}