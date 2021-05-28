import 'package:archery/models/active_players.dart';
import 'package:archery/state/active_session.dart';
import 'package:archery/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:archery/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => ActivePlayersModel()),
  //       ChangeNotifierProvider(create: (context) => ActiveSession()),
  //     ],
  //     child: MyApp()
  //   )
  // );

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp()
    // FutureBuilder(
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return MyApp();
    //       }
    //
    //       return Text("Oh snap");
    //
    //     },
    //     future: clearStuff()
    // )
      // MyApp()
      //
      // MultiProvider(
      //     providers: [
      //       ChangeNotifierProvider(create: (context) => ActivePlayersModel()),
      //       ChangeNotifierProvider(create: (context) => ActiveSession()),
      //     ],
      //     child: MyApp()
      // )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // routes: routes,
      onGenerateRoute: routing,
      theme: appTheme(),
    );
  }
}
