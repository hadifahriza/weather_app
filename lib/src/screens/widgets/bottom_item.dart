import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    Key? key,
    this.label,
    this.unit,
    this.value,
  }) : super(key: key);

  final String? label;
  final String? unit;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Text(
          value!,
          style: const  TextStyle(
            color: Colors.white,
            fontSize: 26.0,
          ),
        ),
        Text(
          unit!,
          style: const  TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}