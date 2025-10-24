import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:user_hub_flutter/blocs/user_form/user_form_bloc.dart';
import 'package:user_hub_flutter/presentation/widgets/error_dialog.dart';
import 'package:user_hub_flutter/presentation/widgets/user_text_field.dart';

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
                    UserTextField(
                      label: "Nombre",
                      icon: Icons.person_outline,
                      onChanged: (value) {
                        context.read<UserFormBloc>().add(SetFirstNameEvent(firstName: value));
                      },
                    ),
                    const SizedBox(height: 16),

                    // Apellido
                    UserTextField(
                      label: "Apellido",
                      icon: Icons.person,
                      onChanged: (value) {
                        context.read<UserFormBloc>().add(SetLastNameEvent(lastName: value));
                      },
                    ),
                    const SizedBox(height: 16),

                    // Fecha de nacimiento
                    UserTextField(
                      label: "Fecha de nacimiento",
                      icon: Icons.calendar_today,
                      readOnly: true,
                      controller: _fechaController,
                      onTap: () => _selectDate(context),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Botón continuar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.firstName == null || state.firstName!.isEmpty) {
                            ErrorDialog.show(
                              context,
                              "Campo requerido",
                              "Por favor ingresa tu nombre antes de continuar.",
                            );
                            return;
                          }
                          if (state.lastName == null || state.lastName!.isEmpty) {
                            ErrorDialog.show(
                              context,
                              "Campo requerido",
                              "Por favor ingresa tu apellido antes de continuar.",
                            );
                            return;
                          }
                          if (state.birthDate == null) {
                            ErrorDialog.show(
                              context,
                              "Campo requerido",
                              "Por favor ingresa tu fecha de nacimiento antes de continuar.",
                            );
                            return;
                          }
                         if (state.birthDate!.isAfter(DateTime.now())) {
                            ErrorDialog.show(
                              context,
                              "Fecha inválida",
                              "La fecha de nacimiento no puede ser en el futuro.",
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
}