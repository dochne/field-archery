import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/target.dart';

class Session {
  final DateTime? _startTime = null;
  final List<Player> players = [];
  // final List<Shot> _shots = [];
  final Map<Player, Map<int, Shot>> _shots = {};
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
    // this._currentBow[player] = bowType;
  }

  void removePlayer(Player player) {
    this.players.remove(player);
    // this._currentBow.remove(player);
  }

  void removeShot(Player player, int target) {
    if (_shots[player] != null && _shots[player]![target] != null) {
      _shots[player]!.remove(target);
    }
  }

  void addShot(Shot shot) {

    // final Map<Player, Map<int, Shot>> _shots = {};

    if (_shots[shot.player] == null) {
      _shots[shot.player] = new Map();
    }

    this._shots.update(shot.player, (Map<int, Shot> playerShots) {
      playerShots[shot.target] = shot;
      return playerShots;
    }, ifAbsent: () {
      Map<int, Shot> map = Map();
      map[shot.target] = shot;
      return map;
    });

    _shots[shot.player]![shot.target] = shot;

    // // this._shots[shot.player]
    // this._shots.add(shot);
    //
    // this._shots.update(shot.player, (value) {
    //   value.add(shot);
    //   return value;
    // }, ifAbsent: () => [shot]);
    //
    // this._targetShots.update(shot.target, (value) {
    //   value.add(shot);
    //   return value;
    // }, ifAbsent: () => [shot]);
  }
  //
  // void changeBow(Player player, BowType bowType) {
  //   this._currentBow[player] = bowType;
  // }
}