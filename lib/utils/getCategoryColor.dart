import 'package:flutter/material.dart';

Color getCategoryColor(String category) {
  switch (category) {
    case 'Entertainment':
      return Colors.purple[400]!;

    case 'Food':
      return Colors.green[400]!;

    case 'Utilities':
      return Colors.blue[400]!;

    case 'Personal':
      return Colors.red[400]!;

    default:
      return Colors.pink[400]!;
  }
}
