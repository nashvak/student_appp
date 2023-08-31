import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../themes/buttons.dart';
import '../../themes/textform.dart';
import '../logics/provider.dart';
import 'add_details.dart';

// ignore:must_be_immutable
class Update extends StatefulWidget {
  Update(
      {required this.age,
      required this.index,
      required this.name,
      required this.url,
      super.key});
  String name, url, age;
  int index;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.name);
    final rollNoController = TextEditingController(text: widget.age);
    final formKey = GlobalKey<FormState>();
    print(widget.index);

    //function

    Future getImage() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    int index = widget.index;
    final todoProvider = Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                todoProvider.removeTodo(index);
                Navigator.pop(context);
              }),
        ],
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
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(widget.url)))
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
                    title: 'Update',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        final name = nameController.text.trim();
                        final rno = rollNoController.text.trim();
                        //imageURL = file as String?;

                        final todoProvider = Provider.of<StudentProvider>(
                            context,
                            listen: false);
                        todoProvider.updateTodo(
                          index,
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
