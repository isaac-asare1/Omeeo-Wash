import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                      color: primaryColor,
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
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: _selectedTab == 0 ? WashingTab() : DetailingTab(),
                    ),
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
            color: _selectedTab == index ? darkGreen : primaryColor,
          ),
        ],
      ),
    );
  }
}

class WashingTab extends StatefulWidget {
  const WashingTab({super.key});

  @override
  State<WashingTab> createState() => _WashingTabState();
}

class _WashingTabState extends State<WashingTab> {
  String selectedService = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 12,
          runSpacing: 12,

          children:
              detailingServices.map((service) {
                return ValetServiceCard(
                  description: service['description'],
                  context: context,
                  title: service['title'],
                  imagePath: service['image'],
                  isSelected: selectedService == 'Full Detailing',
                  onSelect: () {
                    setState(() {
                      selectedService = service['title'];
                    });
                  },
                );
              }).toList(),
        ),
        SizedBox(height: 20),
        Container(
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
                        Image.asset('assets/images/omeeo_logo.png', height: 25),
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
                      'Book a service worth £60 or more',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.local_car_wash, color: Colors.white, size: 48),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: const [
              WasherCard(
                name: 'Darren M',
                priceRange: '¢40 - ¢140',
                rating: '5',
                reviewCount: '1',
                availableDate: '15/05/2025',
                availability: 'Monday - Friday',
              ),
              SizedBox(width: 12),
              WasherCard(
                name: 'Muhammad K',
                priceRange: '¢50 - ¢160',
                rating: '4.8',
                reviewCount: '3',
                availableDate: '15/05/2025',
                availability: 'Monday,tuesday,wednesday,thursday, friday ',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
  final bool isSelected;
  final VoidCallback onSelect;
  const ValetServiceCard({
    super.key,
    required this.description,
    required this.context,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.only(right: 5, bottom: 5, left: 5),
          height: 125,
          width: 106,
          decoration: BoxDecoration(
            color: isSelected ? lightGreen : backgroundColor,
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
                    child: Icon(
                      Icons.help_outline,
                      color: isSelected ? whiteText : hintTextColor,
                    ),
                  ),
                ),
              ),
              Center(child: Image.asset(imagePath, height: 50, width: 50)),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? whiteText : null,
                ),
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
      padding: const EdgeInsets.all(16),
      color: lightGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LocationDropdown(),
              Spacer(),
              Icon(FontAwesomeIcons.plus, color: whiteText, size: 17),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: primaryColor,
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
  final String name,
      priceRange,
      rating,
      reviewCount,
      availableDate,
      availability;

  const WasherCard({
    super.key,
    required this.name,
    required this.priceRange,
    required this.rating,
    required this.reviewCount,
    required this.availableDate,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "•",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: amber,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: priceRange,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              Text('$rating  |  See $reviewCount review'),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('Available $availableDate'),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
              border: null,
            ),
            child: Text(availability),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Chip(
                label: const Text('Water '),
                backgroundColor: Colors.blue[50],
              ),
              const SizedBox(width: 4),
              Chip(
                label: const Text('Electricity '),
                backgroundColor: Colors.yellow[50],
              ),
            ],
          ),
        ],
      ),
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

final List<Map<String, dynamic>> topWashers = [
  {
    'name': 'Darren M.',
    'priceRange': '£40 - £140',
    'rating': '5',
    'reviewCount': '1',
    'availableDate': '15/05/2025',
    'availability': ['Saturday', 'Sunday', "Wednesday"],
    'isWaterProvided': false,
    'isElectricityProvided': true,
  },
  {
    'name': 'Muhammad K.',
    'priceRange': '£40 - £140',
    'rating': '4.8',
    'reviewCount': '5',
    'availableDate': '15/05/2025',
    'availability': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
    'isWaterProvided': false,
    'isElectricityProvided': false,
  },
  {
    'name': 'Muhammad K.',
    'priceRange': '£40 - £140',
    'rating': '4.8',
    'reviewCount': null,
    'availableDate': '15/05/2025',
    'availability': [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ],
    'isWaterProvided': true,
    'isElectricityProvided': true,
  },
];

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
    return Text(
      formatAvailability(selectedDays),
      style: TextStyle(fontSize: 16),
    );
  }
}
