import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_theme/color_palette.dart';
import 'routing/go_router.dart' show router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'omeeoWash',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorPalette.scaffoldBackground,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: ColorPalette.textPrimary),
          bodyMedium: TextStyle(color: ColorPalette.textPrimary),
          titleLarge: TextStyle(color: ColorPalette.textPrimary),
        ),
        colorScheme: ColorScheme.light(primary: lightPurple),
      ),
      routerConfig: router,
    );
  }
}
