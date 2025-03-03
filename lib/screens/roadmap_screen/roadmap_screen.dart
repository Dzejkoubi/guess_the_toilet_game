import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_the_toilet/app/constants/game_constants.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/main.dart';
import 'package:guess_the_toilet/screens/game/levels_roadmap.dart';

@RoutePage()
class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roadmap'),
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
                onPressed: () {
                  AutoRouter.of(context).push(ProfileRoute());
                },
                icon: SvgPicture.asset(
                  'assets/icons/user_account_icon.svg',
                  height: 24,
                  width: 24,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FittedBox(
              child: SizedBox(
                width: GameConstants.gameWidth,
                height: GameConstants.gameHeight,
                child: GameWidgetWrap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameWidgetWrap extends StatefulWidget {
  const GameWidgetWrap({super.key});

  @override
  State<GameWidgetWrap> createState() => _GameWidgetWrapState();
}

class _GameWidgetWrapState extends State<GameWidgetWrap> {
  late final RoadmapGame game;

  @override
  void initState() {
    super.initState();
    game = RoadmapGame();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
