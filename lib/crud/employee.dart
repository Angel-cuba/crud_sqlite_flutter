Employee toEmployee(Map<String, Object?> map) => Employee.fromMap(map);

class Employee {
  final int id;
  final String name;
  final String email;
  final String designation;
  final bool isMale;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.designation,
    required this.isMale,
  });

  // Convert a Employee object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'designation': designation,
      'isMale': isMale,
    };
  }

  // Convert a Map object into a Employee object
  factory Employee.fromMap(Map<String, dynamic> map) => Employee(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        designation: map['designation'],
        isMale: map['isMale'],
      );
}
