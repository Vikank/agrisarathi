import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Privacy_policy".tr,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NATURE OF THIS POLICY",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Bitter"),
            ),
            Text(
              "This privacy policy (“Policy”) is a legally binding document between “AGRISARATHI” and all Users of its websites, mobile sites, and mobile applications (“Websites”). for clarity, the Use of the terms “You”, “Your”, “Yours”, and “Yourself” in this Policy shall be understood to refer to all Users of the Website, and conversely, the terms “We”, “Us, and “Our” shall be understood to refer to the appropriate entity falling within the term Agrisarathi./nThrough this Policy, we want to draw your attention to three broad aspects: /n- The kind of data or information that Agrisarathi will collect from you; /n- The purpose of such collection; /n- Agrisarathi’s policy on sharing collected data with third parties.This Policy shall be effective upon your direct or indirect acceptance of the same (e., by clicking on the “submit” tab on the Website, or by Use of the Website, or by any other means). /nBy continuing to Use the Website, you hereby acknowledge that You have read and understood this Policy, and that you have provided your consent to Agrisarathi to collect, store, process, disclose, and transfer Your data in accordance with the terms listed below. /nYou further acknowledge that Your sharing of information, as may be required, is not in violation of any third party's rights, and the collection or transfer of such information will not cause wrongful gain or loss to Us, or any other person.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Bitter"),
            ),
          ],
        ),
      ),
    );
  }
}
