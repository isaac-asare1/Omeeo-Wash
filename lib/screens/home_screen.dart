import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../custom_theme/color_palette.dart';
import '../custom_theme/custom_button.dart';
import '../helpers/indicator_value_list.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool displaySplashScreen = true;

  void closeSplashScreen() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        displaySplashScreen = false;
      });
    });
  }

  @override
  void initState() {
    closeSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return displaySplashScreen
        ? SplashScreen()
        : Scaffold(
          // backgroundColor: darkGreen,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Image(
                image: AssetImage('assets/images/background_image.png'),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              // Background image
              // CachedNetworkImage(
              //   imageUrl: backgroundImageUrl,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: double.infinity,
              //   placeholder:
              //       (context, url) => const Center(
              //         child: SpinKitCircle(color: whiteText, size: 50.0),
              //       ),
              //   errorWidget:
              //       (context, url, error) =>
              //           const Center(child: Icon(Icons.error)),
              // ),

              // Overlay content
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x33000000), Color(0x1A000000)],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SetScroll(
                  ctx: context,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Image(
                        image: AssetImage('assets/images/omeeo_logo.png'),
                        height: 150,
                        width: 150,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'OmeeoWash',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Mobile Car Cleaning',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      MediaQuery.of(context).size.height < 400
                          ? const SizedBox()
                          : const Spacer(),
                      OmeeoButton(
                        text: "Find a Washer",
                        onPressed: () {
                          context.push('/set_location');
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: backgroundColor,
                              foregroundColor: darkText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                () {
                                  // ignore: use_build_context_synchronously
                                  context.push('/create_account');
                                },
                              );
                              Future.delayed(
                                const Duration(milliseconds: 600),
                                () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                              );
                            },
                            child:
                                isLoading == false
                                    ? const Text(
                                      'Join as a Business',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                    : const SpinKitCircle(
                                      color: lightGreen,
                                      size: 34.0,
                                    ),

                            // : const CircularProgressIndicator(
                            //   color: darkGreen,
                            // ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextSpan(
                              text: 'Log in',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                                color: ColorPalette.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // 👉 Put your navigation or action here
                                      // Example:
                                      context.push('/login');
                                    },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}

class SetScroll extends StatelessWidget {
  final BuildContext ctx;
  final Widget child;
  const SetScroll({super.key, required this.ctx, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          MediaQuery.of(ctx).size.height < 400
              ? SafeArea(child: SingleChildScrollView(child: child))
              : SizedBox(child: child),
    );
  }
}
