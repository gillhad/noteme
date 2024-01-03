import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _content(),
      drawer: _drawer(),
      floatingActionButton: _addNote(),
    );
  }

  AppBar _appBar(){
    return AppBar(
      title: Text(AL.of(context).main_title),
      elevation: 2,
      actions: const [
        Icon(Icons.search),
        Icon(Icons.filter),
        Icon(Icons.more_vert),
      ],
    );
  }

  Widget _content(){
    return SingleChildScrollView(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context,index)=> Container(width: 10,height: 10, color: Colors.red,), separatorBuilder: (context,index)=>Container(height: 5,), itemCount: 10),
    );
  }

  Widget _drawer(){
    return Drawer(
      width: MediaQuery.of(context).size.width/5,
      child: _drawerItems(),
    );
  }

  _drawerItems(){
    return Column(
      children: [
        Container(height: 100,),
        IconButton(onPressed: (){}, icon: Icon(Icons.all_inbox, color: AppColors.grey,size: MediaQuery.of(context).size.width/7,)),
        IconButton(onPressed: (){}, icon: Icon(Icons.folder, color: AppColors.grey,size: MediaQuery.of(context).size.width/7,)),],
    );
  }

  Widget _addNote(){
    return FloatingActionButton(onPressed: () {
      ///TODO: Create new note
    },
    child: Icon(Icons.add, color: AppColors.onPrimary,size: 38,),
    );
  }
}
