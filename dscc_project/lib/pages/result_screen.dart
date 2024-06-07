import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  bool found = false;
  List<String> infoList = [];

  ResultScreen({super.key, required this.text});

  // Query all firstname from firestore and give it to the list
  Future<List<String>> getFirstName() async {
    List<String> firstNameList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();
    for (var document in querySnapshot.docs) {
      firstNameList.add(document['firstName']);
    }
    int position = -1;
    // TODO: check if the text contain any firstname from the list the query all info if that firstname from db else return text("Not found")
    for (int i = 0; i < firstNameList.length; i++) {
      if (text.toLowerCase().contains(firstNameList[i].toLowerCase())) {
        position = i;
        found = true;
        break;
      }
    }
    // TODO: query all info that relate to that firstname if that firstname from db is found else return text("Not found")
    List<String> detailList = await getDetail(firstNameList[position]);

    return detailList;
  }

  Future<List<String>> getDetail(String firstName) async {
    // TODO: query all info that relate to that firstname if that firstname from db is found else return []
    List<String> detailList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('firstName', isEqualTo: firstName)
        .get();

    for (var document in querySnapshot.docs) {
      detailList.add(document['id']);
      detailList.add(document['firstName']);
      detailList.add(document['lastName']);
      detailList.add(document['level']);
      detailList.add(document['presentation'].toString());
    }

    return detailList;
  }

  // update presentation count
  void updatePresentationCount() async {
    // TODO: update presentation count
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('firstName', isEqualTo: infoList[1])
        .get();

    for (var document in querySnapshot.docs) {
      document.reference.update({'presentation': document['presentation'] + 1});
    }
  }

  // check if the text contain any firstname from the list the query all info if that firstname from db else return text("Not found")

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: getFirstName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      infoList = snapshot.data!;
                      if (found) {
                        return Column(
                          children: [
                            Text(
                              'ID: ${infoList[0]}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Full Name: ${infoList[2]} ${infoList[1]}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Level: ${infoList[3]}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              int.parse(infoList[4]) == 1 ? 'Attendence: ${infoList[4]} time' : 'Attendence: ${infoList[4]} times',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Back'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // presentation + 1
                                    updatePresentationCount();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Text(
                          'Not Found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                            ),
                            Lottie.asset('assets/animations/1706797738146.json', width: 200, height: 200),
                            const SizedBox(height: 20),
                            const Text('No Name Matched Please Try Again' , style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      );
}
