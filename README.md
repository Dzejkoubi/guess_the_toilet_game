🚽 Guess the Toilet - Flutter + Flame Game

Guess the Toilet is a fun and interactive game built with Flutter & Flame Engine. The goal is to find the correct urinal based on unspoken rules of men's restroom etiquette.

📸 Screenshots

TODO:

🎮 Features (In development)

✅ Intuitive Gameplay – Choose the right urinal without breaking the rules.✅ Pixel Art Style – Minimalist and funny visual design.✅ Progressive Difficulty – The levels get trickier as you go.✅ Leaderboard – Compete for the highest score.✅ Light & Dark Mode – UI adapts to the system theme.

🏗 Folder Structure

lib/
│── main.dart             # Entry point of the app
│
├── game/                 # Game logic and assets
│   ├── toilet_game.dart  # Main game logic
│   ├── player.dart       # Player mechanics
│   ├── world.dart        # Environment and levels
│   ├── loader.dart       # Game loader widget
│
├── screens/              # UI Screens
│   ├── welcome_screen.dart  # Welcome screen
│   ├── settings_screen.dart # Settings screen
│   ├── game_screen.dart     # Screen embedding the game
│
├── widgets/              # Reusable UI components
│   ├── custom_button.dart  # Styled buttons
│   ├── custom_text.dart    # Styled text
│   ├── custom_input.dart   # Styled text fields
│
├── theme/                # Global styling
│   ├── theme.dart        # Central theme configuration
│
├── assets/               # Game assets (images, sounds)
│   ├── images/           # Sprites and backgrounds
│   ├── audio/            # Sound effects and music

🚀 Installation & Running the Game

1️⃣ Clone the Repository

git clone https://github.com/YOUR_USERNAME/guess_the_toilet.git
cd guess_the_toilet

2️⃣ Install Dependencies

flutter pub get

3️⃣ Run the Game

flutter run

✅ The game will start on Android, iOS, or Web!

🔧 Dependencies

name: guess_the_toilet
description: "A new Flutter project."
publish_to: "none"
version: 0.1.0

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter
  auto_route_generator: ^9.0.0
  auto_route: ^9.2.2
  flutter_native_splash: ^2.4.4
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  flame: ^1.24.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.14
  flutter_launcher_icons: ^0.14.3

flutter_launcher_icons:
  android: true
  ios: true
  remove_alpha_ios: true
  image_path: "assets/icon/icon.png" # Path to your icon
  # flutter pub run flutter_launcher_icons:main - to use the changes

flutter:
  generate: true
  uses-material-design: true
  assets:
    - assets/icon/icon.png
    - assets/images/


(Check pubspec.yaml for the latest versions)

❤️ Contributing

Want to improve the game? Fork this repo and submit a pull request!

📩 Contact

For any questions or suggestions, feel free to reach out:

GitHub Issues: Create an Issue

Email: kubakraus06@gmail.com

🚀 Have fun playing Guess the Toilet! 🚀

