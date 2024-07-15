import 'package:core_dashboard/controllers/page_controller.dart';
import 'package:core_dashboard/pages/activity_performancetest/performance_test_page.dart';
import 'package:core_dashboard/pages/activity_testreport/test_report_page.dart';
import 'package:core_dashboard/pages/monitoring/monitoring_page.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/enums.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/sidebar.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/tab_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/widgets/header.dart';
import 'dashboard/dashboard_page.dart';

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    PageIdController pageController = Provider.of<PageIdController>(context);
    return Scaffold(
      key: _drawerKey,
      drawer: Responsive.isMobile(context) ? const Sidebar() : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const Sidebar(),
          if (Responsive.isTablet(context)) const TabSidebar(),
          Expanded(
            child: Column(
              children: [
                Header(drawerKey: _drawerKey),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1360),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding *
                                (Responsive.isMobile(context) ? 1 : 1.5),
                          ),
                          child:
                              SafeArea(child: getPages(pageController.pagesId)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

getPages(PagesId pagesId) {
  switch (pagesId) {
    case PagesId.Dashboard:
      return const DashboardPage();
    case PagesId.Monitoring:
      return const MonitoringPage();
    case PagesId.ActivityPerformanceTest:
      return const PerformanceTestPage();
    case PagesId.ActivityTestReport:
      return const TestReportPage();
    default:
      const DashboardPage();
      break;
  }
}
