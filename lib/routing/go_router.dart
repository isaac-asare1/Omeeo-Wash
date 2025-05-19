import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_cleaner.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_date_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_service_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/set_vehicle_registeration_screen.dart';
import 'package:ommeoWash/screens/home_screen.dart';

import '../screens/auth_screens/create_business_account.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/find_washer_screens/optional_extras_screen.dart';

import '../screens/find_washer_screens/select_vehicle_size_screen.dart';
import '../screens/find_washer_screens/set_location_screen.dart';

final List<GoRoute> serviceFlowRoutes = [
  GoRoute(
    path: 'service_type',
    builder: (context, state) => const SelectServiceScreen(),
    routes: [
      GoRoute(
        path: 'extras',
        builder:
            (context, state) =>
                OptionalExtrasScreen(path: "${state.uri.toString()}/date"),
        routes: [
          GoRoute(
            path: 'date',
            builder:
                (context, state) =>
                    SelectDateScreen(path: "${state.uri.toString()}/cleaner"),
            routes: [
              GoRoute(
                path: 'cleaner',
                builder: (context, state) => SelectCleaner(),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: 'create_account',
          builder: (context, state) => const CreateBusinessAccountScreen(),
        ),
        GoRoute(
          path: 'set_location',
          builder: (context, state) => const SetLocationScreen(),
          routes: [
            GoRoute(
              path: 'set_vehicle_reg',
              builder: (context, state) => const VehicleRegistrationScreen(),
              routes: [
                ...serviceFlowRoutes,
                GoRoute(
                  path: 'vehicle_size',
                  builder: (context, state) => const SelectVehicleSizeScreen(),
                  routes: serviceFlowRoutes,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    debugPrint('Unknown route: ${state.uri.toString()}');
    return const HomeScreen();
  },
);







// List<GoRoute> serviceFlowRoutes = [
//   GoRoute(
//     path: 'service_type',
//     builder: (context, state) => const SelectServiceScreen(),
//     routes: [
//       GoRoute(
//         path: 'extras',
//         builder: (context, state) => const OptionalExtrasScreen(),
//       ),
//     ],
//   ),
// ];

// final GoRouter router2= GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomeScreen(),
//       routes: [
//         GoRoute(
//           path: 'login',
//           builder: (context, state) => const LoginScreen(),
//         ),
//         GoRoute(
//           path: 'create_account',
//           builder: (context, state) => const CreateBusinessAccountScreen(),
//         ),
//         GoRoute(
//           path: 'set_location',
//           builder: (context, state) => const SetLocationScreen(),
//           routes: [
//             GoRoute(
//               path: 'set_vehicle_reg',
//               builder: (context, state) => const VehicleRegistrationScreen(),
//               routes: [
//                 ...serviceFlowRoutes,
//                 GoRoute(
//                   path: 'vehicle_size',
//                   builder: (context, state) => const SelectVehicleSizeScreen(),
//                   routes: serviceFlowRoutes,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );


                        // GoRoute(
                        //   path: 'extras',
                        //   builder: (context, state) {
                        //     //final String? previousPagePath = state.extra as String?;
                        //     return const OptionalExtrasScreen();
                        //   },
                        // ),
      //       routes: [
      // GoRoute(
      //   redirect: (context, state) {
      //     if (FirebaseAuth.instance.currentUser == null) {
      //       return "/auth/sign_in";
      //     } else {
      //       return null;
      //     }
      //   },
      //   path: "certificate",
      //   builder: (context, state) {
      //     return CertificationPage(
      //       courseId: state.pathParameters["course_id"]!,
      //     );
      //   },
      // ),
      //       ],


/* 
context.go('/profile', extra: userObject);
context.go('/productDetails', extra: productId);
connected to 192.168.100.107:5555
/home
/settings
/profile/:userId
/product/:productId
/cart
adb devices
adb shell ip route
adb tcpip 5555
adb connect 192.168.100.107

 */
