import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

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
        title: Text('All Students', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
      ),
      body: FutureBuilder<List<Student>>(
        future: _students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/1706797738146.json',
                      width: 200, height: 200),
                  SizedBox(height: 20),
                  Text('Loading...', style: TextStyle(fontSize: 18, color: Colors.black54)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent)));
          } else if (!snapshot.hasData) {
            return Center(
                child: Text('No data available', style: TextStyle(fontSize: 18, color: Colors.black54)));
          } else {
            List<Student> students = snapshot.data!;
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      title: Text(student.name, style: TextStyle(fontSize: 16)),
                      trailing: Text('${student.presentations}', style: TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pop to /addStudent
          Navigator.pushNamed(context, '/addStudent');

        },
        child: Icon(Icons.add_outlined),
        backgroundColor: Colors.blue,

      ),
    );
  }
}

class Student {
  final String name;
  final int presentations;

  Student({required this.name, required this.presentations});
}
