import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final void Function()? ontap;
  final String text;

  const Mybutton({super.key, this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(9)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ));
  }
}
