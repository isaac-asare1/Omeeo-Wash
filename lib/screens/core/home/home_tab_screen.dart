import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';
import 'package:ommeoWash/helpers/dummy_list.dart';
import 'package:ommeoWash/screens/core/home/dialogues.dart';
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
                      padding: EdgeInsets.only(top: 5),
                      color: lightPurple,
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
              fontSize: FontSizes.md,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 2,
            width: 100,
            color: _selectedTab == index ? darkPurple : null,
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
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.push('/core/service_type');
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
                                color: lightPurple,
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
                                color: lightPurple,
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
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText('Top Washers', fontSize: FontSizes.md),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children:
                topWashers.map((washer) {
                  final String reviewLength =
                      washer["reviews"].length.toString();
                  return WasherCard(
                    name: washer["name"],
                    priceRange: washer["priceRange"],
                    rating: washer["rating"],
                    score: washer["score"],
                    reviewCount: reviewLength,
                    availableDate: washer["availableDate"],
                    availability: washer["availability"],
                    isElectricityProvided: washer["isElectricityProvided"],
                    isWaterProvided: washer["isWaterProvided"],
                    reviews: washer["reviews"],
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

  const ValetServiceCard({
    super.key,
    required this.description,
    required this.context,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.push('/core/extras');
      },
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
                    child: SeeDetailButton(),
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
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 16),
      color: darkPurple,
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

class WasherCard extends StatefulWidget {
  final List<String> availability;
  final String name, priceRange, rating, reviewCount, availableDate, score;
  final bool isWaterProvided, isElectricityProvided;
  final List reviews;

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
    required this.score,
    required this.reviews,
  });

  @override
  State<WasherCard> createState() => _WasherCardState();
}

class _WasherCardState extends State<WasherCard> {
  bool showContainer = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/core/services");
      },
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      color: scaffoldBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  "• ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: darkPurple,
                                    fontSize: FontSizes.lg,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: widget.priceRange,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: FontSizes.md,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                    'Available ${widget.availableDate}',
                    fontSize: 10,
                    color: hintTextColor,
                  ),
                  const SizedBox(height: 14),
                  AvailabilityDisplay(selectedDays: widget.availability),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      widget.isWaterProvided
                          ? CustomChipWidget(
                            message: 'Water provided',
                            icon: FontAwesomeIcons.droplet,
                          )
                          : CustomChipWidget(
                            message: 'Water Not provided',
                            icon: FontAwesomeIcons.droplet,
                          ),
                      const SizedBox(width: 4),
                      widget.isElectricityProvided
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
            ),

            Positioned(
              top: 15,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (int.parse(widget.reviewCount) > 0)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),

                        CustomText(
                          '${widget.rating}  |  ',
                          fontSize: FontSizes.md,
                          fontWeight: FontWeight.w500,
                          color: hintTextColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Dialogues().submitOrder(
                              context,
                              widget.reviews,
                              overallRating: widget.rating,
                              washersName: widget.name,
                            );
                          },
                          child: CustomText(
                            'See ${widget.reviewCount} review',
                            fontSize: FontSizes.md,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            color: hintTextColor,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 30),
                  if (int.parse(widget.reviewCount) > 0)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showCompletionScore(context, widget.score);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backgroundColor,
                            border: Border.all(
                              color:
                                  int.parse(widget.score) < 90
                                      ? amber
                                      : primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.score,
                              style: TextStyle(
                                fontSize: FontSizes.sm,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCompletionScore(BuildContext context, String score) {
    final int washerScore = int.parse(score);
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              right: 100,
              bottom: 120,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 224, 224),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'Completion score',
                            fontSize: FontSizes.sm,
                            fontWeight: FontWeight.bold,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                FontAwesomeIcons.x,
                                grade: 2,
                                size: FontSizes.sm,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        washerScore < 90
                            ? "The operator has fulfilled most of their bookings. However, it’s advisable to message them before booking to confirm their availability."
                            : "This operator has successfully completed 90% or more of their bookings and is considered highly reliable.",
                        fontSize: FontSizes.xs,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//Availability display for formationg days
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
      color: darkPurple,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Text(
          formatAvailability(selectedDays),
          style: TextStyle(fontSize: FontSizes.xs, color: whiteText),
        ),
      ),
    );
  }
}
