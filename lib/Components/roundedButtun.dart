import 'package:flutter/material.dart';

class RoundedButtun extends StatelessWidget {
  String label;
  final VoidCallback function;

  RoundedButtun(this.label, this.function);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Color(0xFF678983),
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: function,
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFE6DDC4)),
          ),
        ),
      ),
    );
  }
}
