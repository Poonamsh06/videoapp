
import 'package:biscuit1/utilities/constants.dart';
import 'package:flutter/material.dart';

class OneLineCard extends StatelessWidget {
  const OneLineCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 70, 150, 249),
        ),
        child: Text(
          message,
          style: kSmallSizeTextStyle,
        ),
      ),
    );
  }
}
