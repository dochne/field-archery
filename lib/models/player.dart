import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Player {
  final String uuid;
  String name;

  @override
  Player._(this.uuid, this.name);

  Map toMap() {
    return {
      "uuid": this.uuid,
      "name": this.name
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Player._(map['uuid'], map['name']);
  }

  static createFromName(String name) {
    return Player._(Uuid().v4(), name);
  }
}