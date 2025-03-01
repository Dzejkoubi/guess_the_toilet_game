// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:guess_the_toilet/screens/account_screen/account_screen.dart'
    as _i1;
import 'package:guess_the_toilet/screens/leaderboard/leader_board_screen.dart'
    as _i2;
import 'package:guess_the_toilet/screens/login_screen/login_screen.dart' as _i3;
import 'package:guess_the_toilet/screens/roadmap_screen/roadmap_screen.dart'
    as _i4;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i5.PageRouteInfo<AccountRouteArgs> {
  AccountRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
    : super(
        AccountRoute.name,
        args: AccountRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'AccountRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountRouteArgs>(
        orElse: () => const AccountRouteArgs(),
      );
      return _i1.AccountScreen(key: args.key);
    },
  );
}

class AccountRouteArgs {
  const AccountRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'AccountRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LeaderBoardScreen]
class LeaderBoardRoute extends _i5.PageRouteInfo<void> {
  const LeaderBoardRoute({List<_i5.PageRouteInfo>? children})
    : super(LeaderBoardRoute.name, initialChildren: children);

  static const String name = 'LeaderBoardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LeaderBoardScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.RoadmapScreen]
class RoadmapRoute extends _i5.PageRouteInfo<void> {
  const RoadmapRoute({List<_i5.PageRouteInfo>? children})
    : super(RoadmapRoute.name, initialChildren: children);

  static const String name = 'RoadmapRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.RoadmapScreen();
    },
  );
}
