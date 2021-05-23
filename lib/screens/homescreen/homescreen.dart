import 'package:archery/state/current_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hello")
      // ),
      body: Center(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0)
                ),
                Image(image: AssetImage("lib/images/splash.png"), height: 400),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0)
                ),
                Text(
                  "Field Archery",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.5,
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0)
                ),
              ]
            ),
            ElevatedButton(
              child: Container(
                constraints: BoxConstraints(minWidth: 200, minHeight: 50, maxWidth: 200),
                // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40.0),
                child: Align(alignment: Alignment.center, child: Text("Create Game"))
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/session/' + new DateTime.now().toString()
                );
                // DateTime now = new DateTime.now();
              },
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0)
            ),
            ElevatedButton(

              child: Container(
                  constraints: BoxConstraints(minWidth: 200, minHeight: 50, maxWidth: 200),
                  // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40.0),
                  child: Align(alignment: Alignment.center, child: Text("Open Existing Game"))
              ),
              onPressed: null
            ),
        ]),
    )
    );
  }
}
