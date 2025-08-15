class User {
  final int id;
  final int studentId;
  final String name;
  final String email;
  final String phone;
  final String className;
  final String gradeLevel;

  User({
    required this.id,
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.className,
    required this.gradeLevel,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'] as int,
      studentId: map['student_id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      className: map['class_name'] as String,
      gradeLevel: map['grade_level'] as String,
    );
  }
}