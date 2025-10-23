import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:user_hub_flutter/blocs/user_form/user_form_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _fechaController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("es", "ES"),
    );

    if (pickedDate != null) {
      setState(() {
        _fechaController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        context.read<UserFormBloc>().add(SetBirthDateEvent(birthDate: pickedDate));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((UserFormBloc bloc) => bloc.state);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Usuario'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Formulario de Usuario",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    // Nombre
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Nombre",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onChanged: (value) {
                        context.read<UserFormBloc>().add(SetFirstNameEvent(firstName: value));
                      },
                    ),
                    const SizedBox(height: 16),

                    // Apellido
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Apellido",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        context.read<UserFormBloc>().add(SetLastNameEvent(lastName: value));
                      },
                    ),
                    const SizedBox(height: 16),

                    // Fecha de nacimiento
                      TextFormField(
                      controller: _fechaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha de nacimiento",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 32),

                    // Botón continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.firstName == null || state.firstName!.isEmpty) {
                            _showErrorDialog(
                              context, 
                              "Campo requerido",
                              "Por favor ingresa tu nombre antes de continuar."
                            );
                            return;
                          }
                          if (state.lastName == null || state.lastName!.isEmpty) {
                            _showErrorDialog(
                              context, 
                              "Campo requerido",
                              "Por favor ingresa tu apellido antes de continuar."
                            );
                            return;
                          }
                          if (state.birthDate == null) {
                            _showErrorDialog(
                              context, 
                              "Campo requerido",
                              "Por favor ingresa tu fecha de nacimiento antes de continuar."
                            );
                            return;
                          }
                         if (state.birthDate!.isAfter(DateTime.now())) {
                            _showErrorDialog(
                              context, 
                              "Fecha inválida",
                              "La fecha de nacimiento no puede ser en el futuro."
                            );
                            return;
                          }
                          context.push('/addressScreen');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Continuar",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("Aceptar"),
          ),
        ],
      ),
    );
  }
}