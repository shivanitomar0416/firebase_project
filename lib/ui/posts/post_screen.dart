import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_project/ui/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/add_posts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => loginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout), // Updated icon
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
            query: ref, 
            defaultChild: Text('Loading'),
            itemBuilder: (context, snapshot, animation, index){
         return  ListTile(
            title: Text(snapshot.child('title').value.toString()),
            subtitle: Text(snapshot.child('id').value.toString()),
           
         );
             }
          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
