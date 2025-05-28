import 'package:go_router/go_router.dart';
import 'package:ommeoWash/screens/auth_screens/singup_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/optional_extras_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/order_summary_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/otp_form_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_cleaner.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_date_screen.dart';
import 'package:ommeoWash/screens/find_washer_screens/select_service_screen.dart';

final List<GoRoute> extraServicesFlowRoutes = [
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
            builder:
                (context, state) =>
                    SelectCleaner(path: "${state.uri.toString()}/summary"),
            routes: [
              GoRoute(
                path: 'summary',
                builder:
                    (context, state) => OrderSummaryScreen(
                      path: "${state.uri.toString()}/signup",
                    ),
                routes: [
                  GoRoute(
                    path: 'signup',
                    builder:
                        (context, state) =>
                            SingupScreen(path: "${state.uri.toString()}/otp"),
                    routes: [
                      GoRoute(
                        path: 'otp',
                        builder: (context, state) => OtpFormScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
final List<GoRoute> serviceFlowRouteAfterChoosingWahser = [
  GoRoute(
    path: 'services',
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
                    SelectDateScreen(path: "${state.uri.toString()}/summary"),
            routes: [
              GoRoute(
                path: 'summary',
                builder:
                    (context, state) => OrderSummaryScreen(
                      path: "${state.uri.toString()}/signup",
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

// final List<GoRoute> serviceFlowRoutes = [
//   GoRoute(
//     path: 'service_type',
//     builder: (context, state) => const SelectServiceScreen(),
//     routes: [
//       GoRoute(
//         path: 'extras',
//         builder:
//             (context, state) =>
//                 OptionalExtrasScreen(path: "${state.uri.toString()}/date"),
//         routes: [
//           GoRoute(
//             path: 'date',
//             builder:
//                 (context, state) =>
//                     SelectDateScreen(path: "${state.uri.toString()}/cleaner"),
//             routes: [
//               GoRoute(
//                 path: 'cleaner',
//                 builder:
//                     (context, state) =>
//                         SelectCleaner(path: "${state.uri.toString()}/summary"),
//                 routes: [
//                   GoRoute(
//                     path: 'summary',
//                     builder:
//                         (context, state) => OrderSummaryScreen(
//                           path: "${state.uri.toString()}/signup",
//                         ),
//                     routes: [
//                       GoRoute(
//                         path: 'signup',
//                         builder:
//                             (context, state) => SingupScreen(
//                               path: "${state.uri.toString()}/otp",
//                             ),
//                         routes: [
//                           GoRoute(
//                             path: 'otp',
//                             builder: (context, state) => OtpFormScreen(),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   ),
// ];
