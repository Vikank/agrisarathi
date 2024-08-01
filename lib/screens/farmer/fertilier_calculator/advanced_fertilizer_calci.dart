import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/advance_fertilizer_calci.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_elevated_button.dart';

class AdvancedFertilizerCalculatorScreen extends StatelessWidget {
  final controller = Get.put(AdvancedFertilizerCalculatorController());

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(),
              SizedBox(height: 20),
              Obx(() => controller.apiResponse.value != null ? _buildResultsSection() : SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text('Fertilizer (in kg)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter"),),),
        SizedBox(height: 10),
        _buildInputField('DAEP', controller.daep),
        _buildInputField('Complexes', controller.complexes),
        _buildInputField('Urea', controller.urea),
        _buildInputField('SSP', controller.ssp),
        _buildInputField('MOP', controller.mop),
        SizedBox(height: 20),
        Obx(() => CustomElevatedButton(
          buttonColor: ColorConstants.primaryColor,
          onPress: controller.isLoading.value ? null : controller.calculateFertilizer,
          widget: Text(
            "CALCULATE",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: "NotoSans"),
          ),
        ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, RxString value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        onChanged: (newValue) => value.value = newValue,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: "0",
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Bitter")
          // border: OutlineInputBorder(),
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
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(5)
            ),
            child: Text('No. of Bags', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Bitter"),),),
        SizedBox(height: 10),
        _buildResultsTable(),
      ],
    );
  }

  Widget _buildResultsTable() {
    final results = controller.apiResponse.value!['results'][0];
    final total = controller.apiResponse.value!['total'][0]['Total'];

    return Table(
      border: TableBorder.all(color: Colors.grey[300]!, borderRadius: BorderRadius.all(Radius.circular(4))),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow(['', 'N', 'P', 'K'], isHeader: true),
        _buildTableRow([
          'NPK (kg/ha)',
          total['Total Nitrogen'].toString(),
          total['Total Phosphorous'].toString(),
          total['Total Potassium'].toString()
        ]),
        _buildTableRow([
          'Fertilizer (kg)',
          results['Urea']['N'].toString(),
          results['SSP']['P'].toString(),
          results['MOP']['K'].toString()
        ]),
        _buildTableRow([
          'Price Req. (Rs)',
          '0.00',
          '0.00',
          '0.00'
        ]), // You might need to adjust this based on the actual API response
      ],
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells
          .map((cell) => TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cell,
                    style: TextStyle(fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400, fontFamily: "NotoSans", fontSize: isHeader ? 14 : 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
