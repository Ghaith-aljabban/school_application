class Student {
  final String firstName;
  final String lastName;
  String studentNumber;
  final String parentName;
  String parentNumber;
  String classroom;

  Student({
    required this.firstName,
    required this.lastName,
    required this.studentNumber,
    required this.parentName,
    required this.parentNumber,
    required this.classroom,
  });
}
final Student ghaith = Student(classroom: "b2",firstName: 'ghaith',lastName: "aljabban",parentName: 'khalid',studentNumber: '09xxxxxxx',parentNumber:'09xxxxxxx' );