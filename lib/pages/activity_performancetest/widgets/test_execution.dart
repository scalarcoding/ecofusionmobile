import 'dart:ui';
import 'package:core_dashboard/controllers/performance_test_controller.dart';
import 'package:core_dashboard/models/performance_test_model.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/utils/input_formatter.dart';
import 'package:core_dashboard/shared/widgets/components/custom_button.dart';
import 'package:core_dashboard/shared/widgets/components/custom_textfield.dart';
import 'package:core_dashboard/shared/widgets/components/fake_textfield.dart';
import 'package:core_dashboard/shared/widgets/dialogs/custom_snackbar.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:core_dashboard/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

final List<String> hours = List.generate(10, (index) {
  return "${(DateTime.now().add(const Duration(hours: 1)).hour + index).toString().padLeft(2, '0')}:00";
});

class TestExecution extends StatefulWidget {
  const TestExecution({super.key});

  @override
  State<TestExecution> createState() => _TestExecutionState();
}

class _TestExecutionState extends State<TestExecution> {
  final mainload_c = TextEditingController();
  final eqload_c = TextEditingController();
  final production_c = TextEditingController();
  final fuelusage_c = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    mainload_c.dispose();
    eqload_c.dispose();
    production_c.dispose();
    fuelusage_c.dispose();
    super.dispose();
  }

  void clearAllTextFields() {
    mainload_c.clear();
    eqload_c.clear();
    production_c.clear();
    fuelusage_c.clear();
    myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    PerformanceTestController testController =
        Provider.of<PerformanceTestController>(context);
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH8,
          SectionTitle(
            title: "Text Execution",
            color: Colors.lightBlue.shade100,
          ),
          gapH20,
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              }),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hours.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index >
                            testController.performanceTestModel.length) {
                          return;
                        }
                        testController.setSelectedIndex(index);
                        if (testController.selectedIndex <
                            testController.performanceTestModel.length) {
                          setState(() {
                            mainload_c.text = testController
                                .performanceTestModel[index].mainload
                                .toStringAsFixed(2);
                            eqload_c.text = testController
                                .performanceTestModel[index].eqload
                                .toStringAsFixed(2);
                            production_c.text = testController
                                .performanceTestModel[index].production
                                .toStringAsFixed(2);
                            fuelusage_c.text = testController
                                .performanceTestModel[index].fuelUsage
                                .toStringAsFixed(2);
                            testController.editingMode();
                          });
                        } else {
                          clearAllTextFields();
                          testController.addingMode();
                        }
                      },
                      child: Padding(
                        padding: index == testController.selectedIndex
                            ? const EdgeInsets.all(8.0)
                            : const EdgeInsets.all(12.0),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: index <
                                      testController.performanceTestModel.length
                                  ? Colors.blue.shade200
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Center(
                              child: Text(
                            hours[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: index == testController.selectedIndex
                                        ? Colors.blue.shade700
                                        : MainColor.getColor(1)),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      color: MainColor.brandColor,
                      onPressed: testController.selectedIndex < 1
                          ? null
                          : () {
                              testController.prevSelectedIndex();
                            },
                      icon: const Icon(Icons.arrow_back_ios_rounded)),
                  IconButton(
                      color: MainColor.brandColor,
                      onPressed: testController.selectedIndex > 8
                          ? null
                          : () {
                              testController.nextSelectedIndex();
                            },
                      icon: const Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
            ),
          ),
          gapH20,
          const Text('Isi parameter performance test'),
          !Responsive.isMobile(context)
              ? SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              autoFocus: true,
                              focusNode: myFocusNode,
                              txtController: mainload_c,
                              inputFormatters: [
                                InputFormatter.numberOnly,
                              ],
                              hint: "Main Load (kW)",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              txtController: eqload_c,
                              inputFormatters: [
                                InputFormatter.numberOnly,
                              ],
                              hint: "Eq. Load (kW)",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              txtController: production_c,
                              inputFormatters: [
                                InputFormatter.numberOnly,
                              ],
                              hint: "Production (kWh)",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              txtController: fuelusage_c,
                              inputFormatters: [
                                InputFormatter.numberOnly,
                              ],
                              hint: "Fuel Usage (liter)",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                              color: MainColor.brandColor,
                              onPressed: testController
                                          .performanceTestModel.length >
                                      9
                                  ? null
                                  : () {
                                      //validation
                                      if (production_c.text.isEmpty ||
                                          eqload_c.text.isEmpty ||
                                          production_c.text.isEmpty ||
                                          fuelusage_c.text.isEmpty) {
                                        cSnackbar(context,
                                            "Mohon lengkapi data dahulu", 1);
                                        return;
                                      }
                                      if (testController.editMode == false) {
                                        testController.addPerformanceTest(
                                            PerformanceTestModel(
                                                mainload: double.parse(
                                                    mainload_c.text),
                                                eqload:
                                                    double.parse(eqload_c.text),
                                                production: double.parse(
                                                    production_c.text),
                                                fuelUsage: double.parse(
                                                    fuelusage_c.text)));
                                        cSnackbar(context, "Added to List", 1);
                                      } else {
                                        testController.updatePerformanceTest(
                                            PerformanceTestModel(
                                                mainload: double.parse(
                                                    mainload_c.text),
                                                eqload:
                                                    double.parse(eqload_c.text),
                                                production: double.parse(
                                                    production_c.text),
                                                fuelUsage: double.parse(
                                                    fuelusage_c.text)));
                                        cSnackbar(context, "Success Edit", 1);
                                      }

                                      clearAllTextFields();
                                      testController.nextSelectedIndex();
                                    },
                              icon: testController.editMode == true
                                  ? const Icon(
                                      Icons.edit,
                                      size: 36,
                                    )
                                  : const Icon(
                                      Icons.add_box_sharp,
                                      size: 36,
                                    )),
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 256,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FakeTextField(
                        caption: "Main Load (kW)",
                        height: 30,
                        fillColor: Colors.grey.shade100,
                        radius: 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FakeTextField(
                        caption: "Equipment Load (kW)",
                        height: 30,
                        fillColor: Colors.grey.shade100,
                        radius: 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FakeTextField(
                        caption: "Production (kWh)",
                        height: 30,
                        fillColor: Colors.grey.shade100,
                        radius: 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FakeTextField(
                        caption: "Fuel Usage (liter)",
                        height: 30,
                        fillColor: Colors.grey.shade100,
                        radius: 8,
                      ),
                    ),
                  ]),
                ),
          gapH8,
          if (testController.performanceTestModel.length > 0)
            CButton(
                buttonColor: MainColor.brandColor,
                caption: "Submit Report",
                onPressed: () async {
                  var resp = await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: "Yakin untuk submit laporan test?",
                    onConfirmBtnTap: () {
                      Navigator.pop(context, true);
                    },
                  );
                  if (resp != null) {
                    cSnackbar(context, "Report Submitted Successfully", 2);
                    clearAllTextFields();
                    testController.resetForm();
                  }
                })
        ],
      ),
    );
  }
}
