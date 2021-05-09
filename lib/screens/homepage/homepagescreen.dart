import 'package:archery/models/active_players.dart';
import 'package:archery/models/bow_type.dart';
import 'package:archery/models/player.dart';
import 'package:archery/models/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _session = new Session();

  // final activePlayers = ActivePlayersCubit();
  final List<Player> _players = [
    new Player(name: "Ben"),
    new Player(name: "Dave"),
    new Player(name: "Doug"),
    new Player(name: "Em"),
    new Player(name: "Sam"),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<ActivePlayersModel>(builder: (context, activePlayers, child) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Select your players"),
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: _session.players.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final player = _session.players[index];

                  return ListTile(
                      title: Text(player.name),
                      enabled: true,
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _session.removePlayer(player);
                            });
                          })
                  );
                },
              )
          ),
          ElevatedButton(
            child: Text("Start Game!"),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/game',
              );
            },
          )
        ]),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { _addPlayers(context);},
          tooltip: 'Add Player',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }


  Future<void> _addPlayers(BuildContext context) async {
    List<SimpleDialogOption> list = [];

    List<String> _friends = ["Doug", "Steve", "Ben"];

    for (var i = 0; i < _friends.length; i++) {
      String name = _friends[i];

      list.add(SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, name);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Text(name))));
    }

    String? value = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: const Text('Add Player'), children: list);
        }
    );

    if (value != null) {
      setState(() {
        _session.addPlayer(new Player(name: value), new BowType(bowType: "compound"));
      });
      //   activePlayers.add(new Player(name: value));
    }
  }
}

// int _counter = 0;
// bool _checkbox = false;
// List<String> _players = [];
//
// static List<String> _friends = [
//   "Ben",
//   "Dave",
//   "Doug",
//   "Em",
//   "Sam"
// ];
//

//
// if (value != null) {
//   setState(() {
//     _players.add(value);
//     _players.sort((a, b) {
//       return a.toLowerCase().compareTo(b.toLowerCase());
//     });
//   });
// }
