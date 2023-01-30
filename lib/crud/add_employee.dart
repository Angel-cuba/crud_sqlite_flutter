import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Employee Id',
                hintText: 'Enter employee id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Employee Name',
                hintText: 'Enter employee name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Employee Email',
                hintText: 'Enter employee email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _designationController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Employee Designation',
                hintText: 'Enter employee designation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.male,
                          size: isFemale ? 25 : 30.0,
                          color: isFemale ? Colors.grey : Colors.blue,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: isFemale
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: isFemale ? Colors.grey : Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Switch(
                        value: isFemale,
                        onChanged: (newValue) {
                          setState(() {
                            isFemale = newValue;
                          });
                        }),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.female,
                            size: !isFemale ? 25.0 : 30.0,
                            color: isFemale ? Colors.pink : Colors.grey),
                        Text(
                          'Female',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: isFemale
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isFemale ? Colors.pink : Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // if (_idController.text.isNotEmpty &&
                //     _nameController.text.isNotEmpty &&
                //     _emailController.text.isNotEmpty &&
                //     _designationController.text.isNotEmpty) {
                //   Employee employee = Employee(
                //       id: int.parse(_idController.text),
                //       name: _nameController.text,
                //       email: _emailController.text,
                //       designation: _designationController.text);
                //   EmployeeDatabase.instance.create(employee);
                //   Navigator.pop(context);
                // }
              },
              child: const Text('Add Employee'),
            )
          ],
        ),
      )),
    );
  }
}
