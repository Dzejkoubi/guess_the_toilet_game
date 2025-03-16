import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';

class GuessTheToilet extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;

  @override
  Future<void> onLoad() async {
    // Ensure all images are loaded before proceeding
    await images.loadAllImages();

    final World world = Level(
      levelName: 'lvl_1',
    );

    cam = CameraComponent.withFixedResolution(
      height: 640,
      width: 360,
      world: world,
    );
    cam.priority = 1;
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      world,
      cam,
    ]);
    return super.onLoad();
  }
}
