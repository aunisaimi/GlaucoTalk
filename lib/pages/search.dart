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


  // Future<void> searchUsers() async{
  //   final String nameText = nameController.text;
  //   final String emailText = emailController.text;
  //   final String usernameText = usernameController.text;
  //   late QuerySnapshot userSnapshot;
  //
  //   if(usernameText != ""){
  //     userSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('username', isEqualTo: usernameText)
  //         .get();
  //   }
  //   else{
  //     userSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('name', isEqualTo: nameText)
  //         .where('email', isEqualTo: emailText)
  //         .get();
  //   }
  //
  //   if(userSnapshot.size > 0){
  //     setState(() {
  //       searchSnapshot = userSnapshot;
  //       hasUserSearched = true;
  //     });
  //   }
  // }

  Future<void> searchUsers() async {
    final String nameText = nameController.text;
    final String emailText = emailController.text;
    final String usernameText = usernameController.text;
    late QuerySnapshot userSnapshot;

    if (usernameText != "") {
      userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: usernameText)
          .get();
    } else {
      userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: nameText)
          .where('email', isEqualTo: emailText)
          .get();
    }

    if(userSnapshot.size > 0){
      setState(() {
        // for (QueryDocumentSnapshot document in searchSnapshot!.docs) {
          //   Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
          //   print('Name: ${userData['name']}');
          //   print('Email: ${userData['email']}');
          //   // Print other fields as needed
          // }
        searchSnapshot = userSnapshot;
        hasUserSearched = true;
        print(searchSnapshot!.size);
      });
    }
    else{
      print(searchSnapshot!.size);
      print("hello");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Page",
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: "Search by Username"
                ),
              ),
              ElevatedButton(
                  onPressed: searchUsers,
                  child: const Text("Search"),
              ),

              if(hasUserSearched)
                Column(
                  children: <Widget>[
                    const Text('Search Results:'),
                    const SizedBox(height: 16.0,),
                    // // Accessing the data from the first document in the snapshot
                    // Text('Name: ${searchSnapshot!.docs[0]['name']}'),
                    // Text('Email: ${searchSnapshot!.docs[0]['email']}'),

                    // Using ListView.builder to display information for each document
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchSnapshot!.docs.length,
                      itemBuilder: (context, index) {
                        // Accessing data from each document
                        Map<String, dynamic> userData = searchSnapshot!.docs[index].data() as Map<String, dynamic>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Username: ${userData['username']}'),
                            Text('Email: ${userData['email']}'),

                            // If you want to display additional fields, add more Text widgets here
                            // Example: Displaying 'name' field
                            Text('Name: ${userData['name']}'),

                            // Add more Text widgets as needed
                          ],
                        );
                      },
                    ),


                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: searchSnapshot!.size,
                      //   itemBuilder: (context, index) {
                      //     final userData = searchSnapshot!.docs[index].data()
                      //       as Map<String, dynamic>;
                      //
                      //     return ListTile(
                      //       leading: CircleAvatar(
                      //         backgroundImage: NetworkImage(
                      //             userData['profilePicUrl']
                      //         ),
                      //         backgroundColor: Colors.purple[900],
                      //       ),
                      //       title: Text(userData['name'] ?? ''),
                      //       subtitle: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text("Name: ${userData['name'] ?? ''}"),
                      //           Text("Email: ${userData['email'] ?? ''}"),
                      //         ],
                      //       ),
                      //       onTap: (){
                      //
                      //       },
                      //     );
                      //   },
                      // ),
                    ],
                ),
              if(!hasUserSearched)
                const Text('Please perform a search.'),
            ],
          ),
        ),
      ),
    );
  }
}

