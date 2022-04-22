import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TextField',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  FocusNode textFocus1 = FocusNode();
  FocusNode textFocus2 = FocusNode();

  String firstControllerValue = "";
  String secondControllerValue = "";
  String displayValue = "";

  _swap() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String temp = textController1.text;
    textController1.text = textController2.text;
    textController2.text = temp;
    firstControllerValue = textController1.text;
    secondControllerValue = textController2.text;
    setState(() {});
  }

  _copy() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    textController2.text = textController1.text;
    secondControllerValue = textController2.text;
    setState(() {});
  }

  _displayFirstControllervalue() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      displayValue = textController1.text;
    });
  }

  _displaySecondControllervalue() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      displayValue = textController2.text;
    });
  }

  _focusToFirstController() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).requestFocus(textFocus1);
  }

  _focusToSecondController() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).requestFocus(textFocus2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Flutter TextField"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: textController1,
                focusNode: textFocus1,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (newvalue) {
                  setState(() {
                    firstControllerValue = newvalue;
                  });
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: textController2,
                focusNode: textFocus2,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (newvalue) {
                  setState(() {
                    secondControllerValue = newvalue;
                  });
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                      "Current value of First Textbox is: $firstControllerValue"),
                  const SizedBox(height: 20),
                  Text(
                      "Current value of Second Textbox is: $secondControllerValue"),
                  const SizedBox(height: 20),
                  Text("Display Textbox value is: $displayValue"),
                  const SizedBox(height: 20),
                ],
              ),
              ElevatedButton(
                onPressed: _focusToFirstController,
                child: const Text("Focus to First Controller"),
              ),
              ElevatedButton(
                onPressed: _focusToSecondController,
                child: const Text("Focus to Second Controller"),
              ),
              ElevatedButton(
                onPressed: _displayFirstControllervalue,
                child: const Text("Display First Controller Value"),
              ),
              ElevatedButton(
                onPressed: _displaySecondControllervalue,
                child: const Text("Display Second Controller Value"),
              ),
              ElevatedButton(
                onPressed: _swap,
                child: const Text("Swap Controller Value"),
              ),
              ElevatedButton(
                onPressed: _copy,
                child: const Text("Copy First Controller Value"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
