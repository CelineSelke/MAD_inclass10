import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "First",
              labelText: "First",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Last",
              labelText: "Last",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email",
              labelText: "Email",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                return 'Please enter valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Contact No.",
              labelText: "Contact No.",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !RegExp(r"^\(?(\d{3})\)?[\s-]?(\d{3})[\s-]?(\d{4})$").hasMatch(value)) {
                return 'Please enter valid phone number ';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "Date of Birth (MM/DD/YY)",
              labelText: "Date of Birth",
            ),
            onTap: () async{
              FocusScope.of(context).requestFocus(new FocusNode());

              DateTime? date = await showDatePicker(context: context, 
              firstDate: DateTime(DateTime.now().year - 120), 
              lastDate:  DateTime.now(), 
              );
              if(date != null){
                _controller.text = date.month.toString() + "/" + date.day.toString() + "/" + date.year.toString().substring(2,4);
              }

            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Aadhar No.",
              labelText: "Aadhar No.",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty || !RegExp(r"\d{4}[\s]?\d{4}[\s]?\d{4}").hasMatch(value)) {
                return 'Please enter valid aadhar number ex. 1111 2222 3333 4444';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Address",
              labelText: "Address",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );

                    Future.delayed(const Duration(milliseconds: 250), () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const SuccessScreen(),
                        ),
                      );
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Signup Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the form screen
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
