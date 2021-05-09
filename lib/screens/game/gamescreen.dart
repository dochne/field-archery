import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text("HellO"),
          Expanded(
              child: ListView.builder(
            // Let the ListView know how many items it needs to build.
            itemCount: activePlayers.items.length,
            // Provide a builder function. This is where the magic happens.
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
              final player = activePlayers.items[index];

              return ListTile(
                  title: Text(player.name),
                  enabled: true,
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        activePlayers.remove(player);
                      }));
            },
          ))
        ]),
      ),
    );
  }
}
