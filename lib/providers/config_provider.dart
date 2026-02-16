import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigProvider with ChangeNotifier{
  bool temaOscuro = false;
  bool isLoading = false;
  bool isPrimeraVez = true;

  ConfigProvider(){
    _comprobarPrimeraVez();
    _cargarTemaUser();
  }

  void actualizaTema() async{
    temaOscuro = !temaOscuro;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('temaOscuro', temaOscuro);

    notifyListeners();
  }

  void cargando() async{
    isLoading = !isLoading;

    notifyListeners();
  }

  void _cargarTemaUser() async{
    final preferences = await SharedPreferences.getInstance();
    temaOscuro = preferences.getBool('temaOscuro') ?? false;
    notifyListeners();
  }

  void _comprobarPrimeraVez() async{
    final preferences = await SharedPreferences.getInstance();
    isPrimeraVez = preferences.getBool('primeraVez') ?? true;
    notifyListeners();
  }

  void confirmarPrimeraVez()async{
    isPrimeraVez = false;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('primeraVez', isPrimeraVez);
    notifyListeners();
  }
}