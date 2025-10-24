import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_hub_flutter/blocs/address/address_bloc.dart';
import 'package:user_hub_flutter/blocs/user_form/user_form_bloc.dart';
import 'package:user_hub_flutter/models/address_model.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.select((UserFormBloc bloc) => bloc.state);
    final addressState = context.select((AddressBloc bloc) => bloc.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen de Usuario"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Datos del Usuario",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text("${userState.firstName ?? ''} ${userState.lastName ?? ''}"),
                subtitle: const Text("Nombre completo"),
              ),
              ListTile(
                leading: const Icon(Icons.cake),
                title: Text(
                  userState.birthDate != null
                      ? DateFormat('dd/MM/yyyy').format(userState.birthDate!)
                      : "No definida",
                ),
                subtitle: const Text("Fecha de nacimiento"),
              ),
              const Divider(height: 32),
              const Text(
                "Direcciones",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (addressState.addresses!.isEmpty)
                const Text("No hay direcciones registradas"),
              ...addressState.addresses!.map((AddressModel address) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.home, color: Colors.teal),
                      title: Text(address.street),
                      subtitle: Text(
                        "${address.municipality}, ${address.department}, ${address.country}",
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
