# How to show radio buttons and enable single selection of a row using them in Flutter DataGrid (SfDataGrid)?

In this article, you can learn how to show radio buttons and enable single selection of a row using them in [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

## STEP 1: 
Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. To utilize the DataGridController, you need to assign it to the [SfDataGrid.controller](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/controller.html) property.

```dart
class MyHomePageState extends State<MyHomePage> {
 
  DataGridController dataGridController = DataGridController();
 
…
 
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
}
```
## STEP 2: 
To achieve this, you can add a new column and DataGridCell specifically for the radio buttons. Within the [DataGridSource.buildRow](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/buildRow.html) method, you can return the [Radio](https://api.flutter.dev/flutter/material/Radio-class.html) widget for the corresponding column. Additionally, you can implement row selection when tapping on the radio button by utilizing programmatic selection.

```dart
class EmployeeDataSource extends DataGridSource {
 
  DataGridController dataGridController;
 
  bool _selectedValue = true;
 
…
 
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
```
Download the example from [GitHub](https://github.com/SyncfusionExamples/How-to-show-radio-button-and-select-a-row-through-it-in-Flutter-DataGrid)