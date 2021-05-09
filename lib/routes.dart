import 'package:archery/screens/game/gamescreen.dart';
import 'package:archery/screens/homepage/homepagescreen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(),
  "/game": (BuildContext context) => GameScreen(),
};