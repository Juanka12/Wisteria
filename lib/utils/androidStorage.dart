import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wisteria/services/firestoreService.dart';

class AndroidStorage {
  final picker = ImagePicker();

  static final AndroidStorage _instance = AndroidStorage._internalConstructor();

  factory AndroidStorage() {
    return _instance;
  }

  AndroidStorage._internalConstructor();

  Future<bool> pickImage() async {
    bool boolean = false;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      PickedFile pickedFile = await this.picker.getImage(source: ImageSource.gallery);
      File file = File(pickedFile.path);
      
      if (pickedFile != null) {
        boolean = await FirestoreService().saveAvatar(file);
      }
    }
    return boolean;
  }

  Future<List<String>> getContactNumbers() async {
    List<String> numbers = [];
    await Permission.contacts.request();
    var permissionStatus = await Permission.contacts.status;

    if (permissionStatus.isGranted) {
      var contacts = await ContactsService.getContacts();
      print(contacts.elementAt(0).displayName);
      print(contacts.elementAt(0).phones);
      contacts.forEach((element) { 
        numbers.add(element.phones.first.value);
      });
    }
    return numbers;
  }
}