import 'package:archery/models/session.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/session_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onPressed: () async {
                // var sessions = await Sessions.create();
                // var session = Session.createNew(sessions);
                // session.save();
                // sessions.add(session);
                var store = SessionStore.create(await DatabaseLayer.getInstance());
                var session = Session.createNew();
                await store.save(session);

                Navigator.pushNamed(
                  context,
                  '/session/' + session.uuid
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
              onPressed: () {
                _selectExistingSession(context);
              }
            ),

            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0)
            ),
            ElevatedButton(
                child: Container(
                    constraints: BoxConstraints(minWidth: 200, minHeight: 50, maxWidth: 200),
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40.0),
                    child: Align(alignment: Alignment.center, child: Text("Delete State"))
                ),
                onPressed: () async {
                  await clearStuff();
                }
            ),
        ]),
    )
    );
  }


  Future<SharedPreferences> clearStuff() async {
    var prefManager = await SharedPreferences.getInstance();
    await prefManager.clear();
    // debugPrint("Clearing");
    // (await SharedPreferences.getInstance()).clear();
    return prefManager;
  }


  Future<void> _selectExistingSession(BuildContext context) async {
    List<SimpleDialogOption> list = [];

    var databaseLayer = await DatabaseLayer.getInstance();
    var sessionStore = await SessionStore.create(databaseLayer);
    var sessions = (await sessionStore.all()).forEach((Session session) {
      // String name = _players[i];

      list.add(SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, session);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Text(session.name))));
    });


    Session? session = await showDialog<Session>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text('Select Existing Game'), children: list);
        }
    );

    if (session != null) {
      Navigator.pushNamed(
          context,
          '/session/' + session.uuid
      );
    }
  }
}
