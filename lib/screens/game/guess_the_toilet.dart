import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:guess_the_toilet/screens/game/components/level.dart';

class GuessTheToilet extends FlameGame {
  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    final World world = Level(
      levelName: 'level-02',
    );
  }

  add(component);
}
