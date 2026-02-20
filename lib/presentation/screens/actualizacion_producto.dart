import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/button_configuration_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/tech_product_service.dart';
import 'package:provider/provider.dart';

class ActualizacionProducto extends StatefulWidget {
  const ActualizacionProducto({super.key, required this.producto});

  final TechProduct producto;

  @override
  State<ActualizacionProducto> createState() => _ActualizacionProductoState();
}

class _ActualizacionProductoState extends State<ActualizacionProducto> {
  final GlobalKey<FormState> _keyFormulario = GlobalKey<FormState>();

  final TextEditingController businessController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController characteristicsController = TextEditingController();
  final TextEditingController relaseDateController = TextEditingController();

  //Añadimos siempre al iniciar los valores de los input con los valores del producto
  @override
  void initState() {
    super.initState();
    businessController.text = widget.producto.business;
    nameController.text = widget.producto.name;
    typeController.text = widget.producto.type;
    priceController.text = widget.producto.price.toString();
    imageUrlController.text = widget.producto.imageUrl;
    relaseDateController.text = widget.producto.releaseDate!.toIso8601String().split('T')[0];

    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    final charData = widget.producto.characteristics?.toJson() ?? {};
    characteristicsController.text = encoder.convert(charData);
  }

  @override
  void dispose() {
    businessController.dispose();
    nameController.dispose();
    typeController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    characteristicsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonConfigurationProvider = Provider.of<ButtonConfigurationProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('Actualizar Producto'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Editando: ${widget.producto.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: isDark ? Colors.white : Colors.indigo
                ),
              ),
              const SizedBox(height: 20),

              Form(
                key: _keyFormulario,
                child: Column(
                  children: [
                    _buildInput(
                      controller: businessController,
                      label: 'Marca / Fabricante',
                      icon: Icons.business,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    _buildInput(
                      controller: nameController,
                      label: 'Nombre del producto',
                      icon: Icons.shopping_bag,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    _buildInput(
                      controller: typeController,
                      label: 'Tipo (Unique options: Processor, Graphics Card, Motherboard, RAM, SSD, CPU Cooler, Power Supply and HDD)',
                      icon: Icons.category,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    _buildInput(
                      controller: priceController,
                      label: 'Precio (€)',
                      icon: Icons.euro,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    _buildInput(
                      controller: imageUrlController,
                      label: 'URL de la imagen',
                      icon: Icons.image,
                      keyboardType: TextInputType.url,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    _buildInput(
                      controller: relaseDateController,
                      label: 'Fecha de lanzamiento',
                      icon: Icons.date_range,
                      keyboardType: TextInputType.datetime,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: characteristicsController,
                      maxLines: 12,
                      style: TextStyle( 
                        fontSize: 12,
                        color: isDark ? Colors.white : Colors.black87
                      ),
                      decoration: InputDecoration(
                        labelText: 'Características (JSON)',
                        labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[700]),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.data_object, color: isDark ? Colors.indigoAccent : Colors.indigo),
                        filled: true,
                        fillColor: isDark ? Colors.grey[800] : Colors.grey[50],
                        helperText: 'Edite respetando formato JSON',
                        helperStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[400]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: isDark ? Colors.indigoAccent : Colors.indigo, 
                            width: 2
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Requerido';
                        try {
                          jsonDecode(value);
                          return null;
                        } catch (e) {
                          return 'Error en el JSON';
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar Cambios'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.grey[700] : Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: buttonConfigurationProvider.botonClickado ? null : () {
                          buttonConfigurationProvider.switchBotones();
                          if (_keyFormulario.currentState!.validate()) {
                            _guardarProducto(buttonConfigurationProvider);
                          }else buttonConfigurationProvider.switchBotones();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[800]),
        prefixIcon: Icon(icon, color: isDark ? Colors.indigoAccent : Colors.indigo),
        filled: true,
        fillColor: isDark ? Colors.grey[800] : Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDark ? Colors.indigoAccent : Colors.indigo, 
            width: 2
          ),
        ),
      ),
    );
  }

  void _guardarProducto(ButtonConfigurationProvider buttonConfigurationProvider)async {
    try {
      final Map<String, dynamic> characteristicsJson = jsonDecode(characteristicsController.text);
      final characteristicsObj = Characteristics.fromJson(characteristicsJson);

      TechProduct productoActualizado = TechProduct(
        id: widget.producto.id,
        name: nameController.text,
        business: businessController.text,
        price: double.parse(priceController.text),
        type: typeController.text,
        imageUrl: imageUrlController.text,
        characteristics: characteristicsObj,
        releaseDate: DateTime.parse(relaseDateController.text)
      );

      bool exito = await TechProductService().actualizarProductoByID(productoActualizado);
  
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exito ? 'Actualizado correctamente' : 'Error al actualizar el producto'),
          backgroundColor: exito 
            ? (Theme.of(context).brightness == Brightness.dark ? Colors.green[700] : Colors.indigo)
            : Colors.red,
        ),
      );
      
      if (exito){
        context.go('/home');
        buttonConfigurationProvider.switchBotones();
      } 
      else buttonConfigurationProvider.switchBotones();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Algunos datos no han sido introducidos correctamente'), backgroundColor: Colors.red),
      );
    }
  }
}