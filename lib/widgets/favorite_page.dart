import 'package:flutter/material.dart';
import 'package:practice_bloc_favlist/models/word.dart';

class FavoritePage extends StatelessWidget {
  final Word word;
  FavoritePage(this.word);

  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    final tiles = word.items.map(
        (item){
          return ListTile(
            title: Text(item.name),
          );
        }
    );

    final divided = ListTile.divideTiles(
      tiles: tiles,
      context: context,
    ).toList();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite'),
      ),
      body: ListView(children: divided),
    );
  }
}