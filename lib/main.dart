import 'dart:math';
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
  Color _backgroundColor = CatppuccinColors.yellow.withValues(alpha: 0.1);
  final Map<String, int> _moodCounts = {
    'happy': 0,
    'sad': 0,
    'excited': 0,
  };
  final List<String> _moodHistory = [];
  final Random _random = Random();

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => Map.from(_moodCounts);
  List<String> get moodHistory => List.from(_moodHistory);

  void _addToHistory(String mood) {
    _moodHistory.insert(0, mood); // Add to beginning
    if (_moodHistory.length > 3) {
      _moodHistory.removeLast(); // Keep only last 3
    }
  }

  void setHappy() {
    _currentMood = 'happy';
    _backgroundColor = CatppuccinColors.yellow.withValues(alpha: 0.1);
    _moodCounts['happy'] = (_moodCounts['happy'] ?? 0) + 1;
    _addToHistory('happy');
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'sad';
    _backgroundColor = CatppuccinColors.blue.withValues(alpha: 0.1);
    _moodCounts['sad'] = (_moodCounts['sad'] ?? 0) + 1;
    _addToHistory('sad');
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'excited';
    _backgroundColor = CatppuccinColors.pink.withValues(alpha: 0.1);
    _moodCounts['excited'] = (_moodCounts['excited'] ?? 0) + 1;
    _addToHistory('excited');
    notifyListeners();
  }

  void setRandomMood() {
    final moods = ['happy', 'sad', 'excited'];
    final randomMood = moods[_random.nextInt(moods.length)];
    
    switch (randomMood) {
      case 'happy':
        setHappy();
        break;
      case 'sad':
        setSad();
        break;
      case 'excited':
        setExcited();
        break;
    }
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
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CatppuccinColors.base,
                  moodModel.backgroundColor,
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 30),
                  const MoodCounter(),
                  const SizedBox(height: 20),
                  const MoodHistory(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMoodButton(
              context,
              'Excited',
              Icons.celebration,
              CatppuccinColors.pink,
              () {
                Provider.of<MoodModel>(context, listen: false).setExcited();
              },
            ),
            _buildRandomButton(context),
          ],
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

  Widget _buildRandomButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CatppuccinColors.mauve.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          Provider.of<MoodModel>(context, listen: false).setRandomMood();
        },
        icon: const Icon(Icons.shuffle, color: CatppuccinColors.mauve),
        label: const Text(
          'Random 🤪',
          style: TextStyle(
            color: CatppuccinColors.mauve,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: CatppuccinColors.surface0,
          foregroundColor: CatppuccinColors.mauve,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: CatppuccinColors.mauve.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget that displays mood history
class MoodHistory extends StatelessWidget {
  const MoodHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CatppuccinColors.surface0,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CatppuccinColors.surface1,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Recent Moods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CatppuccinColors.text,
                ),
              ),
              const SizedBox(height: 16),
              if (moodModel.moodHistory.isEmpty)
                const Text(
                  'No history yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: CatppuccinColors.subtext0,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: moodModel.moodHistory
                      .asMap()
                      .entries
                      .map((entry) => _buildHistoryItem(entry.key, entry.value))
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryItem(int index, String mood) {
    Color color;
    IconData icon;
    String label;

    switch (mood) {
      case 'happy':
        color = CatppuccinColors.yellow;
        icon = Icons.sentiment_very_satisfied;
        label = 'Happy';
        break;
      case 'sad':
        color = CatppuccinColors.blue;
        icon = Icons.sentiment_very_dissatisfied;
        label = 'Sad';
        break;
      case 'excited':
        color = CatppuccinColors.pink;
        icon = Icons.celebration;
        label = 'Excited';
        break;
      default:
        color = CatppuccinColors.text;
        icon = Icons.help_outline;
        label = 'Unknown';
    }

    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: color.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: CatppuccinColors.subtext0,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: CatppuccinColors.subtext0,
          ),
        ),
      ],
    );
  }
}

// Widget that displays mood selection counters
class MoodCounter extends StatelessWidget {
  const MoodCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CatppuccinColors.surface0,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CatppuccinColors.surface1,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Mood Statistics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CatppuccinColors.text,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCounterItem(
                    'Happy',
                    moodModel.moodCounts['happy'] ?? 0,
                    CatppuccinColors.yellow,
                    Icons.sentiment_very_satisfied,
                  ),
                  _buildCounterItem(
                    'Sad',
                    moodModel.moodCounts['sad'] ?? 0,
                    CatppuccinColors.blue,
                    Icons.sentiment_very_dissatisfied,
                  ),
                  _buildCounterItem(
                    'Excited',
                    moodModel.moodCounts['excited'] ?? 0,
                    CatppuccinColors.pink,
                    Icons.celebration,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCounterItem(String label, int count, Color color, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: CatppuccinColors.subtext0,
          ),
        ),
      ],
    );
  }
}