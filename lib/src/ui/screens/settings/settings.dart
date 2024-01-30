import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool _notificationStatus = true;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body:  _content(),
    );
  }

  AppBar _appBar(){
    return AppBar();
  }

  Widget _content(){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
    //Todo: Nombre
          const Text("Nombre del usuario"),
const SizedBox(height: 40,),
_notSwitch(),
    _settingsOption(AL.of(context).setttings_conf,routes.settingsConf),
    _settingsOption(AL.of(context).settings_theme,routes.settingsThemes),
    _settingsOption(AL.of(context).settings_info,routes.settingsInfo),
    _settingsOption(AL.of(context).settings_fdb,routes.settingsFeedback),
    _settingsOption(AL.of(context).delete,"delete"),
    //Notificaciones
    //Opciones
    //Temas
    //Info
        ],
      ),
    );
  }

  _notSwitch(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Text(AL.of(context).settings_not)),
        Switch(value: _notificationStatus, onChanged: (value){
          setState(() {
            _notificationStatus = value;
          });
        })
      ],),
    );
  }

  _settingsOption(label,nav){
    return GestureDetector(
      onTap:(){ _navigation(nav);},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: Text(label, maxLines: 1,)),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
  
  _navigation(route){
    if(route=="delete"){
      dialogDeleteAll();
    }else {
      GoRouter.of(context).push(route);
    }
    }

  dialogDeleteAll(){

  }

}
