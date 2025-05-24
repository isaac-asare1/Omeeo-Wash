import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

class OrdersTabScreen extends StatelessWidget {
  const OrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: CustomText('Orders Tab')),
    );
  }
}
