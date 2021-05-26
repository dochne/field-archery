import 'package:archery/models/player.dart';
import 'package:archery/state/active_session.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  ActiveSession activeSession;
  int target;

  ScoreScreen(this.activeSession, this.target);

  @override
  Widget build(BuildContext context) {


    List<DataRow> rows = [];
    for (Player player in this.activeSession.players) {
      int? score = this.activeSession.getScore(player, this.target);

      rows.add(
          DataRow(
            cells: [
              DataCell(Text(player.name)),
              DataCell(Text(this.activeSession.getTotalScore(player).toString())),
              DataCell(Text(score == null ? '-' : score.toString()), showEditIcon: true, onTap: () async {
                int? score = await getScore(context);
                this.activeSession.shoot(player, target, score);
                // this.currentSession.setScoreForPlayer(player, score);
              }),
            ]
        )
      );
    }

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            // style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Total',
            // style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Target Score',
            // style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: rows
    );
  }

  Future<int?> getScore(BuildContext context) async {
    List<SimpleDialogOption> list = [];

    Map<int?, String> shotTypes = {
      24: "24 - Inner kill",
      20: "20 - First kill",
      16: "16 - First wound",
      14: "14 - Second kill",
      10: "10 - Second wound",
      8: "8 - Third kill",
      4: "4 - Third wound",
      0: "0 - Miss",
      null: "Did not shoot"
    };

    //for (int? score, String text in shotTypes) {
    shotTypes.forEach((score, text) => {
      list.add(SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, score);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Text(text)
    )))
    });

    return await showDialog<int?>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: list);
        }
    );
  }

}