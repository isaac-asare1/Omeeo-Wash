// ✅ Custom AppBar
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? displayLogo;
  final String? title;
  final TextStyle? titleStyle;
  const CustomAppBar({
    super.key,
    this.title = "OmeeoWash",
    this.displayLogo = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.primaryVariant,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorPalette.textColor),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Row(
        children: [
          if (displayLogo!)
            Image.asset(
              'assets/images/omeeo_logo.png', // your sponge icon
              height: 50,
            ),
          const SizedBox(width: 8),
          Text(
            title!,
            style:
                titleStyle ??
                TextStyle(
                  color: ColorPalette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ✅ Custom TextField
class CustomTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final String label;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.textInputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = false;

  void toggleObsecure() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              color: ColorPalette.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: widget.textInputType,
            obscureText: obscure,
            decoration: InputDecoration(
              suffixIcon:
                  widget.obscureText
                      ? GestureDetector(
                        onTap: () {
                          toggleObsecure();
                        },
                        child: Icon(
                          obscure
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 20,
                        ),
                      )
                      : const SizedBox.shrink(),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: hintTextColor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: hintTextColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: hintTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final bool? allowBorder;
  final Color? bgColor;
  final List<String> dropdownItemsList;
  final String? label;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.dropdownItemsList,
    this.bgColor,
    this.allowBorder = true,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String value;

  @override
  void initState() {
    super.initState();
    value =
        widget.dropdownItemsList.isNotEmpty ? widget.dropdownItemsList[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        const SizedBox(height: 8),
        Container(
          //width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: widget.bgColor ?? null,
            border:
                widget.allowBorder!
                    ? Border.all(color: Colors.grey.shade400)
                    : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              items:
                  widget.dropdownItemsList
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: hintTextColor,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              value: value,
              onChanged: (newValue) {
                if (newValue == widget.dropdownItemsList[0]) return;
                setState(() {
                  value = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Yes/No Toggle Widget
class CustomToggleQuestion extends StatefulWidget {
  final String question;
  const CustomToggleQuestion({super.key, required this.question});

  @override
  State<CustomToggleQuestion> createState() => _CustomToggleQuestionState();
}

class _CustomToggleQuestionState extends State<CustomToggleQuestion> {
  bool? isYes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 400,
          child: Text(
            widget.question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 4,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: Row(
            children: [
              Expanded(
                child: OmeeoButton(
                  text: 'Yes',
                  onPressed: () => setState(() => isYes = true),
                  backgroundColor: isYes == true ? lightGreen : backgroundColor,
                  textColor: isYes == true ? whiteText : hintTextColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OmeeoButton(
                  text: 'No',
                  onPressed: () => setState(() => isYes = false),
                  backgroundColor:
                      isYes == false ? lightGreen : backgroundColor,
                  textColor: isYes == false ? whiteText : hintTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final TextDecoration? decoration;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.maxLines,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? darkText,
        decoration: decoration,
      ),
    );
  }
}

class LnProgressIndicator extends StatelessWidget {
  final double value;
  const LnProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: hintTextColor,
        color: amber,
        minHeight: 4,
      ),
    );
  }
}

//For order summary screen
class BenefitRow extends StatelessWidget {
  final String text;
  const BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(FontAwesomeIcons.check, size: 20, color: darkText),
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
        style: const TextStyle(color: hintTextColor, fontSize: 14),
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
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 20, color: darkText),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(color: hintTextColor)),
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
            "• $label",
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

class CheckCircle extends StatefulWidget {
  const CheckCircle({super.key});

  @override
  State<CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        padding: EdgeInsets.all(2),
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 234, 232, 232),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            weight: 1000,
            FontAwesomeIcons.check,
            color: isChecked ? lightGreen : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

////
class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(item, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

//CORE
class LocationDropdown extends StatefulWidget {
  const LocationDropdown({super.key});

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  final List<String> myLocations = [
    'Accra GA-184-1234 GH',
    'Kumasi AK-039-5021 GH',
    'Takoradi WS-101-5567 GH',
  ];

  String? selectedLocation = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(FontAwesomeIcons.locationDot, size: 15, color: whiteText),
        const SizedBox(width: 8),
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: IntrinsicWidth(
            child: DropdownButton<String>(
              isExpanded: true,
              borderRadius: BorderRadius.circular(8),
              value:
                  selectedLocation!.length < 1
                      ? myLocations[0]
                      : selectedLocation,
              dropdownColor: const Color.fromARGB(220, 0, 0, 0),
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  FontAwesomeIcons.chevronDown,
                  size: 15,
                  color: whiteText,
                ),
              ),
              underline: const SizedBox(),
              style: const TextStyle(
                color: whiteText,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLocation = newValue!;
                });
              },
              items:
                  myLocations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: whiteText),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
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
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: scaffoldBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 10, color: Colors.blue),
          SizedBox(width: 2),
          Text(message, style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
