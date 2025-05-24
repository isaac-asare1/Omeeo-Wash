import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_button.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:pinput/pinput.dart';

class OtpFormScreen extends StatefulWidget {
  const OtpFormScreen({super.key});

  @override
  State<OtpFormScreen> createState() => _OtpFormScreenState();
}

class _OtpFormScreenState extends State<OtpFormScreen> {
  bool verifyPin = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: scaffoldBackground,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                CustomText(
                  "Please enter your verification code",
                  fontSize: 14,
                  color: hintTextColor,
                ),
                SizedBox(height: 20),
                CustomText(
                  "We have sent verification code to your provided mobile number.",
                  fontSize: 14,
                  color: hintTextColor,
                ),
                SizedBox(height: 30),
                PinPutForm(
                  verifyValue: () {
                    setState(() {
                      verifyPin = !verifyPin;
                    });
                  },
                  verifyPin: verifyPin,
                ),
                SizedBox(height: 30),
                OmeeoButton(
                  backgroundColor: verifyPin ? lightGreen : hintTextColor,
                  text: "Continue",
                  onPressed: () {
                    GoRouter.of(context).go('/core');
                  },
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: CustomText('Resend', color: amber, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PinPutForm extends StatelessWidget {
  final Function verifyValue;
  final bool verifyPin;
  const PinPutForm({
    super.key,
    required this.verifyValue,
    required this.verifyPin,
  });

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultTheme = PinTheme(
      decoration: BoxDecoration(
        border: Border.all(color: darkText),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: backgroundColor,
      ),
      width: 68,
      height: 64,
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
    return Pinput(
      defaultPinTheme: defaultTheme,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      focusedPinTheme: defaultTheme.copyBorderWith(
        border: Border.all(color: lightGreen, width: 2),
      ),
      errorPinTheme: defaultTheme.copyBorderWith(
        border: Border.all(color: errorColor, width: 2),
      ),
      errorBuilder: (errorText, pin) {
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomText("Incorrect pin", fontSize: 14, color: errorColor),
        );
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: (value) {
        print('OTP: ${value}');
        if (value == '3340') {
          verifyValue();
          return null;
        } else {
          return "Incorrect pin";
        }
      },
      onChanged: (value) {
        if (value.length > 2 && verifyPin == true) {
          verifyValue();
        }
      },
      // onSubmitted: (value) {
      //   print('onSubmit OTP: ${value}');
      // },
    );
  }
}
