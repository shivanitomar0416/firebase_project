import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_project/utils/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  bool loading = false ;
  File? _image ;
  
 

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance ;
  DatabaseReference databaseRef= FirebaseDatabase.instance.ref('Post') ;


  Future getImageGallery()async{
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else {
        print('no image picked');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      )
                  ),
                  child: _image != null ? Image.file(_image!.absolute) :
                  Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 39,),
            RoundButton(title: 'Upload', loading: loading, onTap: ()async{

              setState(() {
                loading = true ;
              });
              firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref('/asiftaj/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

              Future.value(uploadTask).then((value)async{

                var newUrl = await ref.getDownloadURL();

                databaseRef.child('1').set({
                  'id' : '1212' ,
                  'title' : newUrl.toString()
                }).then((value){
                  setState(() {
                    loading = false ;
                  });
                  Utils().toastMessage('uploaded');

                }).onError((error, stackTrace){
                  print(error.toString());
                  setState(() {
                    loading = false ;
                  });
                });
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading = false ;
                });
              });



            })
          ],
        ),
      ),
    );
  }
}