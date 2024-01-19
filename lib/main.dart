import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      home: QuoteOfTheDay(),
    );
  }
}

class QuoteOfTheDay extends StatefulWidget {
  @override
  _QuoteOfTheDayState createState() => _QuoteOfTheDayState();
}

class _QuoteOfTheDayState extends State<QuoteOfTheDay> {
  List<String> quotes = [
    // Add your quotes here
  ];

  String currentQuote = "";
  String name = "User";
  DateTime dateOfBirth = DateTime(2000, 1, 1);
  Color appColor = Colors.orange;
  Color backgroundColor = Colors.green;

  @override
  void initState() {
    super.initState();
    getRandomQuote();
  }

  void getRandomQuote() {
    Random random = Random();
    int index = random.nextInt(quotes.length);
    setState(() {
      currentQuote = quotes[index];
    });
  }

  void showProfileDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Settings'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('Date of Birth: ${dateOfBirth.toLocal()}'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != dateOfBirth) {
                    setState(() {
                      dateOfBirth = pickedDate;
                    });
                  }
                },
                child: Text('Pick Date of Birth'),
              ),
              SizedBox(height: 10),
              DropdownButton<Color?>(
                value: appColor,
                onChanged: (Color? value) {
                  setState(() {
                    appColor =
                        value ?? Colors.orange; // Default to orange if null
                    backgroundColor = value ?? Colors.green;
                    Navigator.of(context).pop();
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: Colors.orange,
                    child: Text('Orange'),
                  ),
                  DropdownMenuItem(
                    value: Colors.blue,
                    child: Text('Blue'),
                  ),
                  DropdownMenuItem(
                    value: Colors.green,
                    child: Text('Green'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                decoration: InputDecoration(labelText: 'Search'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote of the Day'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              showProfileDialog(context);
            },
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        color: backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'quoteTag',
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      currentQuote,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getRandomQuote();
                  },
                  child: Text('Get Another Quote'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
