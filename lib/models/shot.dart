import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/target.dart';

class Shot {
  final DateTime scoredTime;
  final Player player;
  final BowType bowType;
  final Target target;
  final int score;

  Shot({required this.scoredTime, required this.player, required this.bowType, required this.target, required this.score});

  static create(Player player, BowType bowType, Target target, int score)
  {
    return new Shot(scoredTime: DateTime.now(), player: player, bowType: bowType, target: target, score: score);
  }
}
