import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search_box extends StatefulWidget {
  Search_box({Key? key}) : super(key: key);

  @override
  State<Search_box> createState() => _Search_boxState();
}

class _Search_boxState extends State<Search_box> {
  bool isLoading = false;
   Map<String, dynamic>? usersMap;
  TextEditingController searchController = TextEditingController();

  void onSearch() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      setState(() {
        isLoading = true;
      });
      await _firestore
          .collection('users')
          .where("Email", isEqualTo: searchController.text.trim())
          .get()
          .then((value) {
        setState(() {
          usersMap = value.docs[0].data();
          isLoading = false;
        });

        print(usersMap);
        print("suraj is goog boy");
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("user not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      // search wala container
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onSearch,
                            child: Container(
                              child: const Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Lets search someone"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                              margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  usersMap != null
                      ? ListTile(
                        leading:const  Icon(Icons.person),
                          title: Text(usersMap!['Email']),
                        )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Lets find friends "),
                            
                        ],
                      )
                ],
              ),
      ),
    );
  }
}
