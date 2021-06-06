import 'dart:collection';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/session_player.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/session_player_store.dart';
import 'package:archery/store/session_store.dart';
import 'package:flutter/material.dart';

class ActiveSession extends ChangeNotifier {
  late SessionStore sessionStore;
  late SessionPlayerStore sessionPlayerStore;

  Session session;
  List<Shot> shots = [];
  List<SessionPlayer> sessionPlayers = [];
  List<Player> players = [];

  bool loading = false;
  int lastViewedTarget = 1;
  int screen = 0;

  @override
  ActiveSession(databaseLayer, this.session, this.shots, this.sessionPlayers) {
    this.sessionStore = Session.createStore(databaseLayer);
    //this.sessionPlayerStore = SessionPlayer.createStore(databaseLayer);
  }

  // UnmodifiableListView<Player> get players => UnmodifiableListView(this.session.players);

  // Todo: work out how to deal with targets - it'd be cool if we could say
  // "owl", "wolf" etc

  void setScreen(int index) {
    this.screen = index;
    notifyListeners();
  }

  void setPlayer(Player player, BowType bowType) {
    session.players.add
    var bowType = BowType.createCompound();

    this.sessionStore.save(session);
    // var sessionPlayer = SessionPlayer.createNew(this.session, player);
    // this.sessionPlayerStore.save(sessionPlayer);
    // this.session.players.add(player);
    // this.session.save();
    notifyListeners();
  }

  void removePlayer(Player player) {
    // this.session.players.remove(player);
    // this.session.save();
    notifyListeners();
  }
  //
  bool hasPlayer(Player player) {
    // return this.session.players.contains(player);
    return false;
  }

  void setLastViewedTarget(int target) {
    this.lastViewedTarget = target;
  }
  //
  int getLastViewedTarget() {
    return this.lastViewedTarget;
  }
  //
  void shoot(Player player, int target, int? score) {
    // this.session.setScore(player, target, score);
    // this.session.save();
    notifyListeners();
  }
  //
  int? getScore(Player player, int target) {
    return 0;
    // return this.session.getScore(player, target);
  }

  int getTotalScore(Player player) {
    return 0;
    // return this.session.getTotalScore(player);
  }


  static Future<ActiveSession> createFromDatabase(String sessionUuid) async
  {
    try{
      var databaseLayer = await DatabaseLayer.getInstance();
      var sessionStore = Session.createStore(databaseLayer);

      var session = await sessionStore.findOneByUuid(sessionUuid);
      if (session == null) {
        sessionStore.save(Session.createNew());
      }
      // This is dumb, but it'll cope for hte time being
      session = await sessionStore.findOneByUuid(sessionUuid);
      if (session == null) {
        throw new Exception("Unable to find or create session with UUID " + sessionUuid);
      }

      return new ActiveSession(
          databaseLayer,
          session,
          [],
          [],
      );
    }  catch (e){
      return Future.error(e.toString());
    }
  }



}