import 'package:archery/screens/game/components/players.dart';
import 'package:archery/state/current_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentSession>(builder: (context, currentSession, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Target " + currentSession.currentTarget!.toString()),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              // Text("Hello"),
                  Players(currentSession),
                ]
              ),
              ElevatedButton(
                child: Text("Next Target"),
                onPressed: () {
                  currentSession.nextTarget();
                },
              )

          ]),
        ),
    );
  });
  }
}
