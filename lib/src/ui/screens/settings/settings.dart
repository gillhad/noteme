import 'package:flutter/material.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
    //Todo: Nombre
          Text("Nombre del usuario"),
SizedBox(height: 40,),
_notSwitch(),
    _settingsOption("Configuración"),
    _settingsOption("Temas"),
    _settingsOption("Info"),
    _settingsOption("Feedback"),
    _settingsOption("Eliminar"),
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
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Text("Notificaciones")),
        Switch(value: _notificationStatus, onChanged: (value){
          setState(() {
            _notificationStatus = value;
          });
        })
      ],),
    );
  }

  _settingsOption(label){
    return GestureDetector(
      onTap: _navigation("tip"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: Text(label, maxLines: 1,)),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
  
  _navigation(route){
    
  }

}
