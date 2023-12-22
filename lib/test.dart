import 'package:hive/hive.dart';
import 'package:riverpod_example/person.model.dart';

class HiveMethods {
  String hiveBox = 'hive_local_db';
  Future<Box<UserModel>> _openBox() async {
    return await Hive.openBox<UserModel>(hiveBox);
  }
  Future<List<UserModel>> getUserList() async {
    final box = await _openBox();
    return box.values.toList();
  }
  addUser(UserModel userModel) async {
    var box = await Hive.openBox(hiveBox);
    var mapUserData = userModel.toMap(userModel);
    await box.add(mapUserData);
    Hive.close();
  }

  Future<List<UserModel>> getUserLists() async {
    var box = await Hive.openBox(hiveBox);
    List<UserModel> users = [];

    for (int i = box.length - 1; i >= 0; i--) {
      var userMap = box.getAt(i);
      users.add(UserModel.fromMap(Map.from(userMap)));
    }
    return users;
  }

  deleteUser(int id) async {
    var box = await Hive.openBox(hiveBox);
    await box.deleteAt(id);
  }

  deleteAllUser() async {
    var box = await Hive.openBox(hiveBox);
    box.clear();
  }
}
