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
    debugPrint(session.toString());
    this.prefs.setString(this._key(session.uuid), session.toString());
  }

  Session get(String uuid) {
    var value = this.prefs.getString(this._key(uuid));
    debugPrint(value);
    return Session.fromString(this, value!);
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
