import 'package:auto_route/auto_route.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AccountRoute.page, initial: true),
        AutoRoute(page: RoadmapRoute.page),
      ];
}

// For update run: flutter pub run build_runner build
// For watch run: flutter pub run build_runner watch
