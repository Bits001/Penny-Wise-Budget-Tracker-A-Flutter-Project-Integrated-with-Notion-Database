import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Items {
  final String name;
  final String category;
  final double price;
  final DateTime date;
  Items({
    required this.name,
    required this.category,
    required this.price,
    required this.date,
  });

  factory Items.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final dateStr = properties['Date']?['date']?['start'];
    return Items(
      name: properties['Name']?['title']?[0]['plain_text'] ?? '?',
      category: properties['Category']?['select']?['name'] ?? 'Any',
      price: (properties['Price']?['number'] ?? 0).toDouble(),
      date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
    );
  }
}
