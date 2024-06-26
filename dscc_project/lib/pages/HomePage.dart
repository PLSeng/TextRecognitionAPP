import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// HomePage class have 3 centre buttons to navigate to different pages

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        _header(),
        _body(),
      ],
    );
  }

  Widget _header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      color: const Color.fromRGBO(230, 253, 253, 1.0),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              HomePage._title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ),
          Lottie.asset(
            "assets/animations/1706799477387.json",
            width: MediaQuery.of(context).size.width * 0.45,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }

  Widget _body(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          _buildButton("Scan", () {
            Navigator.pushNamed(context, '/scan');
          }),
          _buildButton("Display all", () {
            Navigator.pushNamed(context, '/display');
          }),
          _buildButton("Add Student", () {
            Navigator.pushNamed(context, '/addStudent');
          }),
          _buildButton("Logout", () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        child: Text(
          text,
          style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),)
      ),
    );
  }
}