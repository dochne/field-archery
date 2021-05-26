import 'package:archery/models/active_players.dart';
import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:archery/state/active_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatefulWidget {
  final String sessionId;
  const AddPlayerScreen({Key? key, required this.sessionId}) : super(key: key);
  final String title = "Add Players";

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  // final List<Player> _players = [
  //   new Player(name: "Ben"),
  //   new Player(name: "Dave"),
  //   new Player(name: "Doug"),
  //   new Player(name: "Em"),
  //   new Player(name: "Goughy"),
  //   new Player(name: "Marina"),
  //   new Player(name: "Sam"),
  // ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<ActiveSession>(builder: (context, activeSession, child) {
      return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text("Select your players"),
        // ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: activeSession.players.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final player = activeSession.players[index];

                  return ListTile(
                      title: Text(player.name),
                      enabled: true,
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              activeSession.removePlayer(player);
                            });
                          })
                  );
                },
              )
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () { /*_addPlayers(context, activeSession);*/ },
          tooltip: 'Hey o',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
  //
  //
  // Future<void> _addPlayers(BuildContext context, ActiveSession activeSession) async {
  //   List<SimpleDialogOption> list = [];
  //
  //   //List<String> _friends = ["Doug", "Steve", "Ben"];
  //   List<Player> _notPlaying = [];
  //   _players.forEach((player) {
  //     if (!activeSession.hasPlayer(player)) {
  //       _notPlaying.add(player);
  //     }
  //   });
  //
  //   //for (var i = 0; i < _friends.length; i++) {
  //   _notPlaying.forEach((Player player) {
  //     // String name = _players[i];
  //
  //     list.add(SimpleDialogOption(
  //         onPressed: () {
  //           Navigator.pop(context, player);
  //         },
  //         child: Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
  //             child: Text(player.name))));
  //   });
  //
  //
  //   Player? player = await showDialog<Player>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(title: const Text('Add Player'), children: list);
  //       }
  //   );
  //
  //   if (player != null) {
  //     setState(() {
  //       activeSession.addPlayer(player/*, new BowType(bowType: "compound")*/);
  //     });
  //     //   activePlayers.add(new Player(name: value));
  //   }
  // }
}

