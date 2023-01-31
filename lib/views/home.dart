import 'package:crud_sqlite/crud/add_employee.dart';
import 'package:crud_sqlite/crud/edit_emplyee.dart';
import 'package:crud_sqlite/crud/employee.dart';
import 'package:crud_sqlite/database/db.dart';
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
  final DbConnection db = DbConnection();
  int count = 0;

  //! get data from db
  Future<void> getEmployeesData() async {
    setState(() {
      isLoading = true;
    });
    await db.initializeDatabase();
    List<Map<String, Object?>> employeesList = await db.getEmployees();
    for (int i = 0; i < employeesList.length; i++) {
      employees.add(Employee.toEmp(employeesList[i]));
    }
    count = await db.countEmployees();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getEmployeesData();
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
          : employees.isEmpty
              ? const Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            foregroundColor: employees[index].isMale
                                ? Colors.blueAccent.shade700
                                : Colors.redAccent.shade700,
                            backgroundColor: employees[index].isMale
                                ? Colors.blueAccent.shade100
                                : Colors.redAccent.shade100,
                            child: Icon(employees[index].isMale
                                ? Icons.male
                                : Icons.female),
                          ),
                          title: Text(
                            '${employees[index].name} |  ${employees[index].designation}(Id: ${employees[index].id.toString()}))',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(employees[index].email),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.greenAccent.shade700,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditEmployee(
                                                employee: employees[index])));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.redAccent.shade700,
                                  onPressed: () {
                                    setState(() {
                                      employees.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEmployee(
                        db: db,
                      )));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
