import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/app.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/user.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  UserHelper.user = User();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);



  runApp(ProviderScope(child: NoteMe()));
}

