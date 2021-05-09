import 'dart:collection';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/target.dart';
import 'package:flutter/material.dart';

class CurrentSession extends ChangeNotifier {
  Session? session;
  int currentTarget = 1;

  // Todo: work out how to deal with targets - it'd be cool if we could say
  // "owl", "wolf" etc

  UnmodifiableListView<Player> get players => UnmodifiableListView(this.session!.players);

  void start(Session session) {
    this.session = session;
  }

  void shoot(Player player, Target target, int score) {
    var shot = Shot.create(player, session!.getCurrentBow(player), target, score);
    session!.addShot(shot);
    notifyListeners();
  }

  void addPlayer(Player player, BowType bowType) {
    session!.addPlayer(player, bowType);
  }
}