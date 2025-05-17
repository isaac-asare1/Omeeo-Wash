// ✅ Custom AppBar
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommeowash/custom_theme/color_palette.dart';
import 'package:ommeowash/custom_theme/custom_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
          Image.asset(
            'assets/images/omeeo_logo.png', // your sponge icon
            height: 50,
          ),
          const SizedBox(width: 8),
          const Text(
            'OmeeoWash',
            style: TextStyle(
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
  final List<String> dropdownItemsList;
  final String label;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.dropdownItemsList,
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
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          //width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
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
                if (newValue == "Please select") return;
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
        Text(
          widget.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
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
                backgroundColor: isYes == false ? lightGreen : backgroundColor,
                textColor: isYes == false ? whiteText : hintTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
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
