import 'dart:collection';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
// import 'package:archery/models/session_player.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/player_store.dart';
// import 'package:archery/store/session_player_store.dart';
import 'package:archery/store/session_store.dart';
import 'package:archery/store/shot_store.dart';
import 'package:flutter/material.dart';

/**
 * This class needs rethinking still, it does too much
 *
 * We want something more Redux'y
 */
class ActiveSession extends ChangeNotifier {
  DatabaseLayer databaseLayer;

  Session session;
  List<Player> players = [];
  List<Shot> shots = [];
  Map<Player, Map<int, Shot>> playerTargetShotMap = new Map();

  bool loading = false;
  int lastViewedTarget = 1;
  int screen = 0;

  @override
  ActiveSession(this.databaseLayer, this.session, this.players, this.shots) {
    debugPrint("Loading ActiveSession");
    debugPrint("Creating PlayerTargetShotMap");
    Map<String, Player> playerMap = new Map();
    for (var player in this.players) {
      playerMap[player.uuid] = player;
    }


    for (var shot in this.shots) {
      Player? player = playerMap[shot.playerUuid];
      if (player != null) {
        // eich, yuck
        var map = this.playerTargetShotMap[player] ?? new Map();
        map[shot.target] = shot;
        this.playerTargetShotMap[player] = map;
      }
    }
  }

  void setScreen(int index) {
    this.screen = index;
    notifyListeners();
  }


  void setLastViewedTarget(int target) {
    this.lastViewedTarget = target;
  }

  int getLastViewedTarget() {
    return this.lastViewedTarget;
  }

  void addPlayer(Player player) {
    this.players.add(player);
    this.playerTargetShotMap[player] = new Map();
    PlayerStore.create(this.databaseLayer).addPlayerIntoSession(this.session.uuid, player.uuid);
  }

  void removePlayer(Player player) {
    this.players.remove(player);
    PlayerStore.create(this.databaseLayer).removePlayerFromSession(this.session.uuid, player.uuid);
    notifyListeners();
  }

  bool hasPlayer(Player player) {
    return this.players.map((p) => p.uuid).contains(player.uuid);
  }

  void shoot(Player player, int target, int? score) {
    var shotStore = ShotStore.create(this.databaseLayer);
    if (score != null) {
      var shot = Shot.create(session, player, target, score);
      shotStore.add(shot);
      this.playerTargetShotMap[player]?[target] = shot;
      notifyListeners();
      return;
    }

    shotStore.remove(session, player, target);
    this.playerTargetShotMap[player]?.remove(target);
    notifyListeners();
  }

  int? getScore(Player player, int target) {
    if (this.playerTargetShotMap[player] != null) {
      if (this.playerTargetShotMap[player]![target] != null) {
        return this.playerTargetShotMap[player]![target]!.score;
      }
    }
    return null;
  }

  int getTotalScore(Player player) {
    int score = 0;
    if (this.playerTargetShotMap[player] != null) {
      this.playerTargetShotMap[player]!.forEach((k, shot) {
        score += shot.score;
      });
    }
    return score;

    return 0;
    // return this.session.getTotalScore(player);
  }

  static Future<ActiveSession> load(String sessionUuid) async
  {
    try{
      var databaseLayer = await DatabaseLayer.getInstance();
      var sessionStore = SessionStore.create(databaseLayer);

      debugPrint("Finding session by sessionUuid");
      var session = await sessionStore.findOneByUuid(sessionUuid);
      if (session == null) {
        throw new Exception("Unable to find session with UUID " + sessionUuid);
      }

      debugPrint("Finding players by sessionUuid");
      var playerStore = PlayerStore.create(databaseLayer);
      var players = await playerStore.findBySessionUuid(sessionUuid);

      debugPrint("Finding shots by sessionUuid");
      var shotStore = ShotStore.create(databaseLayer);
      var shots = await shotStore.findBySessionUuid(sessionUuid);

      debugPrint("Building ActiveSession");
      return new ActiveSession(
          databaseLayer,
          session,
          players,
          shots,
          // [],
      );
    }  catch (e){
      return Future.error(e.toString());
    }
  }

  static Future<void> save(ActiveSession activeSession) async
  {

  }



}