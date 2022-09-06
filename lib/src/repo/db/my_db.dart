import 'dart:io';

import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class MyDb {
  hiveInit() async {
    // Permission permission = Permission.storage;
    // Directory root = await getTemporaryDirectory();
    // final dir = await getApplicationDocumentsDirectory();
    var path = Directory.current.path;
    Hive.init(path);
    await openBox();
  }

  Future<Box> openBox() async {
    return await Hive.openBox('todo');
  }
}
