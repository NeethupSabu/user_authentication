import 'package:flutter/material.dart';

class ProfileSet extends StatefulWidget {
  @override
  _ProfileSetState createState() => _ProfileSetState();
}

class _ProfileSetState extends State<ProfileSet> {
  String selectedProfile = 'None'; // Variable to store selected profile index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please select your profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'shipper',
                    groupValue: selectedProfile,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        selectedProfile = selectedValue!;
                      });
                    },
                    title: const Row(
                      children: [
                        Icon(Icons.warehouse, size: 30),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipper', style: TextStyle(fontSize: 18)),
                            Text(
                              'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  RadioListTile<String>(
                    value: 'transporter',
                    groupValue: selectedProfile,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        selectedProfile = selectedValue!;
                      });
                    },
                    title: const Row(
                      children: [
                        Icon(Icons.local_shipping, size: 30),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Transporter', style: TextStyle(fontSize: 18)),
                            Text(
                              'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add your onPressed code here!
                  print('Continue button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
