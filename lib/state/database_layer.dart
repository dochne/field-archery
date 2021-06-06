import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

typedef S ItemCreator<S>(Map<String, dynamic> map);

class DatabaseLayer {
  static DatabaseLayer? _instance;

  Database database;

  @override
  DatabaseLayer(this.database);

  // Future<List<Map<String, Object?>>> query(String sql, List<Object> parameters) async {
  //   return await this.database.rawQuery(sql, parameters);
  // }
  //
  // void insert(String table, Map<String, Object> values) {
  //   database.insert(table, values);
  // }
  //
  // T hydrate<T>(ItemCreator creator, Map<String, dynamic> map)
  // {
  //   return creator.call(map);
  // }

  // Future<Map<String, Object?>?> selectById(String table, String id) async
  // {
  //     var response = await database.rawQuery("SELECT * FROM " + table + " WHERE id=?", [id]);
  //     return response.length == 0 ? null : response.first;
  // }
  //
  // Future<Map<String, Object?>?> byUuid(String table, String id) async
  // {
  //   var response = await database.rawQuery("SELECT * FROM " + table + " WHERE uuid=?", [id]);
  //   return response.length == 0 ? null : response.first;
  // }

  Future<List<Map<String, Object?>>> select(String table, Map<String, String> where) async {
    var sql = "SELECT * FROM $table WHERE true ";
    List<String> parameters = [];
    where.forEach((key, value) {
      sql += " AND $key=?";
      parameters.add(value);
    });
    return await this.database.rawQuery(sql, parameters);
  }

  Future<Map<String, Object?>?> selectSingle(String table, Map<String, String> where) async {
    var data = await this.select(table, where);
    if (data.length == 0) {
      return null;
    }

    return data.first;
  }


  upsert(String table, Map<String, dynamic> data, String conflictKey) async {
    var from = [];
    var values = [];
    var parameters = [];
    var conflictSet = [];

    data.forEach((key, value) {
      from.add(key);
      values.add("?");
      parameters.add(value);
      conflictSet.add("$key = excluded.$key");
    });

    var sql = "INSERT INTO $table (" + from.join(", ") + ") " +
                "VALUES (" + values.join(",") + ") " +
                "ON CONFLICT($conflictKey) DO UPDATE SET " +
                conflictSet.join(",");

    this.database.rawQuery(sql, parameters);
  }



//
//   var data = await db.select("session", {"uuid": uuid});
//   //query("SELECT * FROM session WHERE uuid=?", [uuid]);
//
//   if (data.isEmpty) {
//   return null;
//   }
//
//   return Session.createFromMap(data.first);
// }
//
// void save(Session session) {
//   var data = await db.upsert("session", session.toMap(), {"uuid": uuid});

  static Future<DatabaseLayer> getInstance() async {
    if (DatabaseLayer._instance == null) {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'field_archery.db'),
        onCreate: (db, version) async {
          await db.execute('DROP TABLE session');
          await db.execute('CREATE TABLE session(uuid STRING PRIMARY KEY, startTime INTEGER);');
          // await db.execute("INSERT INTO session(uuid, startTime) VALUES ('5', 5)");
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await db.execute('DROP TABLE session');
          // await db.execute('DROP TABLE session_player');
          await db.execute('DROP TABLE shot');
          await db.execute('DROP TABLE player');
          await db.execute('CREATE TABLE session (uuid STRING PRIMARY KEY, startTime INTEGER, name STRING, players STRING);');
          // await db.execute('CREATE TABLE session_player (session_uuid STRING, player STRING);');
          await db.execute('CREATE TABLE shot (session_uuid STRING, target INTEGER, score INTEGER);');
          await db.execute('CREATE TABLE player (uuid STRING, name STRING)');
          ["Ben", "Dave", "Doug", "Em", "Goughy", "Marina", "Sam"].forEach((element) async {
            await db.execute("INSERT INTO player (uuid, name) VALUES (?, ?)", [Uuid().v4(), element]);
          });
        },
        version: 3,
      );

      DatabaseLayer._instance = DatabaseLayer(database);
    }

    return DatabaseLayer._instance!;
  }

  // SerializableModel hydrate(SerializableModel serializableModel, Map<String, Object> data) {
  //   return new serializableModel(data);
  // }
}