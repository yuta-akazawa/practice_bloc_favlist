import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:practice_bloc_favlist/models/word_item.dart';
import 'package:practice_bloc_favlist/word_bloc.dart';
import 'package:practice_bloc_favlist/word_provider.dart';
import 'package:practice_bloc_favlist/models/suggestion.dart';
import 'package:practice_bloc_favlist/widgets/count_label.dart';
import 'package:practice_bloc_favlist/bloc_favorite_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WordProvider(
      child: MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(primaryColor: Colors.white),
        home: RandomWordsHomePage(),
        routes: <String, WidgetBuilder>{
          BlocFavoritePage.routeName:(context) => BlocFavoritePage()
        },
      ),
    );
  }
}

class RandomWordsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordBloc = WordProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: wordBloc.itemCount,
            initialData: 0,
            builder: (context, snapshot) => CountLabel(
              favoriteCount: snapshot.data,
            ),
          ),
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: (){
                Navigator.of(context).pushNamed(BlocFavoritePage.routeName);
              }
          ),
        ],
      ),
      body: WordList(),
    );
  }
}

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i){
          if(i.isOdd)return Divider();

          final index = i ~/ 2;
          if(index >= suggestion.suggestonCount){
            const addNum = 10;
            suggestion.addMulti(generateWordPairs().take(addNum).toList());
          }

          return _buildRow(WordProvider.of(context), suggestion.suggestedWords[index]);
        }
    );
  }
}

Widget _buildRow(WordBloc word, WordPair pair) {
  return StreamBuilder<List<WordItem>>(
    stream: word.items,
    builder: (_, snapshot){
      if(snapshot.data == null || snapshot.data.isEmpty){
        return _createWordListTile(word, false, pair.asPascalCase);
      } else {
        final addedWord = snapshot.data.map(
            (item){
              return item.name;
            }
        );
        final alreadyAdded = addedWord.toString().contains(pair.asPascalCase);
        return _createWordListTile(word, alreadyAdded, pair.asPascalCase);
      }
    },
  );
}

ListTile _createWordListTile(WordBloc word, bool isFavorited, String title){
  return ListTile(
    title: Text(title),
    trailing: Icon(
      isFavorited ? Icons.favorite : Icons.favorite_border,
      color: isFavorited ? Colors.red : null,
    ),
    onTap: (){
      if(isFavorited){
        word.wordRemoval.add(WordRemoval(title));
      } else {
        word.wordAddition.add(WordAddition(title));
      }
    },
  );
}