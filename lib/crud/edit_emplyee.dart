import 'package:flutter/material.dart';
import '../database/db.dart';
import '../views/home.dart';
import 'employee.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({super.key, required this.employee, required this.db});
  final DbConnection db;
  final Employee employee;

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  bool isFemale = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _idController.text = widget.employee.id.toString();
    _nameController.text = widget.employee.name;
    _emailController.text = widget.employee.email;
    _designationController.text = widget.employee.designation;
    isFemale = !widget.employee.isMale;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Employee'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              enabled: false,
              controller: _idController,
              keyboardType: TextInputType.number,
              focusNode: _focusNode,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !isFemale
                        ? Row(
                            children: const [
                              Icon(
                                Icons.male,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          )
                        : Row(
                            children: const [
                              Icon(Icons.female,
                                  size: 30.0, color: Colors.pinkAccent),
                              Text(
                                'Female',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.pink),
                              )
                            ],
                          )
                  ],
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () async {
                  if (_idController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _designationController.text.isNotEmpty &&
                      isFemale) {
                    Employee employee = Employee(
                        id: int.parse(_idController.text),
                        name: _nameController.text,
                        email: _emailController.text,
                        designation: _designationController.text,
                        isMale: !isFemale);
                    await widget.db.updateEmployee(employee);

                    if (mounted) {
                      setState(() {
                        _idController.clear();
                        _nameController.clear();
                        _emailController.clear();
                        _designationController.clear();
                        isFemale = !isFemale;
                        _focusNode.requestFocus();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.lightGreenAccent,
                          content: Text('Employee added successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
                child: const Text('Update Employee'),
              ),
              ElevatedButton(
                onPressed: () {
                  _nameController.text = '';
                  _emailController.text = '';
                  _designationController.text = '';
                  isFemale = false;
                  setState(() {
                    _focusNode.requestFocus();
                  });
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                child: const Text('Reset'),
              )
            ])
          ],
        ),
      )),
    );
  }
}
