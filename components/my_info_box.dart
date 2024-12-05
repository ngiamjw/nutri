import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MyBox({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade500 : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue.shade500, width: 1),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.grey.shade50 : Colors.grey.shade50,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
