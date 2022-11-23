import 'package:VMedia/views/search/utils/search_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../models/videoModel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(24)),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  color: Colors.grey[400],
                  child: InkWell(
                    onTap: (() {
                      // yor method here
                      Get.to(() => const SearchBox());
                    }),
                    child: Row(children: [
                      Container(
                        child: const Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                      const Expanded(
                        child: Text("Lets search someone"),
                      ),
                      Container(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[600],
                        ),
                        margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('videos').snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;
                      if (dataSnapshot.docs.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: MasonryGridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount: dataSnapshot.docs.length,
                              itemBuilder: (context, index) {
                                VideoModel searchedUser =
                                    VideoModel.fromSnapshot(
                                        dataSnapshot.docs[index]);
                                return Card(
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        searchedUser.thumbnailUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text("No User available"),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text("No User available"),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("check your network speed"),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildVideoCard(int index) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://source.unsplash.com/random/?city,night$index',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
