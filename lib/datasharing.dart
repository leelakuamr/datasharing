import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DataTransferScreen extends StatefulWidget {
  @override
  _DataTransferScreenState createState() => _DataTransferScreenState();
}

class _DataTransferScreenState extends State<DataTransferScreen> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _isLoading = false;
  String _result = '';

  Future<void> transferData() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/transfer-data'), // Use 10.0.2.2 for Android Emulator
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'senderNumber': '9876543210', // later dynamic login
          'receiverNumber': _receiverController.text.trim(),
          'dataAmount': _amountController.text.trim(),
        }),
      );

      final resultData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          _result = '✅ Success: ${resultData['message']}';
        });
      } else {
        setState(() {
          _result = '❌ Error: ${resultData['message']}';
        });
      }
    } catch (error) {
      setState(() {
        _result = '❌ Failed: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Data 📡'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(
                labelText: 'Receiver Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount (in MB)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: transferData,
                    child: Text('Send Data'),
                  ),
            SizedBox(height: 24),
            Text(
              _result,
              style: TextStyle(fontSize: 16, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

