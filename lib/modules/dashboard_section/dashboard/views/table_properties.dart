import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Created by Abdullah on 10/11/24.



List<GridColumn> activeUserColumns(){
  return <GridColumn>[
    GridColumn(
        columnName: 'id',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            'ID',
            overflow: TextOverflow.ellipsis,
          ),
        )),
    GridColumn(
        columnName: 'name',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            'Name',
            overflow: TextOverflow.ellipsis,
          ),
        )),
    GridColumn(
        columnName: 'designation',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            'Designation',
            overflow: TextOverflow.ellipsis,
          ),
        )),
    GridColumn(
        columnName: 'salary',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            'Salary',
            overflow: TextOverflow.ellipsis,
          ),
        )),
  ];
}