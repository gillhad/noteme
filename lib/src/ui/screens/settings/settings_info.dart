import 'package:flutter/material.dart';
import 'package:noteme/src/config/globals.dart';

class SettingsInfo extends StatefulWidget {
  const SettingsInfo({super.key});

  @override
  State<SettingsInfo> createState() => _SettingsInfoState();
}

class _SettingsInfoState extends State<SettingsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar(){
    return AppBar();
  }

  Widget _content(){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Column(
        children:[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
              height: 100,
              alignment: Alignment.center,
              //TODO: add logo
              child: Text("aquí logo")),
        Text(
          longString,
          textAlign: TextAlign.justify,
        )
        ]
      ),
    );
  }

}
