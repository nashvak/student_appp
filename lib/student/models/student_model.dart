import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String imageUrl;

  @HiveField(2)
  String rollnumber;

  Student(
      {required this.title, required this.imageUrl, required this.rollnumber});
}
