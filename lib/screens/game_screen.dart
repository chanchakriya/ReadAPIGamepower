import 'package:material_ui/material_ui.dart';

import '../models/giveaway.dart';
import '../services/api_service.dart';
import '../widgets/giveaway_card.dart';
import 'detail_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Future<List<Giveaway>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchGiveaways();
  }

  Future<void> _refresh() async {
    setState(() => _future = ApiService.fetchGiveaways());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Giveaways'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Giveaway>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48),
                    const SizedBox(height: 12),
                    Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(onPressed: _refresh, child: const Text('Retry')),
                  ],
                ),
              ),
            );
          }

          final giveaways = snapshot.data ?? [];
          if (giveaways.isEmpty) {
            return const Center(child: Text('No giveaways found'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 2 columns on phones, more on wider screens.
                final crossAxisCount = (constraints.maxWidth / 200).floor().clamp(2, 6);
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: giveaways.length,
                  itemBuilder: (context, index) {
                    final item = giveaways[index];
                    return GiveawayCard(
                      giveaway: item,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(giveaway: item),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
