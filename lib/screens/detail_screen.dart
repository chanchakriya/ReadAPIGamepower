import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/giveaway.dart';

class DetailScreen extends StatelessWidget {
  final Giveaway giveaway;

  const DetailScreen({super.key, required this.giveaway});

  Future<void> _openGiveaway(BuildContext context) async {
    final uri = Uri.parse(giveaway.openGiveawayUrl);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Giveaway Detail')),
      body: ListView(
        children: [
          Hero(
            tag: 'giveaway-${giveaway.id}',
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                giveaway.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: colors.surfaceContainerHighest,
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(giveaway.title, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(avatar: const Icon(Icons.category, size: 18), label: Text(giveaway.type)),
                    Chip(avatar: const Icon(Icons.attach_money, size: 18), label: Text(giveaway.worth)),
                    Chip(avatar: const Icon(Icons.circle, size: 12), label: Text(giveaway.status)),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(icon: Icons.devices, label: 'Platforms', value: giveaway.platforms),
                _InfoRow(icon: Icons.event, label: 'Published', value: giveaway.publishedDate),
                _InfoRow(icon: Icons.timer_off, label: 'End date', value: giveaway.endDate),
                _InfoRow(icon: Icons.people, label: 'Users', value: '${giveaway.users}'),
                const Divider(height: 32),
                Text('Description', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(giveaway.description),
                const SizedBox(height: 20),
                Text('Instructions', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(giveaway.instructions.replaceAll('\r\n', '\n')),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => _openGiveaway(context),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Get Giveaway'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
