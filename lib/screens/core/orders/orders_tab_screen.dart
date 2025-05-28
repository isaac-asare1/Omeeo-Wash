import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';

class OrdersTabScreen extends StatelessWidget {
  const OrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List requestedOrders = [];
    const List acceptedOrders = [];
    const List completedOrders = [];
    const List cancelledOrders = [];
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: Column(
        children: [
          CoreAppBar(title: "Orders"),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                requestedOrders.isEmpty
                    ? NoOrderPlaceHolder(title: 'Requested Orders')
                    : SizedBox(),
                SizedBox(height: 20),
                acceptedOrders.isEmpty
                    ? NoOrderPlaceHolder(title: "Accepted Orders")
                    : SizedBox(),
                SizedBox(height: 20),
                completedOrders.isEmpty
                    ? NoOrderPlaceHolder(title: "Completed Orders")
                    : SizedBox(),
                SizedBox(height: 20),
                cancelledOrders.isEmpty
                    ? NoOrderPlaceHolder(title: "Cancelled Orders")
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoOrderPlaceHolder extends StatelessWidget {
  final String title;
  const NoOrderPlaceHolder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, fontSize: FontSizes.md, color: hintTextColor),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: hintTextColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              "No orders",
              style: TextStyle(
                fontSize: FontSizes.sm,
                fontWeight: FontWeight.bold,
                color: hintTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CoreAppBar extends StatelessWidget {
  final String title;
  const CoreAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      color: darkPurple,
      height: 90,
      child: Center(child: CustomText(title, color: whiteText)),
    );
  }
}
