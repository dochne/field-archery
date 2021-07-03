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

  Future<List<Map<String, Object?>>> select(String table, Map<String, String> where, {List<String> orderBy = const []}) async {
    var sql = "SELECT * FROM $table ";
    List<String> parameters = [];

    sql += " WHERE true ";
    where.forEach((key, value) {
      sql += " AND $key=? ";
      parameters.add(value);
    });

    sql += "ORDER BY true ";
    orderBy.forEach((column) {
      sql += ", $column ";
    });

    return await this.database.rawQuery(sql, parameters);
  }


  Future<bool> delete(String table, Map<String, String> where) async {
    var sql = "DELETE FROM $table WHERE true ";
    List<String> parameters = [];
    where.forEach((key, value) {
      sql += " AND $key=?";
      parameters.add(value);
    });
    await this.database.rawQuery(sql, parameters);
    // Todo: fix me
    return true;
  }

  Future<Map<String, Object?>?> selectSingle(String table, Map<String, String> where) async {
    var data = await this.select(table, where);
    if (data.length == 0) {
      return null;
    }

    return data.first;
  }

  Future<List<Map<String, Object?>>> query(String sql, List<Object?>? parameters) async {
    return await this.database.rawQuery(sql, parameters);
  }

  insert(String table, Map<String, dynamic> data) async {
    var from = [];
    var values = [];
    var parameters = [];

    data.forEach((key, value) {
      from.add(key);
      values.add("?");
      parameters.add(value);
    });

    var sql = "INSERT INTO $table (" + from.join(", ") + ") " +
        "VALUES (" + values.join(",") + ")";

    this.database.rawQuery(sql, parameters);
  }

  upsert(String table, Map<String, dynamic> data, List<String> conflictKeys) async {
    var from = [];
    var values = [];
    var parameters = [];
    var conflictSet = [];
    var conflictKey = conflictKeys.join(", ");

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

  static getDatabaseFilename() async {
    return join(await getDatabasesPath(), 'field_archery.db');
  }

  static drop() async {
    DatabaseLayer._instance = null;
    await deleteDatabase(
      await getDatabaseFilename()
    );
    await DatabaseLayer.getInstance();
  }

  static seed(db) async {
    await db.execute('DROP TABLE IF EXISTS session');
    await db.execute('DROP TABLE IF EXISTS session_player');
    await db.execute('DROP TABLE IF EXISTS  shot');
    await db.execute('DROP TABLE IF EXISTS player');
    await db.execute('CREATE TABLE session (uuid STRING PRIMARY KEY, start_time INTEGER, name STRING);');
    await db.execute('CREATE TABLE session_player (session_uuid STRING, player_uuid STRING);');
    await db.execute('CREATE TABLE shot (session_uuid STRING, player_uuid STRING, scored_time INTEGER, target INTEGER, score INTEGER, UNIQUE(session_uuid, player_uuid, target))');
    await db.execute('CREATE TABLE player (uuid STRING, name STRING)');
    ["Ben", "Dave", "Doug", "Em", "Goughy", "Marina", "Sam"].forEach((element) async {
      await db.execute("INSERT INTO player (uuid, name) VALUES (?, ?)", [Uuid().v4(), element]);
    });
  }

  static Future<DatabaseLayer> getInstance() async {
    if (DatabaseLayer._instance == null) {
      final database = await openDatabase(
        await getDatabaseFilename(),
        onCreate: (db, version) async {
          await seed(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          await seed(db);
        },
        version: 9,
      );

      DatabaseLayer._instance = DatabaseLayer(database);
    }

    return DatabaseLayer._instance!;
  }

  // SerializableModel hydrate(SerializableModel serializableModel, Map<String, Object> data) {
  //   return new serializableModel(data);
  // }
}