import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _keyFormulario = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Center(
          child: Column(
            children: [
              SizedBox(height: 60,),
              Text('Bienvenido a', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'FERNANSHOP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.white,
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
          controller: emailController,
          label: 'Correo Electrónico',
          icon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildCustomInput(
          controller: passController,
          label: 'Contraseña',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
        ),
      ],
    ),
  ),
)
            ],
          ),
        )
      ),
    );
  }
}

Widget _buildCustomInput({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: keyboardType,
    cursorColor: Colors.indigo,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.indigo[400], size: 22),
      filled: true,
      fillColor: Colors.grey[50],
      // Bordes redondeados y suaves
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.indigo, width: 1.5),
      ),
      // Error style
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