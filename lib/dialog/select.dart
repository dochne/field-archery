import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

Future<T?> selectDialog<T>(BuildContext context, String title, Iterable<Tuple2<T, String>> entries) async {
    List<SimpleDialogOption> list = [];

    entries.forEach((value) {
      list.add(
          SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, value.item1);
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: Text(value.item2)
              )
          )
      );
    });

    return await showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(title: Text(title), children: list);
      }
    );
}