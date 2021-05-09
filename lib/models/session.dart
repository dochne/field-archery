import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/shot.dart';
import 'package:archery/models/target.dart';

class Session {
  final DateTime? _startTime = null;
  final List<Player> players = [];
  final List<Shot> _shots = [];
  final Map<Player, BowType> _currentBow = {};
  final Map<Player, List<Shot>> _playerShots = {};
  final Map<Target, List<Shot>> _targetShots = {};

  BowType getCurrentBow(Player player) {
    return this._currentBow[Player]!;
  }

  void addPlayer(Player player, BowType bowType) {
    this.players.add(player);
    this._currentBow[player] = bowType;
  }

  void removePlayer(Player player) {
    this.players.remove(player);
    this._currentBow.remove(player);
  }

  void addShot(Shot shot) {
    this._shots.add(shot);

    this._playerShots.update(shot.player, (value) {
      value.add(shot);
      return value;
    }, ifAbsent: () => [shot]);

    this._targetShots.update(shot.target, (value) {
      value.add(shot);
      return value;
    }, ifAbsent: () => [shot]);
  }

  void changeBow(Player player, BowType bowType) {
    this._currentBow[player] = bowType;
  }
}