import 'dart:io' as io;

import 'package:majootestcase/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();
  DbHelper.internal();

  factory DbHelper() => _instance;

  static Database? _db;

  //liat kalo database udah ada return ke db itu sndiri kalo belum bakal dibuat databasenya
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await setDB();
    return _db!;
  }

  deleteDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "majoo.db");
    await deleteDatabase(path);
    print("item_deleted");
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "majoo.db");

    var dB = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (Database db) {
        print("OPEN DB");
        //this.FetchLocalData();
      },
    );
    return dB;
  }

  //buat database table namanya mynote
  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS users(" +
        "Generated_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
        "email TEXT, " +
        "password TEXT, " +
        "username TEXT); ");
    print('DB Created, Table users');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int respond = await dbClient.insert("users", user.toMap());
    // print('discount inserted');
    return respond;
  }

  Future<User> getUser(User user) async {
    String email = user.email ?? "";
    String password = user.password ?? "";
    var dbClient = await db;
    var results = await dbClient.rawQuery(
        "SELECT email,username,password FROM users  WHERE email = '$email' AND password = '$password'  limit 1");
    print(" " + results.toString());
    if (results.length > 0) {
      return new User.map(results.first);
    }return User();
  }
}
