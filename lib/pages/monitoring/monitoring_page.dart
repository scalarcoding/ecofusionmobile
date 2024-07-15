import 'package:core_dashboard/pages/dashboard/widgets/comments.dart';
import 'package:core_dashboard/pages/dashboard/widgets/get_more_customers.dart';
import 'package:core_dashboard/pages/dashboard/widgets/overview.dart';
import 'package:core_dashboard/pages/dashboard/widgets/popular_products.dart';
import 'package:core_dashboard/pages/dashboard/widgets/pro_tips.dart';
import 'package:core_dashboard/pages/dashboard/widgets/product_overview.dart';
import 'package:core_dashboard/pages/dashboard/widgets/refund_request.dart';
import 'package:core_dashboard/pages/monitoring/widgets/battery_monitoring.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/ghaps.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Text(
          "Monitoring",
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
                  const BatteryMonitoring(),
                  gapH16,
                  if (Responsive.isMobile(context))
                    const Column(
                      children: [
                        gapH16,
                        // PopularProducts(),
                        gapH16,
                        // Comments(),
                        gapH16,
                        // RefundRequest(newRefund: 8, totalRefund: 52),
                        gapH8,
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
                    PopularProducts(),
                    gapH16,
                    Comments(),
                    gapH16,
                    RefundRequest(newRefund: 8, totalRefund: 52),
                    gapH8,
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
