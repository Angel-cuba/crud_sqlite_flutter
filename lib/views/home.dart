import 'package:crud_sqlite/crud/add_employee.dart';
import 'package:crud_sqlite/crud/employee.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<Employee> employees = List.empty(growable: true);

  @override
  void initState() {
    employees.add(Employee(
        id: 1,
        name: 'John',
        email: 'jhon@gmail.com',
        designation: 'Manager',
        isMale: true));
    employees.add(Employee(
        id: 2,
        name: 'Jane',
        email: 'hane@gmail.com',
        designation: 'Employee',
        isMale: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
                strokeWidth: 2.0,
                backgroundColor: Colors.black12,
              ),
            )
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(employees[index].name),
                    subtitle: Text(employees[index].email),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddEmployee()));
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEmployee()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
