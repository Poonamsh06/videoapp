import 'package:biscuit1/views/search/utils/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
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
                        Get.to(() => Search_box());
                      }),
                      child: Row(children: [
                        Container(
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                        Expanded(
                          child: Container(
                            child: const Text("Lets search someone"),
                          ),
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
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MasonryGridView.count(

                    // gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, ),
                    // staggeredTileBuilder: (index) => index % 7 == 0?StaggeredTile.count(2,2):StaggeredTile.count(1,1),
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: 50,
                    itemBuilder: (context, index) => buildVideoCard(index)),
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
