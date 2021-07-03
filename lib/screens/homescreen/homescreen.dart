import 'dart:convert';
import 'dart:io';

import 'package:archery/dialog/confirm.dart';
import 'package:archery/dialog/select.dart';
import 'package:archery/models/session.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/session_store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

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
                Image(image: AssetImage("lib/images/splash.png"), height: 320),
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
                    child: Align(alignment: Alignment.center, child: Text("Upload State"))
                ),
                onPressed: () async {
                  await uploadStuff(context);
                  //await clearStuff();
                }
            ),

            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0)
            ),
            ElevatedButton(
                child: Container(
                    constraints: BoxConstraints(minWidth: 200, minHeight: 50, maxWidth: 200),
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40.0),
                    child: Align(alignment: Alignment.center, child: Text("Delete State"))
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                ),
                onPressed: () async {
                  //await uploadStuff(context);
                  await clearStuff(context);
                  //await clearStuff();
                }
            ),
        ]),
    )
    );
  }

  uploadStuff(BuildContext context) async {
    // Sending a POST request
    var database = await DatabaseLayer.getDatabaseFilename();
    File file = new File(database);
    var content = await file.readAsBytes();

    var url = Uri.parse('https://archery.dochne.com/upload.php');
    // const payload = {online: false};
    var response = await http.post(url, body: {
      'token': "75037ce3-90de-491d-a680-8b8c81235d0a",
      'database': base64.encode(content)
    });

    await showDialog<Session>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text('Upload Request Made!'), children: [
            Text("Status Code: " + response.statusCode.toString()),
            Text("Server Response: " + response.body)
          ]);
        }
    );
  }


  clearStuff(BuildContext context) async {
    if (await confirmDialog(context, "Are you sure you want to delete the application state?")) {
      await DatabaseLayer.drop();
    }
  }

  Future<void> _selectExistingSession(BuildContext context) async {
    var databaseLayer = await DatabaseLayer.getInstance();
    var sessionStore = await SessionStore.create(databaseLayer);

    var session = await selectDialog<Session>(
        context,
        'Select Existing Game',
        (await sessionStore.all()).map((session) => Tuple2<Session, String>(session, session.name))
    );

    if (session != null) {
      Navigator.pushNamed(
          context,
          '/session/' + session.uuid
      );
    }
  }
}
