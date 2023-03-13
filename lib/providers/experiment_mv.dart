import 'package:flutter/material.dart';

class ExperimentParametersMV extends ChangeNotifier{
  int numberOfWords = 0; 
  int timeShowTime = 0;
  int upperLimit = 0; 
  int lowerLimit = 0; 
  int lengthOfWords = 0;

  void setNumberOfWords(val){
    numberOfWords = val; 
    notifyListeners();
  }

  void setLengthOfWords(val){
    lengthOfWords = val; 
    notifyListeners();
  }

  void setTimeShowTime(val){
    timeShowTime= val; 
    notifyListeners();
  }

  void setRangeOfWords(upper, lower){
    upperLimit = upper; 
    lowerLimit = lower;
    notifyListeners();
  }


}