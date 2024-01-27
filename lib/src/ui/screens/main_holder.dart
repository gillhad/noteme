import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:noteme/src/ui/screens/settings/settings.dart';

import '../../config/providers.dart';
import '../widgets/bottom_navigation.dart';
import 'notes/home.dart';

class MainHolder extends ConsumerWidget {
   MainHolder({super.key});

   int barIndex = 0;
 final List<Widget> screens = [ const Home(), const Settings()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkMode = ref.watch(settingsProvider);
    print(barIndex);
    return Scaffold(
      body: _content(ref),
      bottomNavigationBar: _bottomNavigationBar(ref),

    );
  }

    Widget _content(ref) {
      return screens[ref.watch(mainHolderProvider)];
    }

    Widget _bottomNavigationBar(ref) {
      return BottomNavigationBar(
        currentIndex: barIndex,
          onTap: (index) {
              ref.read(mainHolderProvider.notifier).state = index;
              barIndex = ref.watch(mainHolderProvider);
          },
          items: [
            CustomBottombarItem(icon: const Icon(Symbols.ac_unit), label: "Home"),
            CustomBottombarItem(
                icon: const Icon(Symbols.settings), label: "Settings"),
          ]);
    }

}
