// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';

// class NewMessage extends StatefulWidget {
//   const NewMessage({Key? key});

//   @override
//   State<NewMessage> createState() {
//     return _NewMessageState();
//   }
// }

// class _NewMessageState extends State<NewMessage> {
//   final _messageController = TextEditingController();
//   File? _image;

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   void _submitMessage() async {
//     final enteredMessage = _messageController.text;

//     if (enteredMessage.trim().isEmpty && _image == null) {
//       return;
//     }

//     FocusScope.of(context).unfocus();
//     _messageController.clear();

//     final user = FirebaseAuth.instance.currentUser!;
//     final userData = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();

//     final imageUrl = await _uploadImage();

//     FirebaseFirestore.instance.collection('chat').add({
//       'text': enteredMessage,
//       'createdAt': Timestamp.now(),
//       'userId': user.uid,
//       'username': userData.data()!['username'],
//       'userImage': userData.data()!['image_url'],
//       'imageUrl': imageUrl,
//     });
//   }

//   Future<String?> _uploadImage() async {
//     if (_image == null) {
//       return null;
//     }

//     final user = FirebaseAuth.instance.currentUser!;
//     final storageRef = FirebaseStorage.instance.ref().child('chat_images').child('${user.uid}_${DateTime.now().toIso8601String()}.jpg');
//     final uploadTask = storageRef.putFile(_image!);
//     final snapshot = await uploadTask.whenComplete(() {});

//     if (snapshot.state == TaskState.success) {
//       final imageUrl = await snapshot.ref.getDownloadURL();
//       return imageUrl;
//     } else {
//       return null;
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               textCapitalization: TextCapitalization.sentences,
//               autocorrect: true,
//               enableSuggestions: true,
//               decoration: const InputDecoration(labelText: 'Send a message...'),
//             ),
//           ),
//           IconButton(
//             color: Theme.of(context).colorScheme.primary,
//             icon: const Icon(
//               Icons.send,
//             ),
//             onPressed: _submitMessage,
//           ),
//           IconButton(
//             color: Theme.of(context).colorScheme.primary,
//             icon: const Icon(
//               Icons.image,
//             ),
//             onPressed: _pickImage,
//           ),
//         ],
//       ),
//     );
//   }
// }
