// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   List<String> tags = [
//     "travel",
//     "urban",
//     "fation",
//     "LifeStyle",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff090310),
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back_ios),
//         title: const Text("Profile"),
//         elevation: 0,
//         backgroundColor: const Color(0xff090310),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: const Icon(Icons.more_vert),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //name section
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 28, top: 7),
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: NetworkImage(
//                       "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 38.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Careen Page",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.white,
//                             size: 17,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 8),
//                             child: Text(
//                               "Delhi",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 wordSpacing: 2,
//                                 letterSpacing: 4,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           //followiing section
//           Padding(
//             padding: const EdgeInsets.only(
//                 right: 38.0, left: 38, top: 15, bottom: 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       '17k',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                     Text(
//                       'followers',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   color: Colors.white,
//                   width: 0.2,
//                   height: 22,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       '387',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                     Text(
//                       'followers',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   color: Colors.white,
//                   width: 0.2,
//                   height: 22,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                       left: 18, right: 18, top: 8, bottom: 8),
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(33)),
//                     gradient: LinearGradient(
//                       colors: [Color(0xff6d0eb5), Color(0xff4059f1)],
//                       begin: Alignment.bottomRight,
//                       end: Alignment.centerLeft,
//                     ),
//                   ),
//                   child: const Text(
//                     'Follow',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )

//           //tags Section
//           ,
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 44,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: tags.length,
//                   itemBuilder: ((context, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           border: Border.all(
//                               color: const Color.fromARGB(149, 255, 255, 255))),
//                       margin: const EdgeInsets.only(right: 13),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 13.0, bottom: 5, right: 20, left: 20),
//                         child: Text(
//                           tags[index],
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );
//                   })),
//             ),
//           )

//           //gallery section
//           ,
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.only(top: 15),
//               decoration: const BoxDecoration(
//                 color: Color(0xffEFEFEF),
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10, right: 25, left: 25),
//                     child: Text(
//                       'Protfllio', //////////////////////////////////////////////////
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 33,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 50),
//                       child: MasonryGridView.count(
//                         // gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, ),
//                         // staggeredTileBuilder: (index) => index % 7 == 0?StaggeredTile.count(2,2):StaggeredTile.count(1,1),
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         itemCount: 10,
//                         itemBuilder: (context, index) => buildVideoCard(index),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// buildVideoCard(int index) => Card(
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             'https://source.unsplash.com/random/?city,night$index',
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );

// keyboard_double_arrow_down_rounded 
//power_input_rounded 
//reorder
// →supervised_user_circle_sharp
// swap_vertical_circle_outlined
// view_week_rounded
// wifi_1_bar_rounded →
