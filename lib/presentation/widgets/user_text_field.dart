import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool readOnly;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const UserTextField({
    super.key,
    required this.label,
    required this.icon,
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
