import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_hub_flutter/blocs/address/address_bloc.dart';


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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.location_off,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No hay direcciones registradas",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.home, color: Colors.teal),
                    title: Text(address),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        context.read<AddressBloc>().add(DeleteAddressEvent(address: address));
                      },
                    ),
                  ),
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
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar dirección"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Ingresa una dirección",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final address = controller.text.trim();
              if (address.isNotEmpty) {
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