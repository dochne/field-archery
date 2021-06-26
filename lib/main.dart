
import 'package:archery/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:archery/routes.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp()
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
