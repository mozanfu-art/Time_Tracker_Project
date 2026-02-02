import 'package:flutter/material.dart';

class LocalStorageFilledScreen extends StatelessWidget {
  const LocalStorageFilledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const Icon(Icons.refresh, color: Colors.black54),
        title: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.filter_list, size: 18, color: Colors.black54),
              SizedBox(width: 8),
              Text('Filter', style: TextStyle(color: Colors.black54, fontSize: 14)),
            ],
          ),
        ),
        actions: const [
          Icon(Icons.block, color: Colors.black54),
          SizedBox(width: 15),
          Icon(Icons.close, color: Colors.black54),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Origin Info Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: const Text('Origin  http://localhost:63759',
                style: TextStyle(color: Colors.black87, fontSize: 13)),
          ),
          // Data Table
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 35,
                    dataRowMinHeight: 30,
                    dataRowMaxHeight: 35,
                    border: TableBorder.all(color: const Color(0xFFE8F0FE)),
                    columns: const [
                      DataColumn(label: Text('Key', style: TextStyle(fontWeight: FontWeight.normal))),
                      DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.normal))),
                    ],
                    rows: [
                      _buildDataRow('projects', '[{"id":"1","name":"Project Alpha","isDefault"...'),
                      _buildDataRow('tasks', '[{"id":"1","name":"Task A"},{"id":"2","name":...'),
                      _buildDataRow('timeEntries', '[{"id":"1732356185289","projectId":"3","tas...'),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFBBDEFB)),
                  // Expanded Details View
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.arrow_drop_down, size: 20),
                            Text(' [{"id: "1", name: "Project Alpha", isDefault: false}, {id: "2", name: "',
                                style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                          ],
                        ),
                        _buildJsonDetail('0', '{id: "1", name: "Project Alpha", isDefault: false}'),
                        _buildJsonDetail('1', '{id: "2", name: "Project Beta", isDefault: false}'),
                        _buildJsonDetail('2', '{id: "3", name: "Project Gamma", isDefault: false}'),
                        _buildJsonDetail('3', '{id: "2024-11-23 15:32:34.708", name: "Project 123", isDefault: f'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String key, String value) {
    return DataRow(cells: [
      DataCell(Text(key, style: const TextStyle(fontSize: 12))),
      DataCell(Text(value, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
    ]);
  }

  Widget _buildJsonDetail(String index, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, size: 18, color: Color(0xFFC2185B)),
          Text('$index: ', style: const TextStyle(color: Color(0xFFC2185B), fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'monospace')),
          Expanded(child: Text(content, style: const TextStyle(fontSize: 12, fontFamily: 'monospace'), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
