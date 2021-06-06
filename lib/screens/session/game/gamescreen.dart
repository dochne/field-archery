import 'package:archery/screens/session/game/components/scorescreen.dart';
import 'package:archery/state/active_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  // final String sessionId;
  final ActiveSession activeSession;
  final String title = "Scoring";

  // const GameScreen({Key? key, required this.sessionId}) : super(key: key);

  // @override
  // _GameScreenState createState() => _GameScreenState();


  @override
  const GameScreen({Key? key, required this.activeSession}) : super(key: key);
  _GameScreenState createState() => _GameScreenState();
}

// String _getTitle(context) {
//   return "Target " + Provider.of<ActiveSession>(context).currentTarget.toString();
// }

// class GameScreen extends StatelessWidget {
class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    var activeSession = widget.activeSession;
    
    // return Consumer<ActiveSession>(builder: (context, activeSession, child) {
      return new Builder(builder: (context) {
        final PageController controller = PageController(
            initialPage: activeSession.getLastViewedTarget() - 1
        );
        //return Column(child: Text(activeSession.currentTarget));
        return /*Column(
          children: [*/
            PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: controller,
                onPageChanged: (index) {
                  activeSession.setLastViewedTarget(index + 1);
                },
                itemBuilder: (context, index) {
                  return buildPage(context, activeSession, index + 1);
                  // return Center(
                  //   child: Text('Fi' + index.toString()),
                  // );
                }
            );//,
            // Expanded(
            //     child: Align(
            //         alignment: FractionalOffset.bottomCenter,
            //         child: Padding(
            //             padding: EdgeInsets.symmetric(vertical: 15),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   ElevatedButton(
            //                     child: Icon(Icons.skip_previous),
            //                     onPressed: () {
            //                       // activeSession.previousTarget();
            //                     },
            //                   ),
            //                   ElevatedButton(
            //                     child: Text("Target hi"), // +
            //                     // activeSession.currentTarget.toString()),
            //                     onPressed: () {
            //                       // currentSession.nextTarget();
            //                     },
            //                   ),
            //                   ElevatedButton(
            //                     child: Icon(Icons.skip_next),
            //                     onPressed: () {
            //                       // activeSession.nextTarget();
            //                     },
            //                   )
            //                 ]))))
        //]);
      });
      // });
  }
}

Widget buildPage(context, activeSession, int currentTarget) {
  return Center(
      child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Target " + currentTarget.toString(), textAlign: TextAlign.center, textScaleFactor: 2,),
              ),
              ScoreScreen(activeSession, currentTarget),
            ])
  ]));
}