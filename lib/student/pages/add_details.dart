import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../themes/buttons.dart';
import '../../themes/textform.dart';
import '../logics/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameController = TextEditingController();
  final rollNoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  XFile? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                height30,
                InkWell(
                  onTap: getImage,
                  child: Container(
                    child: (_image == null)
                        ? const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('images/user.png'))
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(_image!.path)),
                          ),
                  ),
                ),
                height30,
                textform(
                  'Name',
                  nameController,
                  null,
                  TextInputType.text,
                  false,
                  (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                ),
                height30,
                textform(
                  'Enter Roll number',
                  rollNoController,
                  null,
                  TextInputType.number,
                  false,
                  (value) {
                    if (value!.isEmpty) {
                      return "Enter Rollnumber";
                    }
                    return null;
                  },
                ),
                height30,
                Button(
                    title: 'Add',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final rno = rollNoController.text.trim();
                        //imageURL = file as String?;

                        final todoProvider = Provider.of<StudentProvider>(
                            context,
                            listen: false);
                        todoProvider.addTodo(
                          name,
                          rno,
                          _image!.path,
                        );

                        Navigator.of(context).pop();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//

Widget height30 = const SizedBox(
  height: 30,
);
