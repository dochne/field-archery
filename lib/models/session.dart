import 'dart:convert';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/target.dart';
import 'package:archery/store/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Session {
  final Sessions sessions;
  final String uuid;
  final DateTime startTime;
  final List<Player> players = [];
  final Map<Player, Map<int, Shot>> _shots = {};
  final Map<Player, BowType> playerBowType = {};

  @override
  Session._(this.sessions, this.uuid, this.startTime);

  static Session fromMap(Sessions sessions, Map<String, dynamic> data) {
    debugPrint("Building session");
    debugPrint(data.toString());
    var session = Session._(sessions, data['uuid'], DateTime.fromMillisecondsSinceEpoch(data['startTime']));

    debugPrint("Session built");
    debugPrint(data.toString());

    debugPrint(data['players'].toString());
    // var players = data['players'] as List<Map<String, dynamic>>;
    //
    debugPrint("Players");
    // players.forEach((map) {
    //   // debugPrint(map.toString());
    //   //session.players.add(Player.fromMap(map));
    // });

    debugPrint("FromJSON");
    debugPrint(session.toString());
    debugPrint("After fromSession");
    return session;
  }

  static Session createNew(Sessions sessions) {
    return Session._(sessions, Uuid().v4(), new DateTime.now());
  }

  save() {
    this.sessions.save(this);
  }

  toMap() {
    List<Map> players = [];
    this.players.forEach((Player player) {
      players.add(player.toMap());
    });

    List<Map> shots = [];
    this._shots.forEach((player, targetShot) {
      targetShot.forEach((target, shot) {
        var map = shot.toMap();
        map['player'] = player.uuid;
        map['target'] = target;
        shots.add(map);
      });
    });

    return {
      "uuid": this.uuid,
      "startTime": this.startTime.millisecondsSinceEpoch,
      "players": players,
      "shots": shots
    };
  }


  // final List<Shot> _shots = [];
  // final Map<Target, List<Shot>> _targetShots = {};

  // BowType getCurrentBow(Player player) {
  //   return this._currentBow[Player]!;
  // }
  //
  // void setScore(Player player, int target, int score) {
  //
  // }
  //
  int? getScore(Player player, int target) {
    if (_shots[player] != null && _shots[player]![target] != null) {
      return _shots[player]![target]!.score;
    }
    return null;
  }

  int getTotalScore(Player player) {
    int score = 0;
    if (this._shots[player] != null) {
      this._shots[player]!.forEach((k, shot) {
        score += shot.score;
      });
    }
    return score;
  }

  void addPlayer(Player player) {
    this.players.add(player);
    this.playerBowType[player] = new BowType("compound_ul", "Compound Unlimited");
    this.players.sort((player1, player2) => player1.name.compareTo(player2.name));
  }

  void removePlayer(Player player) {
    // Todo: work out wtf should actually happen here
    // Like, what's best practice here?
    // player.active
  }

  void setScore(Player player, int target, int? score) {

    if (score == null) {
      if (_shots[player] != null) {
        _shots[player]!.remove(target);
      }
      this.sessions.save(this);
      return;
    }

    if (_shots[player] == null) {
      _shots[player] = new Map();
    }

    debugPrint(this.playerBowType.toString());
    this.playerBowType[player] = BowType("compound_ul", "Compound Unlimited");
    var shot = Shot.create(this.playerBowType[player]!, score);

    this._shots.update(player, (Map<int, Shot> playerShots) {
      playerShots[target] = shot;
      return playerShots;
    }, ifAbsent: () {
      Map<int, Shot> map = Map();
      map[target] = shot;
      return map;
    });

    _shots[player]![target] = shot;
    this.sessions.save(this);
  }
}