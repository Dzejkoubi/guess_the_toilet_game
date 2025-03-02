import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';

@RoutePage()
class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).push(LeaderBoardRoute());
            },
            icon: SvgPicture.asset(
              'assets/icons/leader_board_icon.svg',
              height: 32,
              width: 32,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/user_account_icon.svg',
                  height: 24,
                  width: 24,
                )),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the app!'),
      ),
    );
  }
}
