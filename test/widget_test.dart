import 'package:flutter_test/flutter_test.dart';
import 'package:giveaway_app/providers/theme_provider.dart';

void main() {
  test('ThemeProvider has color options', () {
    expect(ThemeProvider.colorOptions.length, ThemeProvider.colorNames.length);
  });
}
