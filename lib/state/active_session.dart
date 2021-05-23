import 'dart:collection';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/target.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveSession extends ChangeNotifier {
  // Session? session;
  // final Map<Player, BowType> _currentBow = {};
  final List<Player> _activePlayers = [];
  final Map<Player, Map<int, int?>> _shots = {};
  // final String name;

  // @override
  // ActiveSession(this.name);

  // static ActiveSession createFromExisting(String name) : ActiveSession
  // {
  //   return new ActiveSession("Hello");
  // }
  //
  //
  // void _save() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //prefs.getStringList(key)
  // }

  // int currentTarget = 1;
  int lastViewedTarget = 1;

  UnmodifiableListView<Player> get players => UnmodifiableListView(this._activePlayers);

  // Todo: work out how to deal with targets - it'd be cool if we could say
  // "owl", "wolf" etc

  void addPlayer(Player player) {
    this._activePlayers.add(player);
    this._activePlayers.sort((player1, player2) => player1.name.compareTo(player2.name));
    notifyListeners();
  }

  void removePlayer(Player player) {
    for (int x=0; x<_activePlayers.length; x++) {
      if (_activePlayers[x].name == player.name) {
        this._activePlayers.removeAt(x);
        break;
      }
    }
    this._activePlayers.remove(player);
    notifyListeners();
  }

  bool hasPlayer(Player player) {
    for (int x=0; x<_activePlayers.length; x++) {
      if (_activePlayers[x].name == player.name) {
        return true;
      }
    }
    return false;
  }

  void setLastViewedTarget(int target) {
    this.lastViewedTarget = target;
  }

  int getLastViewedTarget() {
    return this.lastViewedTarget;
  }


  //
  //
  // void start(Session session) {
  //   this.session = session;
  //   // this.currentTarget = 1;
  // }
  //

  //
  // void previousTarget() {
  //   currentTarget = currentTarget - 1;
  //   notifyListeners();
  // }
  //
  // void nextTarget() {
  //   currentTarget = currentTarget + 1;
  //   notifyListeners();
  // }

  void shoot(Player player, int target, int? score) {
    if (_shots[player] == null) {
      _shots[player] = new Map();
    }

    _shots[player]![target] = score;
    //
    // this._shots.update(player, (Map<int, int?> playerShots) {
    //   playerShots[target] = score;
    //   return playerShots;
    // }, ifAbsent: () {
    //   Map<int, Shot> map = Map();
    //   map[shot.target] = shot;
    //   return map;
    // });
    //
    // _shots[shot.player]![shot.target] = shot;
    // if (target == null) {
    //   target = this.currentTarget!;
    // }

    // target = 1;
    // // hax
    // if (this._currentBow[player] == null) {
    //   this._currentBow[player] = new BowType(bowType: "Compound");
    // }

    // if (score != null) {
    //   debugPrint(this._currentBow.length.toString());
    //   var shot = Shot.create(player, this._currentBow[player]!, target, score);
    //   session!.addShot(shot);
    // } else {
    //   session!.removeShot(player, target);
    // }
    notifyListeners();
  }
  //
  // void addPlayer(Player player/*, BowType bowType*/) {
  //   debugPrint("Added player");
  //   session!.addPlayer(player/*, bowType*/);
  //   this._currentBow[player] = new BowType(bowType: "Compound");
  //   notifyListeners();
  // }

  int? getScore(Player player, int target) {
    if (_shots[player] != null && _shots[player]![target] != null) {
      return _shots[player]![target]!;
    }
    return null;
    // if (target == null) {
    //   target = this.currentTarget!;
    // }
    // return this.session!.getScore(player, target);
  }

  int getTotalScore(Player player) {
    int score = 0;
    if (this._shots[player] != null) {
      this._shots[player]!.forEach((k, shot) {
          score += shot != null ? shot : 0;
      });
    }
    return score;
  }

  // setScoreForPlayer(Player player, int score, [int? target]) {
  //   if (target == null) {
  //     target = this.currentTarget!;
  //   }
  //   return this.session!.setScore(player, target, score);
  // }

  // int getTotalScore(Player player) {
  //   return 0;
  //   // return this.session!.getTotalScore(player);
  // }
}