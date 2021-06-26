import 'dart:convert';

import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/state/database_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ShotStore {
  final DatabaseLayer db;

  ShotStore._(this.db);

  static ShotStore create(DatabaseLayer databaseLayer) {
    return ShotStore._(databaseLayer);
  }

  Future<List<Shot>> findBySessionUuid (String sessionUuid) async {
    var query = '''
    SELECT
      shot.scored_time,
      shot.session_uuid,
      shot.player_uuid,
      shot.target,
      shot.score
    FROM
      shot
    WHERE
      shot.session_uuid=?
    ''';

    var results = await this.db.query(query, [sessionUuid]);
    return Shot.createListFromMap(results);
  }

  add(Shot shot) async {
    await this.db.insert("shot", shot.toMap());
  }
  //
  //
  // Future<bool> save(Session session) async {
  //   await db.upsert("session", session.toMap(), 'uuid');
  //   return true;
  // }
}
