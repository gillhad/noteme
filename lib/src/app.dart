import 'package:flutter/material.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/navigation/navigation_router.dart';

class NoteMe extends StatefulWidget {
  const NoteMe({super.key});

  @override
  State<NoteMe> createState() => _NoteMeState();
}

class _NoteMeState extends State<NoteMe> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.mainTheme,
      themeMode: ThemeMode.system,

    );
  }
}
