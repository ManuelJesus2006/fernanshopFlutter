import 'dart:convert';

import 'package:http/http.dart';
import 'package:practica_obligatoria_tema5_fernanshop/env.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';

class UsersService {
  Future<Users?> loginWithEmailAndPass(String email, String pass) async {
    Uri uri = Uri.parse('${Env.endPointBase}/auth/login');
    Response response = await post(
      uri,
      headers: {'api_key': Env.apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "pass": pass}),
    );
    print(response.statusCode);
    if (response.statusCode != 201) return null;
    Users usuarioResponse = userFromJson(response.body);
    List<Users> allUsers = await _getAllUsers();
    //Para ponerle el administrador debemos buscar todos los usuarios
    allUsers.forEach((user){
      if (user.apiKey == usuarioResponse.apiKey){
        usuarioResponse.id = user.id;
        usuarioResponse.administrator = user.administrator;
      }
    });
    return usuarioResponse;
  }

  Future<List<Users>> _getAllUsers()async{
    List<Users> allUsers = [];
    Uri uri = Uri.parse('${Env.endPointBase}/auth');
    Response response = await get(uri, headers: {'api_key': Env.apiKey},);
    if (response.statusCode != 200) return allUsers;
    allUsers = usersFromJson(response.body);
    return allUsers;
  }

  Future<Users?> registerWithNameEmailAndPass(String name, String email, String pass) async {
    Uri uri = Uri.parse('${Env.endPointBase}/auth/signup');
    Response response = await post(
      uri,
      headers: {'api_key': Env.apiKey, 'Content-Type': 'application/json'},
      body: jsonEncode({"name":name,"email": email, "pass": pass}),
    );
    print(response.statusCode);
    if (response.statusCode != 201) return null;
    Users usuarioResponse = userFromJson(response.body);
    List<Users> allUsers = await _getAllUsers();
    //Para ponerle el administrador debemos buscar todos los usuarios
    allUsers.forEach((user){
      if (user.apiKey == usuarioResponse.apiKey){
        usuarioResponse.id = user.id;
        usuarioResponse.administrator = user.administrator;
      }
    });
    return usuarioResponse;
  }

  Future<Users?> getUserByID(String idUser) async {
    Users? userADevolver = null;
    List<Users> allUsers = await _getAllUsers();
    //Para ponerle el administrador debemos buscar todos los usuarios
    allUsers.forEach((user){
      if (user.id == idUser){
        userADevolver = user;
      }
    });
    return userADevolver;
  }
}
