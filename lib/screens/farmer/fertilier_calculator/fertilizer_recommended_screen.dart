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
        backgroundColor: Colors.white,
        title: Text(
          "Fertilizer_calculator".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            color: Colors.green[50],
            child: Text('No. of Bags',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter"),),),
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
            border: TableBorder.all(color: Colors.grey[300]!, borderRadius: BorderRadius.all(Radius.circular(4))),
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
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) => TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400, fontFamily: "NotoSans", fontSize: isHeader ? 14 : 12),
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter"),
            ),
            SizedBox(height: 8),
            Text('Do you have any stock already with you, then calculate how much you need now',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: "NotoSans"),),
            SizedBox(height: 16),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                  Get.to(AdvancedFertilizerCalculatorScreen());
                },
                  child: Text('CALCULATE', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: "NotoSans"),),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Spacer(),
                Image.asset("assets/images/fertilizer_calci_report.png",
                    width: 49,
                    height: 52),
              ],
            ),
          ],
        ),
      ),
    );
  }
}