// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:guess_the_toilet/screens/game_screen/game_screen.dart' as _i2;
import 'package:guess_the_toilet/screens/leaderboard/leader_board_screen.dart'
    as _i3;
import 'package:guess_the_toilet/screens/login_screen/login_screen.dart' as _i4;
import 'package:guess_the_toilet/screens/profile_screen.dart/profile_screen.dart'
    as _i5;
import 'package:guess_the_toilet/screens/register_screen/register_screen.dart'
    as _i6;
import 'package:guess_the_toilet/services/auth/auth_gate.dart' as _i1;

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
/// [_i2.GameScreen]
class GameRoute extends _i7.PageRouteInfo<void> {
  const GameRoute({List<_i7.PageRouteInfo>? children})
    : super(GameRoute.name, initialChildren: children);

  static const String name = 'GameRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.GameScreen();
    },
  );
}

/// generated route for
/// [_i3.LeaderBoardScreen]
class LeaderBoardRoute extends _i7.PageRouteInfo<void> {
  const LeaderBoardRoute({List<_i7.PageRouteInfo>? children})
    : super(LeaderBoardRoute.name, initialChildren: children);

  static const String name = 'LeaderBoardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LeaderBoardScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.RegisterScreen]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterScreen();
    },
  );
}
