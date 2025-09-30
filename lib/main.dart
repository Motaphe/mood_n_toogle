import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

// Catppuccin Color Palette
class CatppuccinColors {
  static const Color base = Color(0xFF1E1E2E);
  static const Color mantle = Color(0xFF181825);
  static const Color crust = Color(0xFF11111B);
  static const Color text = Color(0xFFCDD6F4);
  static const Color subtext1 = Color(0xFFBAC2DE);
  static const Color subtext0 = Color(0xFFA6ADC8);
  static const Color overlay2 = Color(0xFF9399B2);
  static const Color overlay1 = Color(0xFF7F849C);
  static const Color overlay0 = Color(0xFF6C7086);
  static const Color surface2 = Color(0xFF585B70);
  static const Color surface1 = Color(0xFF45475A);
  static const Color surface0 = Color(0xFF313244);
  static const Color blue = Color(0xFF89B4FA);
  static const Color lavender = Color(0xFFB4BEFE);
  static const Color sapphire = Color(0xFF74C7EC);
  static const Color sky = Color(0xFF89DCEB);
  static const Color teal = Color(0xFF94E2D5);
  static const Color green = Color(0xFFA6E3A1);
  static const Color yellow = Color(0xFFF9E2AF);
  static const Color peach = Color(0xFFFAB387);
  static const Color maroon = Color(0xFFEBA0AC);
  static const Color red = Color(0xFFF38BA8);
  static const Color mauve = Color(0xFFCBA6F7);
  static const Color pink = Color(0xFFF5C2E7);
  static const Color flamingo = Color(0xFFF2CDCD);
  static const Color rosewater = Color(0xFFF5E0DC);
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = 'happy';
  String get currentMood => _currentMood;

  void setHappy() {
    _currentMood = 'happy';
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'sad';
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'excited';
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CatppuccinColors.blue,
          brightness: Brightness.dark,
          primary: CatppuccinColors.blue,
          secondary: CatppuccinColors.lavender,
          surface: CatppuccinColors.base,
          onPrimary: CatppuccinColors.base,
          onSecondary: CatppuccinColors.base,
          onSurface: CatppuccinColors.text,
        ),
        scaffoldBackgroundColor: CatppuccinColors.base,
        appBarTheme: const AppBarTheme(
          backgroundColor: CatppuccinColors.mantle,
          foregroundColor: CatppuccinColors.text,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CatppuccinColors.surface0,
            foregroundColor: CatppuccinColors.text,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: CatppuccinColors.text,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: CatppuccinColors.text,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: CatppuccinColors.subtext1,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: CatppuccinColors.subtext0,
            fontSize: 16,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mood Toggle Challenge',
          style: TextStyle(
            color: CatppuccinColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CatppuccinColors.base,
              CatppuccinColors.mantle,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'How are you feeling?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: CatppuccinColors.text,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CatppuccinColors.surface0,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: CatppuccinColors.overlay0.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const MoodDisplay(),
                ),
                const SizedBox(height: 50),
                const MoodButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  const MoodDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            _buildMoodIcon(moodModel.currentMood),
            const SizedBox(height: 16),
            Text(
              _getMoodText(moodModel.currentMood),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: CatppuccinColors.text,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMoodIcon(String mood) {
    switch (mood) {
      case 'happy':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: CatppuccinColors.yellow.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: CatppuccinColors.yellow.withValues(alpha: 0.5),
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.sentiment_very_satisfied,
            size: 60,
            color: CatppuccinColors.yellow,
          ),
        );
      case 'sad':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: CatppuccinColors.blue.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: CatppuccinColors.blue.withValues(alpha: 0.5),
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.sentiment_very_dissatisfied,
            size: 60,
            color: CatppuccinColors.blue,
          ),
        );
      case 'excited':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: CatppuccinColors.pink.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: CatppuccinColors.pink.withValues(alpha: 0.5),
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.celebration,
            size: 60,
            color: CatppuccinColors.pink,
          ),
        );
      default:
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: CatppuccinColors.surface1,
            borderRadius: BorderRadius.circular(60),
          ),
          child: const Icon(
            Icons.help_outline,
            size: 60,
            color: CatppuccinColors.text,
          ),
        );
    }
  }

  String _getMoodText(String mood) {
    switch (mood) {
      case 'happy':
        return 'Happy 😊';
      case 'sad':
        return 'Sad 😢';
      case 'excited':
        return 'Excited 🎉';
      default:
        return 'Unknown';
    }
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMoodButton(
              context,
              'Happy',
              Icons.sentiment_very_satisfied,
              CatppuccinColors.yellow,
              () {
                Provider.of<MoodModel>(context, listen: false).setHappy();
              },
            ),
            _buildMoodButton(
              context,
              'Sad',
              Icons.sentiment_very_dissatisfied,
              CatppuccinColors.blue,
              () {
                Provider.of<MoodModel>(context, listen: false).setSad();
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildMoodButton(
          context,
          'Excited',
          Icons.celebration,
          CatppuccinColors.pink,
          () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
        ),
      ],
    );
  }

  Widget _buildMoodButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: CatppuccinColors.surface0,
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}