import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const List<Color> colorOptions = [
    Colors.deepPurple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.teal,
  ];

  static const List<String> colorNames = [
    'Purple',
    'Blue',
    'Green',
    'Orange',
    'Red',
    'Pink',
    'Teal',
  ];

  bool _isDarkMode = false;
  int _colorIndex = 0;

  bool get isDarkMode => _isDarkMode;
  int get colorIndex => _colorIndex;
  Color get seedColor => colorOptions[_colorIndex];
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _colorIndex = prefs.getInt('colorIndex') ?? 0;
    if (_colorIndex >= colorOptions.length) _colorIndex = 0;
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  Future<void> setColor(int index) async {
    _colorIndex = index;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorIndex', index);
  }

  ThemeData buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
    );
  }
}
