import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    Users user = usersProvider.userLogued!;
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Icon(Icons.person, size: 180),
              Text(
                'Bienvenido, ${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10,),
              !user.administrator! ? 
              Text('⚠️Usted no es un administrador',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)) 
              : Text('✅Usted es administrador',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              Divider(thickness: 1),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: GestureDetector(
                  onTap: ()=> context.push('/settings'),
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: configProvider.temaOscuro
                        ? Colors.grey[600]
                        : Colors.indigo,
                        
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, color: Colors.white,),

                        Text(
                          'Configuración',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (user.administrator!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: ()=> context.push('/nuevoProducto'),
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: configProvider.temaOscuro
                        ? Colors.grey[600]
                        : Colors.indigo,
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white,),

                        Text(
                          'Añadir un nuevo producto',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: GestureDetector(
                  onTap: (){
                    usersProvider.logoutAndRemove();
                    configProvider.deshabilitarEnSignup();
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.white,),

                        Text(
                          'Cerrar sesión',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
