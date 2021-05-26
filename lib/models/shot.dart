import 'dart:convert';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/target.dart';

class Shot {
  final DateTime scoredTime;
  // final Player player;
  final BowType bowType;
  // final int target;
  final int score;

  @override
  //Shot._({required this.scoredTime, required this.player, required this.bowType, required this.target, required this.score});
  Shot._(this.scoredTime, this.bowType, this.score);

  static create(BowType bowType, int score)
  {
    return new Shot._(DateTime.now(), bowType, score);
  }

  Shot fromJson(String json){
    var decoded = jsonDecode(json);
    return new Shot._(
        DateTime.fromMillisecondsSinceEpoch(decoded['scoredTime']),
        new BowType('compound_ul', "Compound unlimited"),
        decoded['score']
    );
  }

  toJson() {
    return jsonEncode({
      "scoredTime": this.scoredTime.millisecondsSinceEpoch,
      // "player": this.player.uuid,
      "bowType": this.bowType.id,
      // "target": this.target,
      "score": this.score
    });
  }
}
