import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:medico_project/User/User_menu.dart';

class ServiceForm extends StatefulWidget {
  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();
  late String serviceName;
  late String serviceDescription;
  late String serviceLocation;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform actions with the form data, e.g., send it to a server or process it.
      // For this example, we'll simply print the data to the console.
      print('Service Name: $serviceName');
      print('Service Description: $serviceDescription');
      print('Service Location: $serviceLocation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  serviceName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the service name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  serviceName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Service Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the service description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  serviceDescription = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Service Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the service location.';
                  }
                  return null;
                },
                onSaved: (value) {
                  serviceLocation = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Example()));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
