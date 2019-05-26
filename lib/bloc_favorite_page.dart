import 'package:flutter/material.dart';
import 'package:practice_bloc_favlist/word_provider.dart';
import 'package:practice_bloc_favlist/models/word_item.dart';

class BlocFavoritePage extends StatelessWidget {
  BlocFavoritePage();

  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    final word = WordProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite'),
      ),
      body: StreamBuilder<List<WordItem>>(
          stream: word.items,
          builder:(context, snapshot){
            if(snapshot.data == null || snapshot.data.isEmpty){
              return Center(child: Text('Empty'));
            }
            final tiles = snapshot.data.map(
                (item){
                  return ListTile(
                    title: Text(item.name),
                  );
                }
            );
            final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles
            ).toList();

            return ListView(children: divided);
          }
      ),
    );
  }

}