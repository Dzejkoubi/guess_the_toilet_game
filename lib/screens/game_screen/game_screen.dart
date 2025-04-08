import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart' show GameWidget;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guess_the_toilet/app/constants/game_constants.dart';
import 'package:guess_the_toilet/app/constants/style_constants.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/screens/game/guess_the_toilet.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/correct_answer_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/e_action_button.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_button.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/pause_menu.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/time_indicator.dart';
import 'package:guess_the_toilet/screens/game_screen/overlays/wrong_answer_menu.dart';
import 'package:guess_the_toilet/services/providers/user_provider.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  UserProvider _userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).roadmap_title),
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
                  ;
                  _userProvider.loadUserData();
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
  late final GuessTheToilet game;

  @override
  void initState() {
    super.initState();
    game = GuessTheToilet();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        PauseMenu.id: (BuildContext context, GuessTheToilet gamRef) =>
            PauseMenu(
              gameRef: gamRef,
            ),
        PauseButton.id: (BuildContext context, GuessTheToilet gamRef) =>
            PauseButton(),
        CorrectAnswerMenu.id: (BuildContext context, GuessTheToilet gamRef) =>
            CorrectAnswerMenu(
              gameRef: gamRef,
            ),
        WrongAnswerMenu.wrongAnswerId:
            (BuildContext context, GuessTheToilet gamRef) => WrongAnswerMenu(
                  gameRef: gamRef,
                  text: 'Wrong Toilet',
                ),
        WrongAnswerMenu.timeIsUpId:
            (BuildContext context, GuessTheToilet gamRef) => WrongAnswerMenu(
                  gameRef: gamRef,
                  text: 'Time\'s up!',
                ),
        TimeIndicator.id: (BuildContext context, GuessTheToilet gameRef) =>
            TimeIndicator(
              timeLimit:
                  gameRef.currentLevelIndex < gameRef.levelTimeLimits.length
                      ? gameRef.levelTimeLimits[gameRef.currentLevelIndex]
                      : 0,
              timeRemaining: gameRef.time,
              gameRef: gameRef,
            ),
        EActionButton.id: (BuildContext context, GuessTheToilet gameRef) =>
            EActionButton(game: gameRef),
      },
    );
  }
}
