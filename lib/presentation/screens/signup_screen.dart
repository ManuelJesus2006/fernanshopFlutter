import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/button_configuration_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/users_service.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final GlobalKey<FormState> _keyFormulario = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    final buttonConfigurationProvider = Provider.of<ButtonConfigurationProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'Registresé a',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'FERNANSHOP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _keyFormulario,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCustomInput(
                          controller: nameController,
                          label: 'Nombre de usuario',
                          icon: Icons.person,
                          keyboardType: TextInputType.name,
                          context: context,
                        ),
                        const SizedBox(height: 20),
                        _buildCustomInput(
                          controller: emailController,
                          label: 'Correo Electrónico',
                          icon: Icons.alternate_email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          context: context,
                        ),
                        const SizedBox(height: 20),
                        _buildCustomInput(
                          controller: passController,
                          label: 'Contraseña',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: buttonConfigurationProvider.botonClickado ? null : () {
                      if (_keyFormulario.currentState!.validate()) {
                        buttonConfigurationProvider.switchBotones();
                        usersProvider.mostrarCargando();
                        registro(
                          nameController.text,
                          emailController.text,
                          passController.text,
                          usersProvider,
                          context,
                          buttonConfigurationProvider
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    configProvider.deshabilitarEnSignup();
                  },
                  child: Text('¿Tiene una cuenta? Inicie sesión'),
                ),
                if (usersProvider.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (usersProvider.registerFailed)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red[700],
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Error en el registro',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'La contraseña debe tener al menos 5 caracteres y el formato del correo debe ser válido.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height:
                                      1.3, //Mejora la legibilidad de la frase larga
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registro(
    String name,
    String email,
    String pass,
    UsersProvider usersProvider,
    BuildContext context,
    ButtonConfigurationProvider buttonConfigurationProvider
  ) async {
    Users? userFromRequest = await UsersService().registerWithNameEmailAndPass(
      name,
      email,
      pass,
    );
    if (userFromRequest != null) {
      usersProvider.confirmarLogueo(userFromRequest);
      buttonConfigurationProvider.switchBotones();
    } else{
      usersProvider.confirmarRegistroInvalido();
      buttonConfigurationProvider.switchBotones();
    }
      
  }
}

Widget _buildCustomInput({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required BuildContext context,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;

  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: keyboardType,
    cursorColor: Colors.indigo,
    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Este campo es obligatorio';
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: isDark ? Colors.indigo[200] : Colors.indigo[400],
        size: 22,
      ),
      filled: true,
      fillColor: isDark ? Colors.grey[850] : Colors.grey[50],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.indigo, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    ),
  );
}
