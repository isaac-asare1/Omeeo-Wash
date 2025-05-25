import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/helpers/dummy_list.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_service_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            CustomHomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      color: lightGreen,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabItem('Washing', 0),
                          SizedBox(width: 30),
                          _buildTabItem('Detailing', 1),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TabContent(selectedTab: _selectedTab),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Column(
        children: [
          Center(
            child: CustomText(
              title,
              color: darkText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 2,
            width: 80,
            color: _selectedTab == index ? darkGreen : lightGreen,
          ),
        ],
      ),
    );
  }
}

class TabContent extends StatefulWidget {
  final int selectedTab;
  const TabContent({super.key, required this.selectedTab});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  String selectedService = '';
  List<Map<String, dynamic>> get Services =>
      widget.selectedTab == 0 ? washingServices : detailingServices;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 12,
                runSpacing: 12,

                children:
                    Services.map((service) {
                      return ValetServiceCard(
                        description: service['description'],
                        context: context,
                        title: service['title'],
                        imagePath: service['image'],

                        onSelect: () {
                          setState(() {
                            selectedService = service['title'];
                          });
                        },
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.push('/service_type');
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/omeeo_logo.png',
                                  height: 25,
                                ),
                                const SizedBox(width: 0),
                                Text(
                                  'OmeeoWash',
                                  style: TextStyle(
                                    color: ColorPalette.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Get 10% off',
                              style: TextStyle(
                                color: lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Book a service worth ¢60 or more',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Eplore Now',
                                style: TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.local_car_wash,
                        color: Colors.white,
                        size: 48,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: CustomText('Top Washers', fontSize: 16),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 210,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children:
                topWashers.map((washer) {
                  return WasherCard(
                    name: washer["name"],
                    priceRange: washer["priceRange"],
                    rating: washer["rating"],
                    reviewCount: washer["reviewCount"],
                    availableDate: washer["availableDate"],
                    availability: washer["availability"],
                    isElectricityProvided: washer["isElectricityProvided"],
                    isWaterProvided: washer["isWaterProvided"],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class ValetServiceCard extends StatelessWidget {
  final Map<String, dynamic> description;
  final BuildContext context;
  final String title;
  //final String priceRange;
  final String imagePath;
  final VoidCallback onSelect;
  const ValetServiceCard({
    super.key,
    required this.description,
    required this.context,
    required this.title,
    required this.imagePath,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onSelect,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.only(right: 5, bottom: 5, left: 5),
          height: 130,
          width:
              deviceWidth > 350
                  ? MediaQuery.of(context).size.width * 0.28
                  : 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      showServiceDeatals(context, title, description);
                    },
                    child: Icon(Icons.help_outline, color: hintTextColor),
                  ),
                ),
              ),
              Center(child: Image.asset(imagePath, height: 50, width: 50)),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
      color: darkGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LocationDropdown(),
              Spacer(),
              Icon(
                FontAwesomeIcons.plus,
                color: whiteText,
                size: 20,
                weight: 700,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: whiteText,
              // border: Border.all(
              //   color: const Color.fromARGB(255, 252, 232, 232),
              // ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              cursorColor: darkText,
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Search for a service',
                border: InputBorder.none,
                hintStyle: TextStyle(color: const Color.fromARGB(145, 0, 0, 0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class WasherCard extends StatelessWidget {
  final List<String> availability;
  final String name, priceRange, rating, reviewCount, availableDate;

  final bool isWaterProvided, isElectricityProvided;

  const WasherCard({
    super.key,
    required this.name,
    required this.priceRange,
    required this.rating,
    required this.reviewCount,
    required this.availableDate,
    required this.availability,
    this.isWaterProvided = false,
    this.isElectricityProvided = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),

      constraints: BoxConstraints(maxWidth: 450, minWidth: 280),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        "• ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,

                          color: lightGreen,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: priceRange,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkText,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 14),
                  CustomText(
                    '$rating  |  See $reviewCount review',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomText(
            'Available $availableDate',
            fontSize: 12,
            color: hintTextColor,
          ),
          const SizedBox(height: 14),
          AvailabilityDisplay(selectedDays: availability),
          const SizedBox(height: 4),
          Row(
            children: [
              isWaterProvided
                  ? CustomChipWidget(
                    message: 'Water provided',
                    icon: FontAwesomeIcons.handHoldingDroplet,
                  )
                  : CustomChipWidget(
                    message: 'Water Not provided',
                    icon: FontAwesomeIcons.droplet,
                  ),
              const SizedBox(width: 4),
              isElectricityProvided
                  ? CustomChipWidget(
                    message: 'Electricity provided',
                    icon: FontAwesomeIcons.boltLightning,
                  )
                  : CustomChipWidget(
                    message: 'Electricity Not provided',
                    icon: FontAwesomeIcons.boltLightning,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomChipWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  const CustomChipWidget({
    super.key,
    required this.message,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 12, color: Colors.blue),
      padding: EdgeInsets.zero,
      side: BorderSide.none,
      label: Text(message),
      backgroundColor: scaffoldBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      labelStyle: TextStyle(fontSize: 12),
    );
  }
}

class DetailingTab extends StatelessWidget {
  const DetailingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('detailing tab');
  }
}

class AvailabilityDisplay extends StatelessWidget {
  final List<String> selectedDays;

  AvailabilityDisplay({required this.selectedDays});

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String formatAvailability(List<String> selected) {
    if (selected.isEmpty) return "No days selected";

    // Sort according to weekDays order
    List<String> sortedSelected = List.from(selected)
      ..sort((a, b) => weekDays.indexOf(a).compareTo(weekDays.indexOf(b)));

    // Check if all selected days are consecutive in the weekDays list
    int startIndex = weekDays.indexOf(sortedSelected.first);
    List<String> consecutive = weekDays.sublist(
      startIndex,
      startIndex + sortedSelected.length,
    );

    if (consecutive.join() == sortedSelected.join()) {
      return "${sortedSelected.first} - ${sortedSelected.last}";
    }

    return sortedSelected.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: lightGreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Text(
          formatAvailability(selectedDays),
          style: TextStyle(fontSize: 12, color: whiteText),
        ),
      ),
    );
  }
}
