import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/dummy_list.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});
  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'Frequently asked questions',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome to our comprehensive list of Frequently asked questions for customers of the OmeeoWash app.'
                    'If you’re a mobile car valeter or detailer, see our FAQs for mobile operators here.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(faqs.length, (index) {
                    final isExpanded = index == expandedIndex;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            faqs[index]['question']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isExpanded ? amber : Colors.black,
                            ),
                          ),
                          trailing: Icon(
                            isExpanded ? Icons.remove : Icons.add,
                            color: isExpanded ? amber : Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              expandedIndex = isExpanded ? null : index;
                            });
                          },
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(faqs[index]['answer']!),
                          ),
                        Divider(),
                      ],
                    );
                  }),
                  SizedBox(height: 80),
                  //Footer
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(
                          text:
                              'Still have a question? You can reach us via our ',
                        ),
                        TextSpan(
                          text: 'Contact Form here.',
                          style: TextStyle(color: amber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightPurple,
      child: Column(
        children: [
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              Icon(Icons.facebook, color: whiteText),
              Icon(Icons.camera_alt, color: whiteText),
              Icon(Icons.music_note, color: whiteText),
              Icon(Icons.play_circle_filled, color: whiteText),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              Image.asset(
                'assets/images/omeeo_logo.png',
                height: 50,
              ), // Replace with your asset
              Image.asset(
                'assets/images/omeeo_logo.png',
                height: 50,
              ), // Replace with your asset
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Excellent  4.8 out of 5  ',
            style: TextStyle(fontSize: 16, color: darkText),
          ),
          const Text(
            '⭐ Trustpilot',
            style: TextStyle(fontSize: 16, color: darkText),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'OmeeoWash Marketplace Ltd registered in Ghana under the company registration number 13764339. ',
              textAlign: TextAlign.center,
              style: TextStyle(color: darkText, fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '© 2025 OmeeoWash Marketplace Ltd. All Rights Reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(color: darkText, fontSize: 12),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
