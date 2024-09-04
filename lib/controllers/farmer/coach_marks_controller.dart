import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CoachMarksController extends GetxController{
  final List<TargetFocus> targets = <TargetFocus>[];
  final communityCoachKey = GlobalKey();
  final mandiCoachKey = GlobalKey();
  final farmCoachKey = GlobalKey();
  final weatherCoachKey = GlobalKey();
  final productionCoachKey = GlobalKey();
  final fertilizerCoachKey = GlobalKey();
  final detectCoachKey = GlobalKey();
  final soilCoachKey = GlobalKey();
  final helplineCoachKey = GlobalKey();
  final scrollController = ScrollController();
  RxBool tutorialShown = false.obs;

  void onInit(){
    super.onInit();
    createTargets();
  }

  void createTargets() {
    targets.addAll([
      TargetFocus(
        identify: "farmCoachKey",
        keyTarget: farmCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "You_can_select_and_add_more_Farms_here".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "weatherCoachKey",
        keyTarget: weatherCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "Here_you_can_check_weather_and_get_update".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "productionCoachKey",
        keyTarget: productionCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "Add_your_details_and_get_info".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "fertilizerCoachKey",
        keyTarget: fertilizerCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "You_can_calculate_the_amount_of_fertilizer_to_be_added_in_your_field_according_to_its_stage".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "detectCoachKey",
        keyTarget: detectCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "You_can_detect_disease_by_clicking_its_pic".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "soilCoachKey",
        keyTarget: soilCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "From_here_you_can_book_for_soil_testing".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "helplineCoachKey",
        keyTarget: helplineCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "All_Helpline_numbers_available_from_govt_side".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "communityCoachKey",
        keyTarget: communityCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Text(
              "Community_forum_to_discuss_problems".tr,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "mandiCoachKey",
        keyTarget: mandiCoachKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              "You_can_get_information_of_shops_products_mandi_prices",
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "NotoSans"),
            ),
          ),
        ],
      ),
    ]);
  }

  void showTutorial(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool tutorialShownBefore = prefs.getBool('tutorialShown') ?? false;
    if(!tutorialShownBefore && !tutorialShown.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TutorialCoachMark(
          targets: targets,
          colorShadow: Colors.green,
          textSkip: "SKIP",
          paddingFocus: 10,
          opacityShadow: 0.8,
          onFinish: () {
          },
          onClickTarget: (target) {
            final renderBox = target.keyTarget?.currentContext!.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero).dy;
            if (offset > scrollController.position.maxScrollExtent || offset < (scrollController.position.minScrollExtent)) {
              scrollController.animateTo(
                offset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          onClickOverlay: (target) {
          },
          onSkip: () {
            print("Skip");
            return true;
          },
        ).show(context: context);
      });
    }
  }
}