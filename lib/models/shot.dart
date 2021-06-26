import 'dart:convert';

import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/models/target.dart';
import 'package:flutter/cupertino.dart';

class Shot {
  final String sessionUuid;
  final DateTime scoredTime;
  final String playerUuid;
  final int target;
  final int score;

  // final Player player;
  // final BowType bowType;
  // final int target;


  @override
  Shot._(this.scoredTime, this.sessionUuid, this.playerUuid, this.target, this.score);

  static create(Session session, Player player, int target, int score)
  {
    return new Shot._(DateTime.now(), session.uuid, player.uuid, target, score);
  }

  Map<String, dynamic> toMap() {
    return {
      "scored_time": this.scoredTime.millisecondsSinceEpoch,
      "session_uuid": this.sessionUuid,
      "player_uuid": this.playerUuid,
      "target": this.target,
      "score": this.score,
    };
  }

  static Shot fromMap(Map<String, dynamic> map){
    return new Shot._(
        DateTime.fromMillisecondsSinceEpoch(map['scored_time']),
        // BowType.createCompound(),
        map['session_uuid'],
        map['player_uuid'],
        map['target'],
        map['score']
    );
  }

  static createListFromMap(List<Map<String, dynamic>> list) {
    debugPrint(list.toString());
    return list.map((map) => Shot.fromMap(map)).toList();
  }
  //
  // Map toMap() {
  //   return {
  //     "scoredTime": this.scoredTime.millisecondsSinceEpoch,
  //     "player": this.player.uuid,
  //     // "bowType": this.bowType.id,
  //     // "target": this.target,
  //     "score": this.score
  //   };
  // }
}
