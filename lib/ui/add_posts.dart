import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("add post"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 4,
                decoration:
               const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Add',
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                      'title': postController.text.toString(),
                      'id': DateTime
                    }).then((value) {
                      Utils().toastMessage('Post added');
                      setState(() {
                      loading = true;
                    });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                      loading = false;
                    });
                    });
                  })
            ],
          ),
        ));
  }
}
