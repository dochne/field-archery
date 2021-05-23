import 'package:archery/screens/homescreen/homescreen.dart';
import 'package:archery/screens/session/game/components/players.dart';
import 'package:archery/screens/session/player/playerscreen.dart';
import 'package:archery/screens/session/sessionscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   "/": (BuildContext context) => HomeScreen(),
//   "/session/:sessionId/players": (BuildContext context) => PlayerScreen(),
// };

MaterialPageRoute routing (settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  var uri = Uri.parse(settings.name);

  if (uri.pathSegments.first == 'session') {
    String sessionId = uri.pathSegments[1];
    return MaterialPageRoute(builder: (context) => SessionScreen(sessionId: sessionId));
  }

  return MaterialPageRoute(builder: (context) => HomeScreen());

  // // Handle '/details/:id'
  //
  // if (uri.pathSegments.length == 2 &&
  //     uri.pathSegments.first == 'details') {
  //   var id = uri.pathSegments[1];
  //   return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
  // }
  //
  // return MaterialPageRoute(builder: (context) => UnknownScreen());
}