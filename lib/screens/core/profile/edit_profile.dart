import 'package:flutter/material.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  Color _saveButtonColor = hintTextColor;

  @override
  void initState() {
    super.initState();

    // Add listeners to update button color
    _firstNameController.addListener(_checkFields);
    _lastNameController.addListener(_checkFields);
    _firstNameController.text = 'James';
    _lastNameController.text = "Clementson";
  }

  void _checkFields() {
    setState(() {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final currentName = "JamesClementson".trim().toLowerCase();
      final newName = "${firstName}${lastName}".trim().toLowerCase();
      if (firstName.length < 2 ||
          firstName.length > 12 ||
          lastName.length < 2 ||
          lastName.length > 12 ||
          currentName == newName) {
        _saveButtonColor = hintTextColor;
      } else {
        _saveButtonColor = lightPurple;
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(displayLogo: false, title: "Edit Profile"),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorderlessTextField(
              label: 'First Name',
              hintText: 'First Name',
              textInputType: TextInputType.text,
              controller: _firstNameController,
            ),
            const SizedBox(height: 20),
            BorderlessTextField(
              label: 'Last Name',
              hintText: 'Last Name',
              textInputType: TextInputType.text,
              controller: _lastNameController,
            ),
            const SizedBox(height: 20),
            BorderlessTextField(
              label: "Email",
              hintText: 'Your email',
              textInputType: TextInputType.emailAddress,
              canBeEdited: false,
              width: 500,
            ),
            const Spacer(),
            OmeeoButton(
              text: "Save",
              backgroundColor: _saveButtonColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class BorderlessTextField extends StatelessWidget {
  final bool canBeEdited;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String hintText;
  final String label;
  final double? width;

  const BorderlessTextField({
    super.key,
    required this.hintText,
    required this.label,
    required this.textInputType,
    this.controller,
    this.canBeEdited = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, fontSize: FontSizes.md),
        SizedBox(height: 10),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: canBeEdited ? backgroundColor : lighHintText,
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              canBeEdited
                  ? Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                    ).copyWith(left: 10),
                    child: TextField(
                      controller: controller,
                      keyboardType: textInputType,
                      cursorColor: darkText,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.white,
                        decorationThickness: 0,
                      ),
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: hintTextColor,
                          fontSize: FontSizes.ml,
                        ),
                      ),
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.5,
                    ).copyWith(left: 10),
                    child: Text(
                      'solargate2719@gmail.com',
                      style: TextStyle(fontSize: FontSizes.ml),
                    ),
                  ),
        ),
      ],
    );
  }
}
