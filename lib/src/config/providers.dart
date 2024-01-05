

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/models/user.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';

final settingsProvider = StateProvider<bool>((ref) => true);
final mainHolderProvider = StateProvider<int>((ref) => 0);
final userState = StateProvider<User?>((ref) => UserHelper.user);
final noteList = Provider<dynamic>((ref) {
  

});