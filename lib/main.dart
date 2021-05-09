import 'package:archery/models/active_players.dart';
import 'package:archery/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:archery/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActivePlayersModel())
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      theme: appTheme(),
    );
  }
}
