import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  late final String dataType;
  late final String value;

  TextRow({
    required this.dataType,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dataType,
            style: TextStyle(fontSize: 18, color: Colors.white60),
          ),
          SizedBox(
            width: deviceSize.width * 0.02,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
