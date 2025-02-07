// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:guess_the_toilet/screens/roadmap_screen/roadmap_screen.dart'
    as _i1;
import 'package:guess_the_toilet/screens/welcome_screen/welcome_screen.dart'
    as _i2;

/// generated route for
/// [_i1.RoadmapScreen]
class RoadmapRoute extends _i3.PageRouteInfo<void> {
  const RoadmapRoute({List<_i3.PageRouteInfo>? children})
      : super(
          RoadmapRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoadmapRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.RoadmapScreen();
    },
  );
}

/// generated route for
/// [_i2.WelcomeScreen]
class WelcomeRoute extends _i3.PageRouteInfo<void> {
  const WelcomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.WelcomeScreen();
    },
  );
}
