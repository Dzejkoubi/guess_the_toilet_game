🚽 Guess the Toilet - Flutter + Flame Game

Guess the Toilet is a fun and interactive game built with Flutter & Flame Engine. <br>
The goal is to find the correct urinal based on unspoken rules of men's restroom etiquette.

📸 Screenshots

TODO:

🎮 Features (In development) <br>
✅ Intuitive Gameplay – Choose the right urinal without breaking the rules. <br>
✅ Pixel Art Style – Minimalist and funny visual design. <br>
✅ Progressive Difficulty – The levels get trickier as you go. <br>
✅ Leaderboard – Compete for the highest score. <br>
✅ Light & Dark Mode – UI adapts to the system theme.

🏗 Folder Structure

lib/ <br>
│── main.dart # Entry point of the app <br>
│ <br>
├── game/ # Game logic and assets <br>
│ ├── toilet_game.dart # Main game logic <br>
│ ├── player.dart # Player mechanics <br>
│ ├── world.dart # Environment and levels <br>
│ ├── loader.dart # Game loader widget <br>
│ <br>
├── screens/ # UI Screens <br>
│ ├── welcome_screen.dart # Welcome screen <br>
│ ├── settings_screen.dart # Settings screen <br>
│ ├── game_screen.dart # Screen embedding the game <br>
│ <br>
├── widgets/ # Reusable UI components <br>
│ ├── custom_button.dart # Styled buttons <br>
│ ├── custom_text.dart # Styled text <br>
│ ├── custom_input.dart # Styled text fields <br>
│ <br>
├── theme/ # Global styling <br>
│ ├── theme.dart # Central theme configuration <br>
│ <br>
├── assets/ # Game assets (images, sounds) <br>
│ ├── images/ # Sprites and backgrounds <br>
│ ├── audio/ # Sound effects and music

🚀 Installation & Running the Game

1️⃣ Clone the Repository

`git clone https://github.com/Dzejkoubi/guess_the_toilet_game`

`cd guess_the_toilet`

2️⃣ Install Dependencies

`flutter pub get`

3️⃣ Run the Game

`flutter run`

- in different terminal run the following command to start the app:

`flutter pub run build_runner watch`

- this command will watch for changes in the files and generate the required files - flutter router

- in different terminal run the following command to start the app:

`dart run flutter_native_splash:create --path=flutter_native_splash.yaml`

- this command will generate the splash screen for the app

`flutter gen-l10n`

- this command will generate the language localizations for the app

A new Flutter project.
