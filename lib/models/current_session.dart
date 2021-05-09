import 'dart:collection';

import 'package:archery/models/player.dart';
import 'package:flutter/material.dart';

class ActivePlayersModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Player> _players = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Player> get items => UnmodifiableListView(_players);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPlayers => _players.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Player player) {
    _players.add(player);
    notifyListeners();
  }

  void remove(Player player) {
    var index = _players.indexOf(player);

    if (index != -1) {
      _players.removeAt(index);
      notifyListeners();
    }
  }

  /// Removes all items from the cart.
  void removeAll() {
    _players.clear();
    notifyListeners();
  }
}