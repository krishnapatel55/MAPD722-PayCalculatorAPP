import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Pay Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final hoursController = TextEditingController();
  final rateController = TextEditingController();
  double regularPay = 0;
  double overtime = 0;
  double totalPay = 0;
  double tax = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    hoursController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      // color: Colors.grey[100],
      // margin: const EdgeInsets.all(15),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(12),
          height: 525,
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(children: [hours(), rate(), calculate(), report()]),
        ),
        Container(
          height: 120,
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Align(
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Krishna Patel',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '301268911',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        )
      ]),
    );
  }

  Widget hours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const Text('test title'),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
              controller: hoursController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Number of hours')),
        )
      ],
    );
  }

  Widget rate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const Text('test title'),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
              controller: rateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Hourly rate')),
        )
      ],
    );
  }

  Widget calculate() {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(15),
          foregroundColor: Colors.black,
          backgroundColor: Colors.blue, // foreground
        ),
        onPressed: () {
          if (hoursController.text.isEmpty || rateController.text.isEmpty) {
            showAlertDialog(context);
            return;
          }
          var hours = double.parse(hoursController.text);
          var rate = double.parse(rateController.text);
          setState(() {
            FocusManager.instance.primaryFocus?.unfocus();
            if (hours <= 40) {
              regularPay = hours * rate;
              totalPay = regularPay;
              overtime = 0;
            } else {
              regularPay = 40 * rate;
              totalPay = ((hours - 40) * rate * 1.5 + 40 * rate);
              overtime = (hours - 40) * rate * 1.5;
            }
            tax = totalPay * 0.18;
          });
        },
        child: const Text(
          'Calculate',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Please enter No. of Hours and Hourly Rate value."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget report() {
    return Container(
      height: 210,
      width: 500,
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Report',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            Row(
              children: [
                const Text(
                  'Regular pay :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  '$regularPay',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Overtime pay :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  overtime.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Total pay :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  totalPay.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Tax :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  tax.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ]),
    );
  }
}
