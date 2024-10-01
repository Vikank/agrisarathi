import 'package:flutter/material.dart';

class FormattedTreatmentText extends StatelessWidget {
  final String treatment;

  FormattedTreatmentText({required this.treatment});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    List<String> sections = treatment.split('**');

    for (int i = 1; i < sections.length; i++) {
      List<String> parts = sections[i].split('\r\n');

      if (parts.isNotEmpty) {
        // Highlighted section
        widgets.add(
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              parts[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: "GoogleSans"),
            ),
          ),
        );

        // Bullet points
        for (int j = 1; j < parts.length; j++) {
          if (parts[j].trim().isNotEmpty) {
            widgets.add(
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(parts[j].trim(), style: TextStyle(fontFamily: "GoogleSans", fontSize: 16, fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}