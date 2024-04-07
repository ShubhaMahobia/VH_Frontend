import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    ErrorSnackBar(
      textMsg: 'No Image Selected',
    ).show(Get.context as BuildContext);
  }
}

class Util {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> uploadImage(String fileName, Uint8List file) async {
    try {
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ErrorSnackBar(
        textMsg: 'Error Uploading Image',
      ).show(Get.context as BuildContext);
      return '';
    }
  }

  Future<String> saveData({required Uint8List file}) async {
    DateTime now = DateTime.now();
    var datestamp = DateFormat("yyyy/MM/dd-'T'-HH/mm/ss");
    String currentdate = datestamp.format(now);
    try {
      String imageUrl = await uploadImage('$currentdate.file', file);
      await _fireStore.collection('userProfile').add({
        'ImageLink': imageUrl,
      });
      return imageUrl;
    } catch (e) {
      ErrorSnackBar(
        textMsg: 'Error Uploading Image Data',
      ).show(Get.context as BuildContext);
    }
    return 'Error Uploading Image Data';
  }
}
