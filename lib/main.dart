import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = [];
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = populateData();
    _employeeDataSource = EmployeeDataSource(_employees, dataGridController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion DataGrid Demo')),
      body: SfDataGrid(
        source: _employeeDataSource,
        selectionMode: SelectionMode.single,
        columns: getColumns,
        controller: dataGridController,
        columnWidthMode: ColumnWidthMode.fill,
      ),
    );
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'SelectionWidget',
          label: Container(
              alignment: Alignment.center,
              child: const Text('Select Employee'))),
      GridColumn(
          columnName: 'ID',
          label:
              Container(alignment: Alignment.center, child: const Text('ID'))),
      GridColumn(
          columnName: 'Name',
          label: Container(
              alignment: Alignment.center, child: const Text('Name'))),
      GridColumn(
          columnName: 'Designation',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'Designation',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'Salary',
          label: Container(
              alignment: Alignment.center, child: const Text('Salary'))),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees, this.dataGridController) {
    buildDataGridRows(employees);
  }

  List<DataGridRow> datagridRows = [];

  DataGridController dataGridController;

  @override
  List<DataGridRow> get rows => datagridRows;

  void buildDataGridRows(List<Employee> employeesData) {
    datagridRows = employeesData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              const DataGridCell<int>(
                  columnName: 'SelectionWidget', value: null),
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }

  bool _selectedValue = true;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return dataGridCell.columnName == 'SelectionWidget'
          ? Container(
              alignment: Alignment.center,
              child: Radio<bool>(
                value: getValue(row),
                groupValue: _selectedValue,
                onChanged: (bool? value) {
                  _selectedValue = !value!;
                  dataGridController.selectedRow = row;
                },
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(dataGridCell.value.toString()),
            );
    }).toList());
  }

  getValue(DataGridRow row) {
    bool isSelected = dataGridController.selectedRow == row;
    return isSelected;
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<Employee> populateData() {
  return [
    Employee(10001, 'Jack', 'Manager', 150000),
    Employee(10002, 'Perry', 'Lead', 80000),
    Employee(10003, 'James', 'Developer', 55000),
    Employee(10004, 'Michael', 'Designer', 39000),
    Employee(10005, 'Maria', 'Developer', 45000),
    Employee(10006, 'Edwards', 'UI Designer', 36000),
    Employee(10008, 'Adams', 'Developer', 43000),
    Employee(10009, 'Edwards', 'QA Testing', 43000),
    Employee(10010, 'Grimes', 'QA Testing', 43000),
  ];
}
