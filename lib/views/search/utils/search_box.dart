import 'package:VMedia/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/profile_screen.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool isLoading = false;
  UserModel? user;
  //  Map<String, dynamic>? usersMap;
  TextEditingController searchController = TextEditingController();

  void onSearch() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      setState(() {
        isLoading = true;
      });

      _firestore
          .collection('users')
          .where(
            "name",
            isGreaterThanOrEqualTo: searchController.text.trim(),
          )
          .snapshots();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      const Center(child: Text('user not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var length = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // search wala container
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      height: length.height * 0.05,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(24)),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  onSearch();
                                },
                                icon: const Icon(
                                  Icons.search,
                                )),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.person),
                            hintText: "Lets search someone"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where(
                            'name',
                            isGreaterThanOrEqualTo:
                                searchController.text.trim(),
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot dataSnapshot =
                                snapshot.data as QuerySnapshot;
                            if (dataSnapshot.docs.isNotEmpty) {
                              return ListView.builder(
                                itemCount: dataSnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> userMap =
                                      dataSnapshot.docs[index].data()
                                          as Map<String, dynamic>;
                                  UserModel searchedUser =
                                      UserModel.fromMap(userMap);

                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withAlpha(100),
                                        radius: 25,
                                        child: Image.network(
                                          searchedUser.profilepic!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              ((context, error, stackTrace) {
                                            return const Icon(
                                                Icons.account_circle_rounded);
                                          }),
                                        ),
                                      ),
                                    ),
                                    title: Text(searchedUser.name.toString()),
                                    subtitle:
                                        Text(searchedUser.email.toString()),
                                    trailing: const Icon(
                                        Icons.keyboard_arrow_right_rounded),
                                    onTap: () => Get.to(() =>
                                        ProfileScreen(uid: searchedUser.uid!)),
                                  );
                                },
                              );
                            } else {
                              return Text(
                                'No users found ! search some...',
                                style: TextStyle(
                                  fontSize: 17,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return const Text('an error occured !');
                          } else {
                            return const Text('No results found !');
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
