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

  Shot fromMap(Map<String, dynamic> map){
    return new Shot._(
        DateTime.fromMillisecondsSinceEpoch(map['scoredTime']),
        new BowType('compound_ul', "Compound unlimited"),
        map['score']
    );
  }

  Map toMap() {
    return {
      "scoredTime": this.scoredTime.millisecondsSinceEpoch,
      // "player": this.player.uuid,
      "bowType": this.bowType.id,
      // "target": this.target,
      "score": this.score
    };
  }
}
