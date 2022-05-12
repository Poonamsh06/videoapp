import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

Padding Custom_likeButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 0),
    child: LikeButton(
        size: 90,
        onTap: onLikeButtonTapped,
        circleColor:
            const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color.fromARGB(255, 229, 51, 51),
          dotSecondaryColor: Color.fromARGB(255, 204, 0, 0),
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : Colors.grey,
            size: 40,
          );
        }),
  );
}

Future<bool> onLikeButtonTapped(bool isLiked) async {
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;

  return !isLiked;
}

profileImageButton() {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(25),
          image: const DecorationImage(
            image: NetworkImage(
                "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg"),
          ),
        ),
      ),
      Positioned(
          bottom: -10,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(25)),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ))
    ],
  );
}

IconButton comment_button() {
  return IconButton(
    onPressed: () {},
    icon: Icon(
      Icons.comment,
      size: 35,
      color: Colors.grey,
    ),
  );
}

IconButton share_button() {
  return IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.share_rounded,
      size: 35,
      color: Colors.grey,
    ),
  );
}
