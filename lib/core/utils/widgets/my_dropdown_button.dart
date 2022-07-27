import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    final items = [
      '1 day before',
      '1 hour before',
      '30 min before',
      '10 min before'
    ];
    return Container(
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          iconSize: 30,
          elevation: 16,
          onChanged: (newValue) {
            dropdownValue = newValue;
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
