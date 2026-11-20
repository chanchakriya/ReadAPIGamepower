import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Game Giveaways',
      debugShowCheckedModeBanner: false,
      theme: theme.buildTheme(Brightness.light),
      darkTheme: theme.buildTheme(Brightness.dark),
      themeMode: theme.themeMode,
      home: const MainScreen(),
    );
  }
}
