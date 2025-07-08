class dailySubject {
    String dateInMonth ;
    // 15
    String weekDay ;
    // sunday
    List<subjectTime> subject;
    //the 6 subject
    dailySubject({
    required this.subject,
    required this.weekDay,
    required this.dateInMonth,
});
}
class subjectTime{
  String timeEnd ;
  // 8:45AM
  String timeStart ;
  // 8:00AM
  String subjectName;
  // English
  subjectTime({
    required this.subjectName,
    required this.timeStart,
    required this.timeEnd,
  });
}


List<dailySubject> demoData = [
  dailySubject(
    dateInMonth: "15",
    weekDay: "Sunday",
    subject: [
      subjectTime(subjectName: "English", timeStart: "8:00AM", timeEnd: "8:45AM"),
      subjectTime(subjectName: "Mathematics", timeStart: "8:45AM", timeEnd: "9:30AM"),
      subjectTime(subjectName: "Science", timeStart: "9:30AM", timeEnd: "10:15AM"),
      subjectTime(subjectName: "Break", timeStart: "10:15AM", timeEnd: "10:30AM"),
      subjectTime(subjectName: "History", timeStart: "10:30AM", timeEnd: "11:15AM"),
      subjectTime(subjectName: "Art", timeStart: "11:15AM", timeEnd: "12:05PM"),
    ],
  ),
  dailySubject(
    dateInMonth: "16",
    weekDay: "Monday",
    subject: [
      subjectTime(subjectName: "Mathematics", timeStart: "8:00AM", timeEnd: "8:45AM"),
      subjectTime(subjectName: "Physics", timeStart: "8:45AM", timeEnd: "9:30AM"),
      subjectTime(subjectName: "Chemistry", timeStart: "9:30AM", timeEnd: "10:15AM"),
      subjectTime(subjectName: "Break", timeStart: "10:15AM", timeEnd: "10:30AM"),
      subjectTime(subjectName: "Geography", timeStart: "10:30AM", timeEnd: "11:15AM"),
      subjectTime(subjectName: "PE", timeStart: "11:15AM", timeEnd: "12:05PM"),
    ],
  ),
  dailySubject(
    dateInMonth: "17",
    weekDay: "Tuesday",
    subject: [
      subjectTime(subjectName: "Biology", timeStart: "8:00AM", timeEnd: "8:45AM"),
      subjectTime(subjectName: "English", timeStart: "8:45AM", timeEnd: "9:30AM"),
      subjectTime(subjectName: "Arabic", timeStart: "9:30AM", timeEnd: "10:15AM"),
      subjectTime(subjectName: "Break", timeStart: "10:15AM", timeEnd: "10:30AM"),
      subjectTime(subjectName: "Religion", timeStart: "10:30AM", timeEnd: "11:15AM"),
      subjectTime(subjectName: "Computer Science", timeStart: "11:15AM", timeEnd: "12:05PM"),
    ],
  ),
  dailySubject(
    dateInMonth: "18",
    weekDay: "Wednesday",
    subject: [
      subjectTime(subjectName: "Mathematics", timeStart: "8:00AM", timeEnd: "8:45AM"),
      subjectTime(subjectName: "English", timeStart: "8:45AM", timeEnd: "9:30AM"),
      subjectTime(subjectName: "Physics", timeStart: "9:30AM", timeEnd: "10:15AM"),
      subjectTime(subjectName: "Break", timeStart: "10:15AM", timeEnd: "10:30AM"),
      subjectTime(subjectName: "Chemistry", timeStart: "10:30AM", timeEnd: "11:15AM"),
      subjectTime(subjectName: "Music", timeStart: "11:15AM", timeEnd: "12:05PM"),
    ],
  ),
  dailySubject(
    dateInMonth: "19",
    weekDay: "Thursday",
    subject: [
      subjectTime(subjectName: "History", timeStart: "8:00AM", timeEnd: "8:45AM"),
      subjectTime(subjectName: "Geography", timeStart: "8:45AM", timeEnd: "9:30AM"),
      subjectTime(subjectName: "English", timeStart: "9:30AM", timeEnd: "10:15AM"),
      subjectTime(subjectName: "Break", timeStart: "10:15AM", timeEnd: "10:30AM"),
      subjectTime(subjectName: "Mathematics", timeStart: "10:30AM", timeEnd: "11:15AM"),
      subjectTime(subjectName: "Drama", timeStart: "11:15AM", timeEnd: "12:05PM"),
    ],
  ),
];



