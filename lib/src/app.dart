import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/navigation/navigation_router.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/providers.dart';


class NoteMe extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      localizationsDelegates: AL.localizationsDelegates,
      supportedLocales: AL.supportedLocales,
      routerConfig: router,
      theme: appTheme(context,ref.watch(settingsProvider)),

    );
  }
}
