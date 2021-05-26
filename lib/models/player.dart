import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String uuid;
  String name;

  @override
  Player._(this.uuid, this.name);

  toJson() {
    return jsonEncode({
      "uuid": this.uuid,
      "name": this.name
    });
  }

  static fromJson(String string) {
    var decoded = jsonDecode(string);
    debugPrint(decoded.toString());
    return Player._(decoded['uuid'], decoded['name']);
  }

  static createFromName(String name) {
    return Player._(Uuid().v4(), name);
  }
}