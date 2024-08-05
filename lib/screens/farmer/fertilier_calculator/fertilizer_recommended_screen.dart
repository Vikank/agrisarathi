import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/fertilizer_calci_controller.dart';
import 'advanced_fertilizer_calci.dart';

class FertilizerRecommendedrScreen extends StatelessWidget {
  final controller = Get.find<FertilizerCalciController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Fertilizer Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFertilizerTable(),
              SizedBox(height: 20),
              _buildAlreadyHaveStockSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFertilizerTable() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No. of Bags', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              final data = controller.fertilizerData.value;
              if (data == null) {
                return Center(child: Text('No data available'));
              }
              return Table(
                border: TableBorder.all(color: Colors.grey[300]!),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  _buildTableRow(['', 'Kg/ha', '50 kg bag', 'Price'], isHeader: true),
                  _buildTableRow([
                    'Urea',
                    data['Urea']['Kg/ha'].toString(),
                    data['Urea']['(50 kg bag)'].toString(),
                    '₹${data['Urea']['Price (Rs)']}',
                  ]),
                  _buildTableRow([
                    'Super Phosphate',
                    data['Super Phosphate']['Kg/ha'].toString(),
                    data['Super Phosphate']['(50 kg bag)'].toString(),
                    '₹${data['Super Phosphate']['Price (Rs)']}',
                  ]),
                  _buildTableRow([
                    'Potash',
                    data['Potash']['Kg/ha'].toString(),
                    data['Potash']['(50 kg bag)'].toString(),
                    '₹${data['Potash']['Price (Rs)']}',
                  ]),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) => TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      )).toList(),
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    Get.to(AdvancedFertilizerCalculatorScreen());
                  },
                    child: Text('CALCULATE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.science, color: Colors.green, size: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}