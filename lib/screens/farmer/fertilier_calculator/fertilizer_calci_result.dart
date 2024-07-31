import 'package:flutter/material.dart';

import '../../../models/fertilizer_calci_response.dart';

class FertilizerResultScreen extends StatelessWidget {
  final FertilizerResponse fertilizerData;

  const FertilizerResultScreen({Key? key, required this.fertilizerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Fertilizer Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard('Soil Structure', _buildSoilStructureTable()),
              SizedBox(height: 16),
              _buildSectionCard('No. of Bags', _buildBagsTable()),
              SizedBox(height: 16),
              _buildAlreadyHaveStockSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSoilStructureTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey[300]!),
      children: [
        TableRow(
          children: ['', 'N', 'P', 'K'].map((e) => _buildTableCell(e, isHeader: true)).toList(),
        ),
        TableRow(
          children: [
            'Value',
            fertilizerData.npkStatus['N'] ?? '',
            fertilizerData.npkStatus['P'] ?? '',
            fertilizerData.npkStatus['K'] ?? ''
          ].map(_buildTableCell).toList(),
        ),
        TableRow(
          children: [
            'Status',
            fertilizerData.npkStatus['N'] ?? '',
            fertilizerData.npkStatus['P'] ?? '',
            fertilizerData.npkStatus['K'] ?? ''
          ].map(_buildTableCell).toList(),
        ),
      ],
    );
  }

  Widget _buildBagsTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey[300]!),
      children: [
        TableRow(
          children: ['', 'Kg/ha', '50 kg bag', 'Price'].map((e) => _buildTableCell(e, isHeader: true)).toList(),
        ),
        ...fertilizerData.results.entries.map((entry) {
          final data = entry.value;
          return TableRow(
            children: [
              entry.key,
              data['Kg/ha'].toString(),
              data['(50 kg bag)'].toString(),
              '₹${data['Price (Rs)']}',
            ].map(_buildTableCell).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAlreadyHaveStockSection() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Already have some stock',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Do you have any stock already with you, then calculate how much you need now'),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement calculation logic here
                  },
                  child: Text('CALCULATE'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.science, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}