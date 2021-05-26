import 'package:archery/models/session.dart';
import 'package:archery/screens/session/game/gamescreen.dart';
import 'package:archery/screens/session/player/playerscreen.dart';
import 'package:archery/state/active_session.dart';
import 'package:archery/store/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Important that this is in the same order as the BottomNavigationBar
enum Section {
  players,
  game,
  statistics
}

class SessionScreen extends StatefulWidget {
  final String sessionUuid;

  @override
  const SessionScreen({Key? key, required this.sessionUuid}) : super(key: key);
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;

    return FutureBuilder(
        future: this.loadSession(widget.sessionUuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Text("Loading...");
          }

          return ChangeNotifierProvider(
              create: (context) => ActiveSession(snapshot.data as Session),
              child: Consumer<ActiveSession>(
                  builder: (context, activeSession, _) {
                    Widget child;
                    switch (activeSession.screen) {
                      case 0:
                        child = PlayerScreen();
                        break;
                      default:
                        child = GameScreen();
                        break;
                    }

                    String title = '';
                    if (child is PlayerScreen) {
                      title = child.title;
                    } else if (child is GameScreen) {
                      title = child.title;
                    }

                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: Text(title),
                      ),
                      body: SizedBox.expand(child: child),
                      bottomNavigationBar: BottomNavigationBar(
                        onTap: (newIndex) => activeSession.setScreen(newIndex),
                        currentIndex: activeSession.screen,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.person), label: 'Players'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.emoji_events), label: 'Scoring'),
                          // BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
                        ],
                      ),
                    );
                  }
              )
          );
       }
    );
  }


  Future<Session> loadSession(String sessionUuid) async {
    return (await Sessions.create()).get(sessionUuid);
  }
}
      // return SizedBox();



  //

// setState(() {
//   if (activeSession.hasSession() && activeSession.session!.uuid != widget.sessionUuid) {
//     activeSession.unsetSession();
//   }
//
//   if (!activeSession.hasSession()) {
//     this.loadSession(activeSession, widget.sessionUuid);
//   }
// });
//
// if (!activeSession.hasSession()) {
//   return CircularProgressIndicator();
// }

  // }
  //
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         // Here we take the value from the MyHomePage object that was created by
  //         // the App.build method, and use it to set our appbar title.
  //         title: Text(this.title),
  //       ),
  //       body: this.body,
  //       bottomNavigationBar: BottomNavigationBar(
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.person),
  //             label: 'Players',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.emoji_events),
  //             label: 'Scoring',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.bar_chart),
  //             label: 'Statistics',
  //
  //           ),
  //         ],
  //         currentIndex: this.section.index,
  //         // selectedItemColor: Colors.amber[800],
  //         // onTap: _onItemTapped,
  //       )
  //   );

