import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 4.1 Dark mode switching
          Card(
            child: SwitchListTile(
              secondary: Icon(theme.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              title: const Text('Dark Mode'),
              subtitle: Text(theme.isDarkMode ? 'On' : 'Off'),
              value: theme.isDarkMode,
              onChanged: theme.toggleDarkMode,
            ),
          ),
          const SizedBox(height: 16),

          // 4.2 Color theme switching
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.palette),
                      SizedBox(width: 12),
                      Text('Color Theme', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(ThemeProvider.colorOptions.length, (i) {
                      final selected = theme.colorIndex == i;
                      return GestureDetector(
                        onTap: () => theme.setColor(i),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: ThemeProvider.colorOptions[i],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: selected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(height: 4),
                            Text(ThemeProvider.colorNames[i], style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Individual Assignment'),
              subtitle: Text('Chan Chakriya'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.api),
              title: Text('Data source'),
              subtitle: Text('gamerpower.com/api/giveaways'),
            ),
          ),
        ],
      ),
    );
  }
}
