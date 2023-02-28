import 'package:flutter/foundation.dart';

class CountState with ChangeNotifier{
  int count =0;

  void add(){
    this.count++;
    print(count);
    notifyListeners();
  }
}