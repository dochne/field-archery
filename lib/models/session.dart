import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/session_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Session {
  final String uuid;
  final String name;
  final DateTime startTime;
  // final Map<Player, BowType> players;

  @override
  Session._(this.uuid, this.startTime, this.name);

  static Session fromMap(Map<String, dynamic> map) {
    return Session._(
        map['uuid'].toString(),
        DateTime.fromMillisecondsSinceEpoch(map['start_time']),
        map['name'],
    );
  }


  static List<Session> createListFromMap(List<Map<String, dynamic>> list) {
    debugPrint("Creating list from map");
    return list.map((map) => Session.fromMap(map)).toList();
  }

  static Session createNew() {
    var date = DateTime.now();
    return Session._(Uuid().v4(), date, DateFormat('H:mm EEEE, d MMM, yyyy').format(date));
  }

  // static SessionStore createStore(DatabaseLayer databaseLayer) {
  //   return SessionStore.create(databaseLayer);
  // }

  toMap() {
    return {
      "uuid": this.uuid,
      "name": this.name,
      "start_time": this.startTime.millisecondsSinceEpoch,
    };
  }


  // static Session fromMap({required this.uuid, this.}) {
  //   // debugPrint("Building session");
  //   // debugPrint(data.toString());
  //   var session = Session._(sessions, data['uuid'], DateTime.fromMillisecondsSinceEpoch(data['startTime']));
  //   //
  //   // debugPrint("Session built");
  //   // debugPrint(data.toString());
  //   //
  //   // debugPrint(data['players'].toString());
  //   // // var players = data['players'] as List<Map<String, dynamic>>;
  //   // //
  //   // debugPrint("Players");
  //   // // players.forEach((map) {
  //   // //   // debugPrint(map.toString());
  //   // //   //session.players.add(Player.fromMap(map));
  //   // // });
  //   //
  //   // debugPrint("FromJSON");
  //   // debugPrint(session.toString());
  //   // debugPrint("After fromSession");
  //   return session;
  // }

  //
  // toMap() {
  //   List<Map> players = [];
  //   this.players.forEach((Player player) {
  //     players.add(player.toMap());
  //   });
  //
  //   List<Map> shots = [];
  //   this._shots.forEach((player, targetShot) {
  //     targetShot.forEach((target, shot) {
  //       var map = shot.toMap();
  //       map['player'] = player.uuid;
  //       map['target'] = target;
  //       shots.add(map);
  //     });
  //   });
  //
  //   return {
  //     "uuid": this.uuid,
  //     "startTime": this.startTime.millisecondsSinceEpoch,
  //     "players": players,
  //     "shots": shots
  //   };
  // }
  //
  //
  // // final List<Shot> _shots = [];
  // // final Map<Target, List<Shot>> _targetShots = {};
  //
  // // BowType getCurrentBow(Player player) {
  // //   return this._currentBow[Player]!;
  // // }
  // //
  // // void setScore(Player player, int target, int score) {
  // //
  // // }
  // //
  // int? getScore(Player player, int target) {
  //   if (_shots[player] != null && _shots[player]![target] != null) {
  //     return _shots[player]![target]!.score;
  //   }
  //   return null;
  // }
  //
  // int getTotalScore(Player player) {
  //   int score = 0;
  //   if (this._shots[player] != null) {
  //     this._shots[player]!.forEach((k, shot) {
  //       score += shot.score;
  //     });
  //   }
  //   return score;
  // }
  //
  // void addPlayer(Player player) {
  //   this.players.add(player);
  //   this.playerBowType[player] = new BowType("compound_ul", "Compound Unlimited");
  //   this.players.sort((player1, player2) => player1.name.compareTo(player2.name));
  // }
  //
  // void removePlayer(Player player) {
  //   // Todo: work out wtf should actually happen here
  //   // Like, what's best practice here?
  //   // player.active
  // }
  //
  // void setScore(Player player, int target, int? score) {
  //
  //   if (score == null) {
  //     if (_shots[player] != null) {
  //       _shots[player]!.remove(target);
  //     }
  //     // this.sessions.save(this);
  //     return;
  //   }
  //
  //   if (_shots[player] == null) {
  //     _shots[player] = new Map();
  //   }
  //
  //   debugPrint(this.playerBowType.toString());
  //   this.playerBowType[player] = BowType("compound_ul", "Compound Unlimited");
  //   var shot = Shot.create(this.playerBowType[player]!, score);
  //
  //   this._shots.update(player, (Map<int, Shot> playerShots) {
  //     playerShots[target] = shot;
  //     return playerShots;
  //   }, ifAbsent: () {
  //     Map<int, Shot> map = Map();
  //     map[target] = shot;
  //     return map;
  //   });
  //
  //   _shots[player]![target] = shot;
  //   // this.sessions.save(this);
  // }
}