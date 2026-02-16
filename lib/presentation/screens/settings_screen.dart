import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de la app')),
      body: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 90),
            title: Text('Modo oscuro'),
            trailing: Switch(
              value: configProvider.temaOscuro,
              onChanged: (value) => configProvider.actualizaTema(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LicensePage()),
              );
            },
            child: Text('Licencias', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
