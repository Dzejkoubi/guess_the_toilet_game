// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:guess_the_toilet/auth/auth_gate.dart' as _i1;
import 'package:guess_the_toilet/screens/leaderboard/leader_board_screen.dart'
    as _i2;
import 'package:guess_the_toilet/screens/login_screen/login_screen.dart' as _i3;
import 'package:guess_the_toilet/screens/profile_screen.dart/profile_screen.dart'
    as _i4;
import 'package:guess_the_toilet/screens/register_screen/register_screen.dart'
    as _i5;
import 'package:guess_the_toilet/screens/roadmap_screen/roadmap_screen.dart'
    as _i6;

/// generated route for
/// [_i1.AuthGate]
class AuthGate extends _i7.PageRouteInfo<void> {
  const AuthGate({List<_i7.PageRouteInfo>? children})
    : super(AuthGate.name, initialChildren: children);

  static const String name = 'AuthGate';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthGate();
    },
  );
}

/// generated route for
/// [_i2.LeaderBoardScreen]
class LeaderBoardRoute extends _i7.PageRouteInfo<void> {
  const LeaderBoardRoute({List<_i7.PageRouteInfo>? children})
    : super(LeaderBoardRoute.name, initialChildren: children);

  static const String name = 'LeaderBoardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LeaderBoardScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.ProfileScreen]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i5.RegisterScreen]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i6.RoadmapScreen]
class RoadmapRoute extends _i7.PageRouteInfo<void> {
  const RoadmapRoute({List<_i7.PageRouteInfo>? children})
    : super(RoadmapRoute.name, initialChildren: children);

  static const String name = 'RoadmapRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.RoadmapScreen();
    },
  );
}
