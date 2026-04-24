import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Divider(height: 3, color: Color.fromARGB(55, 0, 0, 0)),
    );
  }
}
