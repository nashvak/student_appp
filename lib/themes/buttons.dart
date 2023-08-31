import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const Button(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

//constants

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                )
              : Text(title, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
