import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:student_mngt_image/student/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  Box<Student> todoBox = Hive.box<Student>('students');

  List<Student> get todos => todoBox.values.toList();

  void addTodo(String name, String rno, url) {
    final todo = Student(
      title: name,
      rollnumber: rno,
      imageUrl: url,
    );
    todoBox.add(todo);
    notifyListeners();
  }

  void updateTodo(int index, String name, String rno, url) {
    final todo = Student(title: name, imageUrl: url, rollnumber: rno);
    todoBox.putAt(index, todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    todoBox.deleteAt(index);
    notifyListeners();
  }
}
