import 'dart:collection';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/target.dart';
import 'package:flutter/material.dart';

class CurrentSession extends ChangeNotifier {
  Session? session;
  int? currentTarget;
  final Map<Player, BowType> _currentBow = {};

  // Todo: work out how to deal with targets - it'd be cool if we could say
  // "owl", "wolf" etc

  UnmodifiableListView<Player> get players => UnmodifiableListView(this.session!.players);

  void start(Session session) {
    this.session = session;
    this.currentTarget = 1;
  }

  void nextTarget() {
    currentTarget = currentTarget! + 1;
    notifyListeners();
  }

  void shoot(Player player, int? score, [int? target]) {
    if (target == null) {
      target = this.currentTarget!;
    }

    // hax
    if (this._currentBow[player] == null) {
      this._currentBow[player] = new BowType(bowType: "Compound");
    }

    if (score != null) {
      debugPrint(this._currentBow.length.toString());
      var shot = Shot.create(player, this._currentBow[player]!, target, score);
      session!.addShot(shot);
    } else {
      session!.removeShot(player, target);
    }
    notifyListeners();
  }

  void addPlayer(Player player/*, BowType bowType*/) {
    debugPrint("Added player");
    session!.addPlayer(player/*, bowType*/);
    this._currentBow[player] = new BowType(bowType: "Compound");
    notifyListeners();
  }

  int? getScore(Player player, [int? target]) {
    if (target == null) {
      target = this.currentTarget!;
    }
    return this.session!.getScore(player, target);
  }

  // setScoreForPlayer(Player player, int score, [int? target]) {
  //   if (target == null) {
  //     target = this.currentTarget!;
  //   }
  //   return this.session!.setScore(player, target, score);
  // }

  int getTotalScore(Player player) {
    return this.session!.getTotalScore(player);
  }
}