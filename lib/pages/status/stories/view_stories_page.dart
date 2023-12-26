import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewStoriesPage extends StatefulWidget {
  const ViewStoriesPage({super.key});

  @override
  State<ViewStoriesPage> createState() => _ViewStoriesPageState();
}

class _ViewStoriesPageState extends State<ViewStoriesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get _storiesStream {
    return _firestore
        .collection('status')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'View Stories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _storiesStream,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(
              child: Text('No Stories available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot story = snapshot.data!.docs[index];
              Map<String, dynamic> data
              = story.data() as Map<String, dynamic>;

              return ListTile(
                leading: data['mediaUrl'] != null
                    ? Image.network(data['mediaUrl'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover)
                    : const SizedBox(
                  width: 50,
                  height: 50, //place holder in case of no image
                ),
                title: Text(data['statusText'] ?? 'No status text'),
                subtitle: Text('Posted by ${data['userID'] ?? 'Unknown'}'),
              );
            },
          );
        },
      ),
    );
  }
}