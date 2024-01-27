import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/providers.dart';

import '../../widgets/buttons/checkbox_button.dart';

class SettingsConf extends ConsumerStatefulWidget {
  const SettingsConf({super.key});

  @override
  ConsumerState<SettingsConf> createState() => _SettingsConfState();
}

class _SettingsConfState extends ConsumerState<SettingsConf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Configuración"),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left,),
        onPressed: (){
          GoRouter.of(context).pop();
          print(ref.watch(userState)!.settings.simpleMode);
    },
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
_confView()
        ],
      ),
    );
  }

  _confView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AL.of(context).settings_conf_view, style: textTheme.headlineSmall,),
        const SizedBox(height: 10,),
        //light/dark mode
        CheckBoxOption(label:AL.of(context).settings_conf_light,currentValue: ref.watch(userState)!.settings.darkMode, callback: _manageLightMode,),
        //simple/complex mode
        CheckBoxOption(label:AL.of(context).settings_conf_viewMode,currentValue: ref.watch(userState)!.settings.simpleMode,callback: _manageViewMode,),
        const Divider()
      ],
    );
  }

  _manageLightMode(value){
      ref.read(userState.notifier).state!.settings.darkMode = value;
  }

  _manageViewMode(value){
    ref.read(userState.notifier).state!.settings.simpleMode = value;
  }

}

