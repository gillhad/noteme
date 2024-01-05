import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemNotifier extends ChangeNotifier{
  List<dynamic> itemsList = [];

  addItem(item){
    itemsList.add(item);
    print("añadido un item");
  }

}

