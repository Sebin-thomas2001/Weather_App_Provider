// Example
void main() {
  Map<String, dynamic> json = {
    "id": '1',
    "name": "Sebin",
    "course": "BCA",
    "Address": "Kottayam",
    "status": 0
  }; // sample json data

  Student s1 = Student.fromJson(json);
  print(s1);

  final studentJson=s1.toJson();
  print(studentJson);
}

class Student {
  String? id;
  String? name;
  String? course;
  String? address;
  int? status;

  Student({this.id, this.name, this.course, this.address, this.status});

  // JSON => Dart Conversion

  // Constructor is used to create objects

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        name: json['name'],
        course: json['course'],
        address: json['address'],
        status: json['status']);
  }

  // Dart => Json Conversion

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();

    data['id'] = id;
    data['name'] = name;
    data['course'] = course;
    data['address'] = address;
    data['status'] = status;

    return data;
  }
}
