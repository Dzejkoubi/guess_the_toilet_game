# 🚽 Guess the Toilet - Flutter + Flame Game

**Guess the Toilet** is a fun and interactive game built with **Flutter & Flame Engine**. The goal is to find the correct urinal based on unspoken rules of men's restroom etiquette.

---

## 🎮 Features (Still in development)
✅ **Intuitive Gameplay** – Choose the right urinal without breaking the rules.  
✅ **Pixel Art Style** – Minimalist and funny visual design.  
✅ **Progressive Difficulty** – The levels get trickier as you go.  
✅ **Leaderboard** – Compete for the highest score.  
✅ **Light & Dark Mode** – UI adapts to the system theme.  

---

## 🏗 Folder Structure
lib/ │── main.dart # Entry point of the app │ ├── game/ # Game logic and assets │ ├── toilet_game.dart # Main game logic │ ├── player.dart # Player mechanics │ ├── world.dart # Environment and levels │ ├── loader.dart # Game loader widget │ ├── screens/ # UI Screens │ ├── welcome_screen.dart # Welcome screen │ ├── settings_screen.dart # Settings screen │ ├── game_screen.dart # Screen embedding the game │ ├── widgets/ # Reusable UI components │ ├── custom_button.dart # Styled buttons │ ├── custom_text.dart # Styled text │ ├── custom_input.dart # Styled text fields │ ├── theme/ # Global styling │ ├── theme.dart # Central theme configuration │ ├── assets/ # Game assets (images, sounds) │ ├── images/ # Sprites and backgrounds │ ├── audio/ # Sound effects and music

---

## 🚀 Installation & Running the Game

### 1️⃣ **Clone the Repository**
```sh
git clone https://github.com/YOUR_USERNAME/guess_the_toilet.git
cd guess_the_toilet
2️⃣ Install Dependencies
sh
Copy
Edit
flutter pub get
3️⃣ Run the Game
sh
Copy
Edit
flutter run
✅ The game will start on Android, iOS, or Web!

🔧 Dependencies
yaml
Copy
Edit
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.7.0
  flame_audio: ^2.0.2
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0
  firebase_core: ^2.15.0
  firebase_auth: ^4.7.0
  shared_preferences: ^2.2.0
(Check pubspec.yaml for the latest versions)

❤️ Contributing
Want to improve the game? Fork this repo and submit a pull request!












