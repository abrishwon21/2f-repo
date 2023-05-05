import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String _selectedDestination = '';
  String _selectedAirport = '';
  DateTime _departureDate = DateTime.now();
  DateTime _returnDate = DateTime.now();

  List destinations = ["Jima", "Hawassa", "Bahir Dar"];
  List airports = ["Jima", "Hawassa", "Bahir Dar"];

  void _showAirportPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Airport'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: airports.length,
            itemBuilder: (context, index) {
              final airport = airports[index];
              return ListTile(
                title: Text(airport),
                onTap: () {
                  setState(() {
                    _selectedAirport = airport;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButton(String label, onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget _buildSelectedOptionsTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text('Destination'),
            ),
            TableCell(
              child: Text(_selectedDestination),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('Beginning Airport'),
            ),
            TableCell(
              child: Text(_selectedAirport),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('Departure Date'),
            ),
            TableCell(
              child: Text(_departureDate?.toString() ?? ''),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('Return Date'),
            ),
            TableCell(
              child: Text(_returnDate?.toString() ?? ''),
            ),
          ],
        ),
      ],
    );
  }

  void _showDestinationPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Destination'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return ListTile(
                title: Text(destination),
                onTap: () {
                  setState(() {
                    _selectedDestination = destination;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Ticket Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _buildSelectionButton(
                    'Select Destination', _showDestinationPicker),
                SizedBox(width: 16.0),
                _buildSelectionButton(
                    'Select Beginning Airport', _showAirportPicker),
              ],
            ),
            SizedBox(height: 16.0),
            _buildSelectedOptionsTable(),
          ],
        ),
      ),
    );
  }
}
