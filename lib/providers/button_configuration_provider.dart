import 'package:flutter/material.dart';

class ButtonConfigurationProvider with ChangeNotifier{
  bool botonClickado = false;

  void switchBotones(){
    botonClickado = !botonClickado;
    notifyListeners();
  }
}