import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// ThemeMode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class ThemeSwitcherButton extends ConsumerWidget {
  const ThemeSwitcherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return IconButton(
      icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
      onPressed: () {
        ref.read(themeModeProvider.notifier).state =
            themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      },
    );
  }
}
