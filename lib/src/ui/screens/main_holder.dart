import 'package:flutter/material.dart';

class MainHolder extends StatefulWidget {
  const MainHolder({super.key});

  @override
  State<MainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MainHolder> {
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
      child: Column(
        children: [
        ],
      ),
    );
  }
}
