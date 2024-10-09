import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/advance_fertilizer_calci.dart';

class AdvanceResultScreen extends StatelessWidget {

  AdvancedFertilizerCalculatorController controller;

  AdvanceResultScreen({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Fertilizer_Calculator".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "GoogleSans"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => controller.apiResponse.value != null
                  ? _buildResultsSection()
                  : SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
          child: Text(
            'No_of_Bags'.tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "GoogleSans"),
          ),
        ),
        SizedBox(height: 10),
        _buildResultsTable(),
        SizedBox(
          height: 10,
        ),
        _buildRecommendedTable(),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
          child: Text(
            'Recommended'.tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "GoogleSans"),
          ),
        ),
        SizedBox(height: 10,),
        _buildSoilStructureTable()
      ],
    );
  }

  Widget _buildSoilStructureTable() {
    var npkStatus = controller.apiResponse.value!['New Data'][0] ?? {};

    if (npkStatus == null) {
      return Center(child: Text('No NPK data available'));
    }

    return Table(
      border: TableBorder.all(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow(['', 'N', 'P', 'K'], isHeader: true),
        _buildTableRow([
          'Value'.tr,
          npkStatus['NPK']['N'].toString(),
          npkStatus['NPK']['P'].toString(),
          npkStatus['NPK']['K'].toString(),
        ]),
      ],
    );
  }

  Widget _buildRecommendedTable() {
    if (controller.apiResponse.value!['results'] == null ||
        controller.apiResponse.value!['total'] == null ||
        controller.apiResponse.value!['results'][0] == null ||
        controller.apiResponse.value!['total'][0] == null) {
      return SizedBox.shrink(); // Return empty if results or total are null
    }

    final results = controller.apiResponse.value!['New Data'][0] ?? {};

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
          'Urea'.tr,
          results['Urea']['Kg/ha'].toString(),
          results['Urea']['(50 kg bag)'].toString(),
          '₹${results['Urea']['Price (Rs)']}',
        ]),
        _buildTableRow([
          'Super_Phosphate'.tr,
          results['Super Phosphate']['Kg/ha'].toString(),
          results['Super Phosphate']['(50 kg bag)'].toString(),
          '₹${results['Super Phosphate']['Price (Rs)']}',
        ]),
        _buildTableRow([
          'Potash'.tr,
          results['Potash']['Kg/ha'].toString(),
          results['Potash']['(50 kg bag)'].toString(),
          '₹${results['Potash']['Price (Rs)']}',
        ]),
      ],
    );
  }


  Widget _buildResultsTable() {
    // Ensure 'results' and 'total' are not null
    if (controller.apiResponse.value!['results'] == null ||
        controller.apiResponse.value!['total'] == null ||
        controller.apiResponse.value!['results'][0] == null ||
        controller.apiResponse.value!['total'][0] == null) {
      return SizedBox.shrink(); // Return empty if results or total are null
    }

    final results = controller.apiResponse.value!['results'][0] ?? {};
    final total = controller.apiResponse.value!['total'][0]['Total'] ?? {};

    return Table(
      border: TableBorder.all(
          color: Colors.grey[300]!,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow([
          ' ',
          'N',
          'P',
          'K',
          // 'Price'
        ], isHeader: true),
        _buildTableRow([
          'DAEP'.tr,
          results['DAEP']?['N']?.toString() ?? '0',
          results['DAEP']?['P']?.toString() ?? '0',
          results['DAEP']?['K']?.toString() ?? '0',
          // results['DAP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Complex_17'.tr,
          results['Complex 17:17']?['N']?.toString() ?? '0',
          results['Complex 17:17']?['P']?.toString() ?? '0',
          results['Complex 17:17']?['K']?.toString() ?? '0',
          // results['Complex']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Urea'.tr,
          results['Urea']?['N']?.toString() ?? '0',
          results['Urea']?['P']?.toString() ?? '0',
          results['Urea']?['K']?.toString() ?? '0',
          // results['Urea']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'SSP'.tr,
          results['SSP']?['N']?.toString() ?? '0',
          results['SSP']?['P']?.toString() ?? '0',
          results['SSP']?['K']?.toString() ?? '0',
          // results['SSP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'MOP'.tr,
          results['MOP']?['N']?.toString() ?? '0',
          results['MOP']?['P']?.toString() ?? '0',
          results['MOP']?['K']?.toString() ?? '0',
          // results['MOP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Total'.tr,
          total['Total Nitrogen']?.toString() ?? '0',
          total['Total Phosphorous']?.toString() ?? '0',
          total['Total Potassium']?.toString() ?? '0',
          // total['Total Price']?.toString() ?? '0.00'
        ], isFooter: true),
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells,
      {bool isHeader = false, bool isFooter = false}) {
    return TableRow(
      children: cells
          .map((cell) => TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(
              fontWeight: isHeader
                  ? FontWeight.w500
                  : isFooter
                  ? FontWeight.w700
                  : FontWeight.w400,
              fontFamily: "GoogleSans",
              fontSize: isHeader ? 14 : 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ))
          .toList(),
    );
  }
}
