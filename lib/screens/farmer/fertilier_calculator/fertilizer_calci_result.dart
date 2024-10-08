import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/color_constants.dart';
import 'package:get/get.dart';
import '../../../models/fertilizer_calci_response.dart';
import 'advanced_fertilizer_calci.dart';

class FertilizerResultScreen extends StatelessWidget {
  final FertilizerResponse fertilizerData;
  int? cropId;
  int? landId;
  FertilizerResultScreen({Key? key, required this.fertilizerData, required this.cropId, this.landId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard('Soil_Structure'.tr, _buildSoilStructureTable()),
              SizedBox(height: 16),
              _buildSectionCard('No_of_Bags'.tr, _buildBagsTable()),
              SizedBox(height: 16),
              _buildAlreadyHaveStockSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          color: Colors.green[50],
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),
          ),
        ),
        SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildSoilStructureTable() {
    // Assuming `fertilizerData` is an instance of ApiResponse from your controller
    var npkStatus = fertilizerData.npkStatus.isNotEmpty ? fertilizerData.npkStatus[0] : null;

    if (npkStatus == null) {
      return Center(child: Text('No NPK data available'));
    }

    return Table(
      border: TableBorder.all(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      children: [
        TableRow(
          children: ['', 'N', 'P', 'K']
              .map((e) => _buildTableCell(e, isHeader: true))
              .toList(),
        ),
        TableRow(
          children: [
            'Value'.tr,
            npkStatus.nitrogenValue.toString(),
            npkStatus.phosphorousValue.toString(),
            npkStatus.potassiumValue.toString()
          ].map(_buildTableCell).toList(),
        ),
        TableRow(
          children: [
            'Status'.tr,
            npkStatus.n,
            npkStatus.p,
            npkStatus.k
          ].map(_buildTableCell).toList(),
        ),
      ],
    );
  }


  Widget _buildBagsTable() {
    // Assuming `fertilizerData` is an instance of ApiResponse from your controller
    var results = fertilizerData.results.isNotEmpty ? fertilizerData.results[0] : null;

    if (results == null) {
      return Center(child: Text('No fertilizer data available'));
    }

    // Extract data for each type of fertilizer
    final urea = results.urea;
    final superPhosphate = results.superPhosphate;
    final potash = results.potash;

    return Table(
      border: TableBorder.all(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      children: [
        TableRow(
          children: ['', 'Kg/ha', '50 kg bag', 'Price'].map((e) => _buildTableCell(e, isHeader: true)).toList(),
        ),
        TableRow(
          children: [
            'Urea'.tr,
            urea.kgPerHa.toString(),
            urea.bags50Kg.toString(),
            '₹${urea.priceRs}',
          ].map(_buildTableCell).toList(),
        ),
        TableRow(
          children: [
            'Super_Phosphate'.tr,
            superPhosphate.kgPerHa.toString(),
            superPhosphate.bags50Kg.toString(),
            '₹${superPhosphate.priceRs}',
          ].map(_buildTableCell).toList(),
        ),
        TableRow(
          children: [
            'Potash'.tr,
            potash.kgPerHa.toString(),
            potash.bags50Kg.toString(),
            '₹${potash.priceRs}',
          ].map(_buildTableCell).toList(),
        ),
      ],
    );
  }


  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400, fontFamily: "GoogleSans", fontSize: isHeader ? 14 : 12),
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
              'Already_have_some_stock'.tr,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "GoogleSans"),
            ),
            SizedBox(height: 8),
            Text('Do_you_have_any_stock_already_with_you_then_calculate_how_much_you_need_now'.tr,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: "GoogleSans"),),
            SizedBox(height: 16),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.to(()=>AdvancedFertilizerCalculatorScreen(cropId : cropId, landId: landId,));
                  },
                  child: Text('Calculate'.tr,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: "GoogleSans"),),
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