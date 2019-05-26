import 'dart:collection';
import 'package:english_words/english_words.dart';

final Suggestion suggestion = Suggestion();

class Suggestion {
  final List<WordPair> _suggestedWords = <WordPair>[];

  @override
  String toString() => '$suggestedWords';

  Suggestion();

  Suggestion.clone(Suggestion suggestion) {
    _suggestedWords.addAll(_suggestedWords);
  }

  int get suggestonCount => _suggestedWords.length;

  UnmodifiableListView get suggestedWords => UnmodifiableListView(_suggestedWords);

  void add(WordPair wordPair){
    _updateCount(wordPair);
  }

  _updateCount(WordPair wordpair){
    _suggestedWords.add(wordpair);
  }

  void addMulti(List<WordPair> wordPairs){
    for(int i = 0; i<wordPairs.length; ++i){
      _updateCount(wordPairs[i]);
    }
  }

}