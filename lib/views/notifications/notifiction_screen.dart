import 'package:biscuit1/utilities/constants.dart';
import 'package:biscuit1/views/notifications/utils/notificationTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: StreamBuilder(
          stream: fire
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection('notifications')
              .orderBy('createdOn', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Text('...', style: kNormalSizeBoldTextStyle));
              }
//
              final notiSnap = snapshot.data as QuerySnapshot;
              final count = notiSnap.docs.length;

              if (count == 0) {
                return const Center(
                    child: Text(
                  'no notificatons yet start exploring...',
                  style: kPNormalSizeBoldTextStyle,
                ));
              } else {
                return ListView.builder(
                  itemCount: notiSnap.docs.length,
                  itemBuilder: (context, index) {
                    final notiData =
                        notiSnap.docs[index].data() as Map<String, dynamic>;
                    return NotificationTile(notiDocData: notiData);
                  },
                );
              }
//
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
