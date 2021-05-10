import 'package:archery/models/player.dart';
import 'package:archery/state/current_session.dart';
import 'package:flutter/material.dart';

class Players extends StatelessWidget {
  CurrentSession currentSession;

  Players(this.currentSession);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for (Player player in this.currentSession.players) {
      int? score = this.currentSession.getScore(player);

      rows.add(
          DataRow(
            cells: [
              DataCell(Text(player.name)),
              DataCell(Text(this.currentSession.getTotalScore(player).toString())),
              DataCell(Text(score == null ? '-' : score.toString()), showEditIcon: true, onTap: () async {
                int? score = await getScore(context);
                this.currentSession.shoot(player, score);
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
      20: "20 - First shot kill",
      16: "16 - First shot wound",
      14: "14 - Second shot kill",
      10: "10 - Second shot wound",
      8: "8 - Third shot kill",
      4: "4 - Third shot wound",
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
          return SimpleDialog(title: const Text('Add Player'), children: list);
        }
    );
  }

}