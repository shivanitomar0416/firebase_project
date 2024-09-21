import 'package:firebase_project/ui/firestore/add_firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/firestore/firestore_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
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
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();

                if (snapshot.hasError) return Text('Some error');
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            //   onTap: () {
                            //     ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                            //       'title': 'its me shivani'
                            //     }).then((value) {
                            //       Utils().toastMessage('updated');
                            //     }).onError((error, stackTrace) {
                            //       Utils().toastMessage(error.toString());
                            //     });
                            //     ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                            //   },
                            onTap: () {
                              showMyDialog(
                                  snapshot.data!.docs[index]['title']
                                      .toString(),
                                  snapshot.data!.docs[index]['id'].toString());
                            },
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle: Text(
                                snapshot.data!.docs[index]['id'].toString()),
                          );
                        }
                        )
                        );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFirestoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

 void showMyDialog(String title, String postId) {
  editController.text = title; // Populate the editController with the current title
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Post'),
        content: TextFormField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Edit post',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              updateDocument(postId, editController.text);
              editController.clear(); // Clear the editController
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}
void updateDocument(String documentId, String title) {
  ref.doc(documentId).get().then((documentSnapshot) {
    if (documentSnapshot.exists) {
      ref.doc(documentId).update({'title': title}).then((value) {
        Utils().toastMessage('Updated successfully');
        setState(() {}); // Refresh the UI
      }).onError((error, stackTrace) {
        Utils().toastMessage('Error updating document: $error');
      });
    } else {
      Utils().toastMessage('Document not found');
    }
  }).onError((error, stackTrace) {
    Utils().toastMessage('Error getting document: $error');
  });
}

  void deleteDocument(String documentId) {
    ref.doc(documentId).delete().then((value) {
      Utils().toastMessage('Deleted successfully');
    }).onError((error, stackTrace) {
      Utils().toastMessage('Error deleting document: $error');
    });
  }
}


