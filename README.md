🚽 Guess the Toilet - Flutter + Flame Game

Guess the Toilet is a fun and interactive game built with Flutter & Flame Engine. The goal is to find the correct urinal based on unspoken rules of men's restroom etiquette.

📸 Screenshots

TODO:

🎮 Features (In development)

✅ Intuitive Gameplay – Choose the right urinal without breaking the rules.✅ Pixel Art Style – Minimalist and funny visual design.✅ Progressive Difficulty – The levels get trickier as you go.✅ Leaderboard – Compete for the highest score.✅ Light & Dark Mode – UI adapts to the system theme.

🏗 Folder Structure

lib/
│── main.dart # Entry point of the app
│
├── game/ # Game logic and assets
│ ├── toilet_game.dart # Main game logic
│ ├── player.dart # Player mechanics
│ ├── world.dart # Environment and levels
│ ├── loader.dart # Game loader widget
│
├── screens/ # UI Screens
│ ├── welcome_screen.dart # Welcome screen
│ ├── settings_screen.dart # Settings screen
│ ├── game_screen.dart # Screen embedding the game
│
├── widgets/ # Reusable UI components
│ ├── custom_button.dart # Styled buttons
│ ├── custom_text.dart # Styled text
│ ├── custom_input.dart # Styled text fields
│
├── theme/ # Global styling
│ ├── theme.dart # Central theme configuration
│
├── assets/ # Game assets (images, sounds)
│ ├── images/ # Sprites and backgrounds
│ ├── audio/ # Sound effects and music

🚀 Installation & Running the Game

1️⃣ Clone the Repository

git clone https://github.com/Dzejkoubi/guess_the_toilet_game
cd guess_the_toilet

2️⃣ Install Dependencies

flutter pub get

3️⃣ Run the Game

flutter run

- in different terminal run the following command to start the app:

flutter pub run build_runner watch

- this command will watch for changes in the files and generate the required files - flutter router

- in different terminal run the following command to start the app:

dart run flutter_native_splash:create --path=flutter_native_splash.yaml

- this command will generate the splash screen for the app

flutter gen-l10n

- this command will generate the language localizations for the app

A new Flutter project.
