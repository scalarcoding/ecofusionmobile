import 'package:core_dashboard/pages/activity_performancetest/widgets/available_configs.dart';
import 'package:core_dashboard/pages/activity_performancetest/widgets/test_header.dart';
import 'package:core_dashboard/pages/activity_performancetest/widgets/test_execution.dart';
import 'package:core_dashboard/pages/dashboard/widgets/get_more_customers.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';

class PerformanceTestPage extends StatelessWidget {
  const PerformanceTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Text(
          "Performance Test",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        gapH20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const TestHeader(),
                  gapH16,
                  const TestExecution(),
                  gapH16,
                  const GetMoreCustomers(),
                  if (Responsive.isMobile(context))
                    const Column(
                      children: [
                        gapH16,
                        AvailableConfigs(),
                      ],
                    ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context)) gapW16,
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AvailableConfigs(),
                    gapH16,
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
