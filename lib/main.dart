import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Select Your Players'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _checkbox = false;
  List<String> _players = [];

  static List<String> _friends = [
    "Ben",
    "Dave",
    "Doug",
    "Em",
    "Sam"
  ];

  Future<void> _addPlayers() async {
    List<SimpleDialogOption> list = [];
    for (var i=0; i<_friends.length; i++) {
        String name = _friends[i];

        if (_players.indexOf(name) != -1) {
          continue;
        }

        list.add(SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, name);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            child: Text(name)
          )
        ));
    }

    String value = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Add Player'),
            children: list
          );
        }
    );

    if (value != null) {
      setState(() {
        _players.add(value);
        _players.sort((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
      });
    }

  }

  void _incrementCounter() {
    // _askedToLead();
    //
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //
    //   _players.add("Doug");
    // });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
          children:[
            Expanded(
              child: ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: _players.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = _players[index];

                  return ListTile(
                      title:Text(item),
                      enabled: true,
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                        setState(() {
                          _players.removeAt(index);
                        });
                      })
                    // subtitle: item.buildSubtitle(context),
                  );
                },
              )
            ),
            ElevatedButton(
                child: Text("Start Game!"),
                onPressed:() { },

            )
        ]
      ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ _addPlayers(); },
        tooltip: 'Add Player',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
