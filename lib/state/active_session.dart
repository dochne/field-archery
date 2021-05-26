import 'dart:collection';

import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:flutter/material.dart';

class ActiveSession extends ChangeNotifier {
  Session session;
  int lastViewedTarget = 1;
  int screen = 0;

  @override
  ActiveSession(this.session);

  UnmodifiableListView<Player> get players => UnmodifiableListView(this.session.players);

  // Todo: work out how to deal with targets - it'd be cool if we could say
  // "owl", "wolf" etc

  void setScreen(int index) {
    this.screen = index;
    notifyListeners();
  }

  void addPlayer(Player player) {
    this.session.players.add(player);
    this.session.save();
    notifyListeners();
  }

  void removePlayer(Player player) {
    this.session.players.remove(player);
    this.session.save();
    notifyListeners();
  }

  bool hasPlayer(Player player) {
    return this.session.players.contains(player);
  }

  void setLastViewedTarget(int target) {
    this.lastViewedTarget = target;
  }

  int getLastViewedTarget() {
    return this.lastViewedTarget;
  }

  void shoot(Player player, int target, int? score) {
    this.session.setScore(player, target, score);
    this.session.save();
    notifyListeners();
  }

  int? getScore(Player player, int target) {
    return this.session.getScore(player, target);
  }

  int getTotalScore(Player player) {
    return this.session.getTotalScore(player);
  }
}