// ignore_for_file: library_private_types_in_public_api
import 'package:acc_booking/widgets/disclosure_section_widget.dart';
import 'package:acc_booking/screens/seat_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookSeatScreen extends StatefulWidget {
  const BookSeatScreen({super.key});

  @override
  _BookSeatScreenState createState() => _BookSeatScreenState();
}

class _BookSeatScreenState extends State<BookSeatScreen> {
  String selectedCity = 'Mumbai';
  String selectedDC = 'ILMUMBAISTP';
  String selectedBuilding = 'SDB01';
  String selectedAllocation = 'General';
  final List<String> cities = ['Mumbai', 'Pune', 'Bangalore'];
  final List<String> dcOptions = ['ILMUMBAISTP', 'PUNESTP', 'BLRSTP'];
  final List<String> buildings = ['SDB01', 'CBD01', 'ABD01'];
  String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  late String selectedDate;
  late List<String> dateOptions;
  Color purple = const Color(0xFF8626C3);
  String? storedSeatNumber;

  @override
  void initState() {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime tomorrow = today.add(const Duration(days: 1));

    DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    dateOptions = [
      dateFormat.format(yesterday),
      dateFormat.format(today),
      dateFormat.format(tomorrow),
    ];

    selectedDate = dateFormat.format(yesterday);
    _loadSeatNumber();
    super.initState();
  }

  Future<void> _loadSeatNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedSeatNumber = prefs.getString('seatNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double paddingFactor = screenWidth * 0.04;
    double cardPadding = screenWidth * 0.03;
    double buttonHeight = screenHeight * 0.04;
    double buttonWidth = screenWidth * 0.25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: const Text(
          'BOOK SEAT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SeatEntryScreen(),
              ),
            );
          }),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: (() {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingFactor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.all(cardPadding),
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Booking',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: buttonHeight,
                              width: buttonWidth,
                              child: OutlinedButton(
                                onPressed: () {
                                  //
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.green, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04),
                                ),
                                child: const Text(
                                  "BOOKED",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            const Icon(
                              Icons.more_vert_outlined,
                              size: 28,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Cubicle: MUM02 01 04 A ${storedSeatNumber ?? "Enter seat"}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Mumbai, ILMUMBAISTP, SDB01, FLOOR-4, A Wing',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: screenWidth * 0.06,
                  backgroundColor: purple,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Text(
                'Provide your DC and building preferences',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: screenHeight * 0.01),
              DropdownButtonFormField<String>(
                value: selectedDate,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: UnderlineInputBorder(),
                ),
                items: dateOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDate = newValue!;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: UnderlineInputBorder(),
                ),
                items: cities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              DropdownButtonFormField<String>(
                value: selectedDC,
                decoration: const InputDecoration(
                  labelText: 'DC',
                  border: UnderlineInputBorder(),
                ),
                items: dcOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDC = newValue!;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                'Allocation',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Account',
                          groupValue: selectedAllocation,
                          onChanged: (value) {
                            setState(() {
                              selectedAllocation = value!;
                            });
                          },
                          activeColor: purple,
                        ),
                        const Text(
                          'Account',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Unit/Subunit',
                          groupValue: selectedAllocation,
                          onChanged: (value) {
                            setState(() {
                              selectedAllocation = value!;
                            });
                          },
                          activeColor: purple,
                        ),
                        const Text(
                          'Unit/Subunit',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'General',
                          groupValue: selectedAllocation,
                          onChanged: (value) {
                            setState(() {
                              selectedAllocation = value!;
                            });
                          },
                          activeColor: purple,
                        ),
                        const Text(
                          'General',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              DropdownButtonFormField<String>(
                value: selectedBuilding,
                decoration: const InputDecoration(
                  labelText: 'Building Number',
                  border: UnderlineInputBorder(),
                ),
                items: buildings.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedBuilding = newValue!;
                  });
                },
              ),
              const DisclosureSectionWidget()
            ],
          ),
        ),
      ),
    );
  }
}
