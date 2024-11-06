// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_seat_screen.dart';

class SeatEntryScreen extends StatefulWidget {
  const SeatEntryScreen({super.key});

  @override
  _SeatEntryScreenState createState() => _SeatEntryScreenState();
}

class _SeatEntryScreenState extends State<SeatEntryScreen> {
  final TextEditingController _seatController = TextEditingController();
  String? storedSeatNumber;

  @override
  void initState() {
    super.initState();
    _loadSeatNumber();
  }

  Future<void> _loadSeatNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedSeatNumber = prefs.getString('seatNumber');
    });
  }

  // Save the seat number to SharedPreferences
  Future<void> _saveSeatNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('seatNumber', _seatController.text);
    setState(() {
      storedSeatNumber = _seatController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seat number saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Seat Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _seatController,
              decoration: const InputDecoration(
                labelText: 'Seat Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _saveSeatNumber();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookSeatScreen()),
                );
              },
              child: const Text('Save Seat Number'),
            ),
            const SizedBox(height: 20),
            if (storedSeatNumber != null)
              Text(
                'Stored Seat Number: $storedSeatNumber',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
