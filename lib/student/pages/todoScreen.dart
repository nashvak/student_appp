import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_mngt_image/student/logics/provider.dart';
import 'package:student_mngt_image/student/pages/add_details.dart';
import 'package:student_mngt_image/student/pages/update.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('S T U D E N T S'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoProvider.todos.length,
        itemBuilder: (context, index) {
          final todo = todoProvider.todos[index];
          //print(index);
          final int myindex = index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: InkWell(
              //onTap: _showMyDialog(todo.title,todo.rollnumber),
              child: Card(
                color: Color.fromARGB(255, 227, 237, 228),
                child: ListTile(
                    title: Text(
                      todo.title,
                    ),
                    subtitle: Text(todo.rollnumber),
                    leading: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            FileImage(File(todo.imageUrl.toString()))),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Update(
                                    name: todo.title,
                                    index: myindex,
                                    age: todo.rollnumber,
                                    url: todo.imageUrl,
                                  ))),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
