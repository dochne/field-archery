import 'dart:convert';

import 'package:archery/models/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  final SharedPreferences prefs;

  Sessions._(this.prefs);

  static Future<Sessions> create() async {
    return Sessions._(await SharedPreferences.getInstance());
  }

  List<String> _list() {
    return this.prefs.getStringList("sessions") ?? [];
  }

  _key(String uuid) {
    return "session-" + uuid;
  }

  add(Session session) {
    this.save(session);
    var list = _list();
    list.add(session.uuid);
    this.prefs.setStringList("sessions", list);
  }

  save(Session session) {
    this.prefs.setString(this._key(session.uuid), jsonEncode(session.toMap()));
  }

  Session get(String uuid) {
    var value = this.prefs.getString(this._key(uuid));
    debugPrint("Got value");
    debugPrint(value);
    if (value == null) {
      debugPrint("Bringing back new");
      return Session.createNew(this);
    }
    debugPrint("Bringing back existing");
    debugPrint(value);

    var decoded = jsonDecode(value);

    var v2 = Session.fromMap(this, decoded);
    debugPrint("I'll be returning this ty");
    debugPrint(v2.toString());
    return v2;
  }

  has(String uuid) {
    return this.prefs.containsKey("session-" + uuid);
  }

  List<Session> all() {
    List<Session> sessions = [];
    this._list().forEach((uuid) {
      sessions.add(this.get(uuid));
    });
    return sessions;
  }
}
