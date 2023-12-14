import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String username = "";
  String email = '';
  bool isJoined = false;
  User? user;


  @override
  void initState(){
    super.initState();

  }


  Future<void> searchUsers() async{
    final String nameText = nameController.text;
    final String emailText = emailController.text;

    final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: nameText)
        .where('email', isEqualTo: emailText)
        .get();

    setState(() {
      searchSnapshot = userSnapshot;
      hasUserSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Page",
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: "Search by Username"),
            ),
            ElevatedButton(
                onPressed: searchUsers,
                child: const Text("Search"),
            ),

            if(hasUserSearched)
               Column(
                children: <Widget>[
                  const Text('Search Results:'),
                  ListView.builder(
                     shrinkWrap: true,
                     itemCount: searchSnapshot!.docs.length,
                     itemBuilder: (context, index) {
                       final userData = searchSnapshot!.docs[index].data() as Map<String, dynamic>;

                       return ListTile(
                         leading: CircleAvatar(
                           backgroundImage: NetworkImage(userData['profilePicUrl']),
                           backgroundColor: Colors.purple[900],
                         ),
                         title: Text(userData['name'] ?? ''),
                         subtitle: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Name: ${userData['name'] ?? ''}"),
                             Text("Email: ${userData['email'] ?? ''}"),
                           ],
                         ),
                         onTap: (){

                         },
                       );
                     },
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

