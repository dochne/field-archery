import 'package:archery/dialog/select.dart';
import 'package:archery/screens/session/game/components/scorescreen.dart';
import 'package:archery/state/active_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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
                  return buildPage(context, activeSession, controller, index + 1);
                }
            );//,
      });
      // });
  }
}

Widget buildPage(context, ActiveSession activeSession, PageController controller, int currentTarget) {
  return Center(
      child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                    onTap: () async {
                      await selectTarget(context, controller);
                      // selectTarget();
                    },
                    child: Text("Target " + currentTarget.toString(), textAlign: TextAlign.center, textScaleFactor: 2,),
                )
              ),
              ScoreScreen(activeSession, currentTarget),
            ])
  ]));
}


selectTarget(context, PageController controller) async {
  var target = await selectDialog<int>(
      context,
      "Jump to Target!",
      (List<int>.generate(40, (i) => i + 1)).map((v) => Tuple2<int, String>(v, (v).toString()))
  );

  if (target != null) {
    debugPrint("Jumping to " + (target - 1).toString());
    controller.jumpToPage(target - 1);
  }
}