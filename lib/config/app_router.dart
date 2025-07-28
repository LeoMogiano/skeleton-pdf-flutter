import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton_pdf/config/routes.dart';
import 'package:skeleton_pdf/screens/app_navigation.dart';
import 'package:skeleton_pdf/screens/compress/compress_info_screen.dart';
import 'package:skeleton_pdf/screens/compress/compression_level_screen.dart';
import 'package:skeleton_pdf/screens/config_screen.dart';
import 'package:skeleton_pdf/screens/history_screen.dart';
import 'package:skeleton_pdf/screens/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigator',
);

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.home.route,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppNavigation(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.home.name,
              path: Routes.home.route,
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(
                  name: Routes.compressLevel.name,
                  path: Routes.compressLevel.route,
                  builder: (context, state) => const CompressionLevelScreen(),
                ),
                GoRoute(
                  name: Routes.compressInfo.name,
                  path: Routes.compressInfo.route,
                  builder: (context, state) => const CompressInfoScreen(),
                ),
              ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.history.name,
              path: Routes.history.route,
              builder: (context, state) => const HistoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routes.config.name,
              path: Routes.config.route,
              builder: (context, state) => const ConfigScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
