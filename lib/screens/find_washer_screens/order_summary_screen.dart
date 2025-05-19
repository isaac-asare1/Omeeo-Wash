import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: CustomAppBar(
        displayLogo: false,
        title: "Order Summary",
        titleStyle: TextStyle(
          fontSize: 18,
          color: whiteText,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BenefitRow(text: 'Vetted operators'),
                  BenefitRow(text: 'Rated excellent on Trustpilot'),
                  BenefitRow(text: 'Relax while your car is cleaned'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SectionHeader(title: "Date & Time*"),
            SummaryTile(
              title: "Saturday 31st May 2025",
              subtitle: "02:00 PM",
              icon: Icons.edit_calendar_outlined,
            ),

            SectionHeader(title: "Location for Wash*"),
            SummaryTile(title: "Oxford OX1 1PE, UK"),

            SectionHeader(title: "Vehicle"),
            SummaryTile(
              title: "Audi Q4 E-tron Sport 40 - 5CAM",
              subtitle: "Blue",
            ),

            SectionHeader(title: "Subscribe"),
            SummaryTile(title: "Select frequency"),

            SectionHeader(title: "Services"),
            SummaryTile(title: "Mini Valet", subtitle: "£40 · 2hr"),

            SectionHeader(title: "Optional Extras"),
            SummaryTile(title: "Pet hair removal", subtitle: "£40 · 1hr"),

            SectionHeader(title: "Washer"),
            SummaryTile(
              title: "James D.",
              subtitle: " Water Not Provided    🔌 Electricity Not Provided",
            ),

            const SizedBox(height: 24),

            CostSummaryRow(label: "Subtotal", value: "£40"),
            CostSummaryRow(label: "Optional Extras", value: "£40"),
            CostSummaryRow(label: "Service Charge", value: "£1.50"),
            const Divider(),
            CostSummaryRow(label: "Total", value: "£81.50", isBold: true),

            const SizedBox(height: 24),

            OmeeoButton(
              text: "Continue",
              onPressed: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitRow extends StatelessWidget {
  final String text;
  const BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check, size: 20, color: Colors.black),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  const SummaryTile({required this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 20, color: Colors.black),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CostSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const CostSummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "· $label",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
