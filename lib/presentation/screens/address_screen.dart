import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_hub_flutter/blocs/address/address_bloc.dart';
import 'package:user_hub_flutter/models/address_model.dart';
import 'package:user_hub_flutter/presentation/widgets/address_card.dart';
import 'package:user_hub_flutter/presentation/widgets/custom_text_field.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((AddressBloc bloc) => bloc.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Direcciones"),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: state.addresses!.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No hay direcciones registradas",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.addresses!.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final address = state.addresses![index];
                return AddressCard(
                  address: address,
                  onDelete: () {
                    context.read<AddressBloc>().add(DeleteAddressEvent(address: address));
                  },
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAddressDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            context.push('/summaryScreen');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Ver Resumen",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    final countryController = TextEditingController();
    final departmentController = TextEditingController();
    final municipalityController = TextEditingController();
    final streetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar dirección"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(controller: countryController, label: "País"),
              const SizedBox(height: 8),
              CustomTextField(controller: departmentController, label: "Departamento"),
              const SizedBox(height: 8),
              CustomTextField(controller: municipalityController, label: "Municipio"),
              const SizedBox(height: 8),
              CustomTextField(controller: streetController, label: "Dirección física"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final address = AddressModel(
                country: countryController.text.trim(),
                department: departmentController.text.trim(),
                municipality: municipalityController.text.trim(),
                street: streetController.text.trim(),
              );

              if (address.country.isNotEmpty &&
                  address.department.isNotEmpty &&
                  address.municipality.isNotEmpty &&
                  address.street.isNotEmpty) {
                context.read<AddressBloc>().add(SetAddressEvent(address: address));
              }

              context.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
