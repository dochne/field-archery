import 'dart:convert';

import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/state/database_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class PlayerStore {
  final DatabaseLayer db;

  PlayerStore._(this.db);

  static PlayerStore create(DatabaseLayer databaseLayer) {
    return PlayerStore._(databaseLayer);
  }

  Future<List<Player>> all() async {
    return Player.createListFromMap(await this.db.select("player", {}, orderBy: ["name"]));
  }

  Future<void> add(Player player) async {
    await this.db.insert("player", {"uuid": player.uuid, "name": player.name});
  }


  Future<List<Player>> findBySessionUuid (String sessionUuid) async {
    var query = '''
    SELECT
      player.uuid,
      player.name
    FROM
      player
    INNER JOIN
      session_player ON (player.uuid=session_player.player_uuid)
    WHERE
      session_player.session_uuid=?
    ''';

    var results = await this.db.query(query, [sessionUuid]);
    return Player.createListFromMap(results);
  }


  Future<void> addPlayerIntoSession(String sessionUuid, String playerUuid) async {
    await this.db.insert("session_player", {"session_uuid": sessionUuid, "player_uuid": playerUuid});
  }

  Future<void> removePlayerFromSession(String sessionUuid, String playerUuid) async {
    await this.db.delete("session_player", {"session_uuid": sessionUuid, "player_uuid": playerUuid});
  }

  // Future<bool> save(Session session) async {
  //   await db.upsert("session", session.toMap(), 'uuid');
  //   return true;
  // }
}
