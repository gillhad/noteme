import 'package:noteme/src/models/settings_model.dart';

class User{
  late String name;
  late String mail;

  late UserSettings settings;

  User.fromJson(json){
    name = json['name'];
    mail = json['mail'];
    settings = UserSettings.fromJson(json['settings']);
  }

}