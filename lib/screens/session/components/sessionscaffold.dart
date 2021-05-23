import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Important that this is in the same order as the BottomNavigationBar
enum Section {
  players,
  game,
  statistics
}

class SessionScaffold extends StatelessWidget {
  Section section;
  Widget? body;
  String title;
  String sessionId;

  SessionScaffold({
    required this.section,
    required this.body,
    required this.title,
    required this.sessionId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title),
        ),
        body: this.body,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Players',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Scoring',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistics',

            ),
          ],
          currentIndex: this.section.index,
          // selectedItemColor: Colors.amber[800],
          // onTap: _onItemTapped,
        )
    );
  }
}
