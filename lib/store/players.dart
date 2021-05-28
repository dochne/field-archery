import 'dart:convert';

import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players
{
  final SharedPreferences prefs;

  Players._(this.prefs);

  static Future<Players> create() async {
    var instance = Players._(await SharedPreferences.getInstance());

    if (instance._list().length == 0) {
      var names = ["Ben", "Dave", "Doug", "Em", "Goughy", "Marina", "Sam"];
      names.forEach((name) {
        instance.add(Player.createFromName(name));
      });
    }
    return instance;
  }

  List<String> _list() {
    return this.prefs.getStringList("players") ?? [];
  }

  _key(String uuid) {
    return "player-" + uuid;
  }

  add(Player player) {
    this.save(player);
    var list = _list();
    list.add(player.uuid);
    this.prefs.setStringList("players", list);
  }

  save(Player player) {
    this.prefs.setString(this._key(player.uuid), jsonEncode(player.toMap()));
  }

  Player get(String uuid) {
    var value = this.prefs.getString(this._key(uuid));
    var decoded = jsonDecode(value!);
    debugPrint("Get is being called");
    return Player.fromMap(decoded);
  }

  has(String uuid) {
    return this.prefs.containsKey("player-" + uuid);
  }

  List<Player> all() {
    List<Player> players = [];
    this._list().forEach((uuid) {
      players.add(this.get(uuid));
    });
    return players;
  }

}