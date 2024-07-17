import 'package:flutter/material.dart';
import 'package:project1/add_phone.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedLanguage = 'English'; // Pre-select English

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image (replace 'path/to/your/image.png' with your actual image path)
            Image.asset(
              'assets/images/image.png',
              width: 56,
              height: 56,
            ),
            const SizedBox(height: 20),
            const Text(
              'Please select your Language',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You can change the language',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 115, 114, 114)),
            ),
            const Text(
              'at any time.',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 115, 114, 114)),
            ),
            const SizedBox(height: 15),

            // Dropdown Menu inside a Container (optional)
            Container(
              margin: const EdgeInsets.only(right: 60, left: 60),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                // borderRadius:Null, // Adjust as needed
                border: Border.all(color: Colors.black), // Adjust as needed
              ),
              child: DropdownButtonFormField<String>(
                value: selectedLanguage, // Pre-selected value
                icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove default border
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: <String>[
                  'English',
                  'French',
                  'Spanish'
                ] // List of languages
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),
            Container(
              // padding:
              //     const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(5.0), // Adjust as needed
                color: Color.fromARGB(255, 13, 72, 120), // Adjust as needed
              ),
              width: 270,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPhone()),
                  );
                  //print('Selected Language: $selectedLanguage');
                },
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
