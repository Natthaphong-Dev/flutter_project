import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


class MyAppState  extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  var favorite = <WordPair>[];

  GlobalKey? historyListKey;

  void nextGenerate() {
    history.insert(0, current); //get array to history
    var animateList = historyListKey?.currentState as AnimatedListState;
    animateList.insertItem(0);
    current = WordPair.random(); //random new
    notifyListeners(); // nofity changed
  }

  void addFavorite([WordPair? pair]) {
    pair = pair ?? current; //if somme side null will get other side
    if (favorite.contains(pair)) {
      // contrain to add favorite in array
      favorite.remove(pair); // if have in favorite will remove
    } else {
      favorite.add(pair); // if not will add in favorite array
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    //get words and sent to remove
    favorite.remove(pair);
    notifyListeners();
  }
}
