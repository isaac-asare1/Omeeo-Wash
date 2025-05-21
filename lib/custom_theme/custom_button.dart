import 'package:flutter/material.dart';
import 'color_palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        backgroundColor: backgroundColor ?? ColorPalette.backgroundColor,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
        ),
      ),
      child: child ?? Container(),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.title,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.width,
    super.key,
  });
  final VoidCallback? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ColorPalette.backgroundColor,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

////////
class OmeeoButton extends StatelessWidget {
  final bool? allowBorder;
  final Widget? child;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  const OmeeoButton({
    super.key,
    this.text = "text",
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.child,
    this.allowBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          allowBorder!
              ? BoxDecoration(
                border: Border.all(color: hintTextColor, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )
              : null,
      constraints: const BoxConstraints(maxWidth: 400),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? lightGreen,
            foregroundColor: textColor ?? ColorPalette.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          onPressed: onPressed,
          child:
              child ??
              Text(
                text!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
        ),
      ),
    );
  }
}
