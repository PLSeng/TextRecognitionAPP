import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayAllScreen extends StatefulWidget {
  @override
  _DisplayAllScreenState createState() => _DisplayAllScreenState();
}

class _DisplayAllScreenState extends State<DisplayAllScreen> {
  late Future<List<Student>> _students;

  @override
  void initState() {
    super.initState();
    _students = getAllStudents();
  }

  Future<List<Student>> getAllStudents() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('students').get();

    List<Student> students = querySnapshot.docs.map((doc) {
      return Student(
        name: '${doc['lastName']} ${doc['firstName']}',
        presentations: doc['presentation'],
      );
    }).toList();

    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
      ),
      body: FutureBuilder<List<Student>>(
        future: _students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            List<Student> students = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Presentations')),
                ],
                rows: students
                    .map(
                      (student) => DataRow(cells: [
                    DataCell(Text(student.name)),
                    DataCell(Text(student.presentations.toString())),
                  ]),
                )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class Student {
  final String name;
  final int presentations;

  Student({required this.name, required this.presentations});
}
