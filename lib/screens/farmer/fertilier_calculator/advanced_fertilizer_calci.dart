import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/farmer/advance_fertilizer_calci.dart';
import '../../../utils/color_constants.dart';
import '../../../widgets/custom_elevated_button.dart';

class AdvancedFertilizerCalculatorScreen extends StatelessWidget {
  int? cropId;
  int? landId;
  final controller = Get.put(AdvancedFertilizerCalculatorController());

  AdvancedFertilizerCalculatorScreen({required this.cropId, this.landId});

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
              _buildInputSection(),
              SizedBox(height: 20),
              Obx(() => controller.apiResponse.value != null
                  ? _buildResultsSection()
                  : SizedBox.shrink()),
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
              color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
          child: Text(
            'Fertilizer_in_kg'.tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "GoogleSans"),
          ),
        ),
        SizedBox(height: 10),
        _buildInputField('DAP'.tr, controller.daep),
        _buildInputField('Complex_17'.tr, controller.complexes),
        _buildInputField('Urea'.tr, controller.urea),
        _buildInputField('SSP'.tr, controller.ssp),
        _buildInputField('MOP'.tr, controller.mop),
        SizedBox(height: 20),
        Obx(
          () => CustomElevatedButton(
            buttonColor: ColorConstants.primaryColor,
            onPress: controller.isLoading.value
                ? null
                : () => controller.calculateFertilizer(cropId, landId),
            widget: Text(
              "Calculate".tr,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: "GoogleSans"),
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
            labelStyle: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "GoogleSans")
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
          'DAP',
          results['DAP']?['N']?.toString() ?? '0',
          results['DAP']?['P']?.toString() ?? '0',
          results['DAP']?['K']?.toString() ?? '0',
          // results['DAP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Complex',
          results['Complex']?['N']?.toString() ?? '0',
          results['Complex']?['P']?.toString() ?? '0',
          results['Complex']?['K']?.toString() ?? '0',
          // results['Complex']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Urea',
          results['Urea']?['N']?.toString() ?? '0',
          results['Urea']?['P']?.toString() ?? '0',
          results['Urea']?['K']?.toString() ?? '0',
          // results['Urea']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'SSP',
          results['SSP']?['N']?.toString() ?? '0',
          results['SSP']?['P']?.toString() ?? '0',
          results['SSP']?['K']?.toString() ?? '0',
          // results['SSP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'MOP',
          results['MOP']?['N']?.toString() ?? '0',
          results['MOP']?['P']?.toString() ?? '0',
          results['MOP']?['K']?.toString() ?? '0',
          // results['MOP']?['Price']?.toString() ?? '0.00'
        ]),
        _buildTableRow([
          'Total',
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
