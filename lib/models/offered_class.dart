class OfferedClass {
  int classCode;
  String subject;

  OfferedClass({required this.classCode, required this.subject});

  factory OfferedClass.fromJson(Map<String, dynamic> json) {
    return OfferedClass(classCode: json['ClassCode'], subject: json['Subject']);
  }
}
