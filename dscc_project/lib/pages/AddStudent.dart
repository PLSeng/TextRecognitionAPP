import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  Future<void> addStudentToFirestore() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('students').add({
        'id': _idController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'gender': _genderController.text,
        'level': _levelController.text,
        'presentation': 0, // Starting value for presentation count
      });

      // Clear the text fields after successful addition
      _idController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _genderController.clear();
      _levelController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student Added Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Student ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Last Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter First Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _levelController,
                decoration: InputDecoration(labelText: 'Level'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter level';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addStudentToFirestore,
                child: Text('Add Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
