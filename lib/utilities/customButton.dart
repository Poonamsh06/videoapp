import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final String title;
  final IconData? icon;

  const CustomButton({
    required this.onPressed,
    this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              ),
            Container(
              constraints: const BoxConstraints(
                minWidth: 100,
                minHeight: 50,
              ), // min sizes for Material buttons
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
