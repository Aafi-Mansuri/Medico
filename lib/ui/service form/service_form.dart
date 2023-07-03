import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/utils/colors.dart';
import 'package:medico_ibhavan/utils/components/my_button2.dart';

// import 'package:medico_project/User/User_menu.dart';
class ServiceForm extends StatefulWidget {
  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  _MyformState() {
    _selectedVal = _serviceslist[0];
  }

  final _formKey = GlobalKey<FormState>();
  late String customereName;
  late String customeraddress;
  late String customerenumber;
  late String servicename;
  late String serviceDescription;
  late String _selectedService;
  final _serviceslist = ["test1", "test2", "test3", "test4", "test5"];
  String? _selectedVal = "test1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.medical_services,
          color: Color(whiteColor),
          size: 27,
        ),
        backgroundColor: const Color(appBarBlack),
        title: const Text('Service Form',
            style: TextStyle(
                color: Color(whiteColor), fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    customereName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Customer Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    customeraddress = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Customer PhoneNumber'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    customerenumber = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _selectedVal,
                  items: _serviceslist
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedVal = val as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Color(primaryDark),
                  ),
                  dropdownColor: Colors.deepPurple.shade50,
                  decoration: InputDecoration(labelText: "Service Names"),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Service Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the service Description.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    serviceDescription = value!;
                  },
                ),
                const SizedBox(height: 30),
                MyButton2(
                  onTap: () {},
                  buttonText: 'Submit',
                  vPadding: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
