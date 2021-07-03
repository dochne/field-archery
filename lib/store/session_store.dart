import 'dart:convert';

import 'package:archery/models/session.dart';
import 'package:archery/state/database_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SessionStore {
  final DatabaseLayer db;

  SessionStore._(this.db);

  static SessionStore create(DatabaseLayer databaseLayer) {
    return SessionStore._(databaseLayer);
  }

  Future<Session?> findOneByUuid (String uuid) async {
    var sessions = await db.select("session", {"uuid": uuid});
    if (sessions.isEmpty) {
      return null;
    }

    debugPrint(sessions.first.toString());
    return Session.fromMap(sessions.first);
  }

  Future<List<Session>> all() async {
    var sessions = await db.select("session", {});

    return Session.createListFromMap(sessions);
  }

  Future<bool> save(Session session) async {
    await db.upsert("session", session.toMap(), ['uuid']);
    return true;
  }
}
