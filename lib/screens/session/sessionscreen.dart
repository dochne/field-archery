import 'package:archery/screens/session/game/gamescreen.dart';
import 'package:archery/screens/session/player/playerscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Important that this is in the same order as the BottomNavigationBar
enum Section {
  players,
  game,
  statistics
}

class SessionScreen extends StatefulWidget {
  final String sessionId;

  @override
  const SessionScreen({Key? key, required this.sessionId}) : super(key: key);
  _SessionScreenState createState() => _SessionScreenState();
}


class _SessionScreenState extends State<SessionScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = PlayerScreen(sessionId: widget.sessionId);
        break;
      default:
        child = GameScreen(sessionId: widget.sessionId);
        break;
      // case 2:
      //   child = FlutterLogo(textColor: Colors.red);
      //   break;
      // default:
      //   child = FlutterLogo();
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
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Players'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events),label: 'Scoring'),
          // BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
        ],
      ),
    );
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
  }
}
