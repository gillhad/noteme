import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteme/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const NoteMe());
}

