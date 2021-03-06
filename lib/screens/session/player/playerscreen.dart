
import 'package:archery/dialog/input.dart';
import 'package:archery/models/player.dart';
import 'package:archery/state/database_layer.dart';
import 'package:archery/store/player_store.dart';
import 'package:archery/store/players.dart';
import 'package:archery/models/session.dart';
import 'package:archery/screens/session/game/components/scorescreen.dart';
import 'package:archery/state/active_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class PlayerScreen extends StatefulWidget {
  final ActiveSession activeSession;
  // const PlayerScreen({Key? key, required this.sessionId}) : super(key: key);
  final String title = "Add Players";

  @override
  const PlayerScreen({Key? key, required this.activeSession}) : super(key: key);
  _PlayerScreenState createState() => _PlayerScreenState();
  //
  // @override
  // _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // return Consumer<ActiveSession>(builder: (context, activeSession, child) {
      var activeSession = widget.activeSession;

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
          onPressed: () { _addPlayers(context, activeSession); },
          tooltip: 'Add Player',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    // });
  }


  Future<void> _addPlayers(BuildContext context, ActiveSession activeSession) async {
    List<SimpleDialogOption> list = [];

    var databaseLayer = await DatabaseLayer.getInstance();
    var playerStore = PlayerStore.create(databaseLayer);

    debugPrint(activeSession.players.length.toString());

    var newPlayer = Player.createFromName("New Player!");
    
    (await playerStore.all())
        .where((player) => !activeSession.hasPlayer(player))
        .forEach((Player player) {

          list.add(SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, player);
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: Text(player.name))));
        });

    list.add(SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, newPlayer);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.grey,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            child: Text("New Player!")
          )
        ]
      )
    ));

    Player? player = await showDialog<Player>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text('Add Player'), children: list);
        }
    );

    if (player == null) {
      return;
    }

    if (player.uuid == newPlayer.uuid) {
      var input = await inputDialog(context, new TextEditingController(), "Enter New Player Name");
      if (input == null || input == '') {
        return;
      }
      player = Player.createFromName(input);
      playerStore.add(player!);
    }

    setState(() {
      activeSession.addPlayer(player!/*, new BowType(bowType: "compound")*/);
    });

      //   activePlayers.add(new Player(name: value));
    //
    // if (player != null) {
    //   setState(() {
    //     activeSession.addPlayer(player/*, new BowType(bowType: "compound")*/);
    //   });
    //   //   activePlayers.add(new Player(name: value));
    // }
  }
}

