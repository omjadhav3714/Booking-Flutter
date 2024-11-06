import 'package:acc_booking/screens/seat_entry_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Seat',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SeatEntryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

