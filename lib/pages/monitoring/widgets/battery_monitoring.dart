import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_dashboard/pages/monitoring/widgets/chart_model.dart';
import 'package:core_dashboard/pages/monitoring/widgets/mqtt_handler.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class BatteryMonitoring extends StatelessWidget {
  const BatteryMonitoring({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius:
            BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              SectionTitle(
                title: "Battery Monitoring",
                color: AppColors.secondaryLavender,
              ),
            ],
          ),
          gapH24,
          BatteryChart(),
        ],
      ),
    );
  }
}

class BatteryChart extends StatefulWidget {
  const BatteryChart({super.key});

  final Color barBackgroundColor = AppColors.bgSecondayLight;
  final Color barColor = AppColors.secondaryMintGreen;

  @override
  State<StatefulWidget> createState() => _BatteryChartState();
}

class _BatteryChartState extends State<BatteryChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        // Templating the tooltip
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          return Container(
              child: Text('PointIndex : ${pointIndex.toString()}'));
        });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.all(16),
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('log_trial')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChartModel> PV1ChartData = [];
                      List<ChartModel> GS1ChartData = [];
                      List<ChartModel> GS2ChartData = [];
                      List<ChartModel> GS3ChartData = [];
                      List<ChartModel> GS4ChartData = [];

                      for (var e in snapshot.data!.docs) {
                        if (e['device'] == 'PV1') {
                          PV1ChartData.add(ChartModel(
                              label: (e['timeSign'] as Timestamp).toDate(),
                              data: e['cap']));
                        } else if (e['device'] == 'GS1') {
                          GS1ChartData.add(ChartModel(
                              label: (e['timeSign'] as Timestamp).toDate(),
                              data: e['cap']));
                        } else if (e['device'] == 'GS2') {
                          GS2ChartData.add(ChartModel(
                              label: (e['timeSign'] as Timestamp).toDate(),
                              data: e['cap']));
                        } else if (e['device'] == 'GS3') {
                          GS3ChartData.add(ChartModel(
                              label: (e['timeSign'] as Timestamp).toDate(),
                              data: e['cap']));
                        } else if (e['device'] == 'GS4') {
                          GS4ChartData.add(ChartModel(
                              label: (e['timeSign'] as Timestamp).toDate(),
                              data: e['cap']));
                        }
                      }

                      if (PV1ChartData.isNotEmpty) {
                        PV1ChartData.sort((a, b) => a.label.compareTo(b.label));
                      }
                      if (GS1ChartData.isNotEmpty) {
                        GS1ChartData.sort((a, b) => a.label.compareTo(b.label));
                      }
                      if (GS2ChartData.isNotEmpty) {
                        GS2ChartData.sort((a, b) => a.label.compareTo(b.label));
                      }
                      if (GS3ChartData.isNotEmpty) {
                        GS3ChartData.sort((a, b) => a.label.compareTo(b.label));
                      }
                      if (GS4ChartData.isNotEmpty) {
                        GS4ChartData.sort((a, b) => a.label.compareTo(b.label));
                      }

                      return SfCartesianChart(
                          borderWidth: 2,
                          zoomPanBehavior: _zoomPanBehavior,
                          primaryXAxis: DateTimeAxis(
                            rangePadding: ChartRangePadding.none,
                            initialVisibleMinimum:
                                DateTime(2024, 7, 13, 22, 0, 0),
                            initialVisibleMaximum:
                                DateTime(2024, 7, 13, 23, 0, 0),
                            interval: 10,
                            minorTicksPerInterval: 0,
                            labelRotation: -45,
                            // autoScrollingDelta: 7,
                            autoScrollingMode: AutoScrollingMode.end,
                          ),

                          // Chart title
                          title: const ChartTitle(
                              text: 'Output Load Monitoring (kW)'),
                          // Enable legend
                          legend: const Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries<ChartModel, DateTime>>[
                            LineSeries<ChartModel, DateTime>(
                              dataSource: PV1ChartData,
                              xValueMapper: (ChartModel obj, _) => obj.label,
                              yValueMapper: (ChartModel obj, _) => obj.data,
                              name: 'PV 1',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  // Marker shape is set to circle
                                  shape: DataMarkerType.circle),
                            ),
                            LineSeries<ChartModel, DateTime>(
                              dataSource: GS1ChartData,
                              xValueMapper: (ChartModel obj, _) => obj.label,
                              yValueMapper: (ChartModel obj, _) => obj.data,
                              name: 'GS 1',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  // Marker shape is set to circle
                                  shape: DataMarkerType.circle),
                            ),
                            LineSeries<ChartModel, DateTime>(
                              dataSource: GS2ChartData,
                              xValueMapper: (ChartModel obj, _) => obj.label,
                              yValueMapper: (ChartModel obj, _) => obj.data,
                              name: 'GS 2',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  // Marker shape is set to circle
                                  shape: DataMarkerType.circle),
                            ),
                            LineSeries<ChartModel, DateTime>(
                              dataSource: GS3ChartData,
                              xValueMapper: (ChartModel obj, _) => obj.label,
                              yValueMapper: (ChartModel obj, _) => obj.data,
                              name: 'GS 3',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  // Marker shape is set to circle
                                  shape: DataMarkerType.circle),
                            ),
                            LineSeries<ChartModel, DateTime>(
                              dataSource: GS4ChartData,
                              xValueMapper: (ChartModel obj, _) => obj.label,
                              yValueMapper: (ChartModel obj, _) => obj.data,
                              name: 'GS 4',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              markerSettings: const MarkerSettings(
                                  isVisible: true,
                                  // Marker shape is set to circle
                                  shape: DataMarkerType.circle),
                            ),
                          ]);
                    } else {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
