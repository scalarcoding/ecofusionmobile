import 'package:core_dashboard/controllers/page_controller.dart';
import 'package:core_dashboard/pages/dashboard/widgets/theme_tabs.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/enums.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/customer_info.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/config.dart';
import 'menu_tile.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    PageIdController pageController = Provider.of<PageIdController>(context);
    return Drawer(
      // width: Responsive.isMobile(context) ? double.infinity : null,
      // width: MediaQuery.of(context).size.width < 1300 ? 260 : null,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('assets/icons/close_filled.svg'),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 1.5,
                  ),
                  child: Image.asset(
                    AppConfig.logo,
                    height: 30,
                  ),
                ),
              ],
            ),
            const Divider(),
            gapH16,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                ),
                child: ListView(
                  children: [
                    MenuTile(
                      isActive: pageController.pagesId == PagesId.Dashboard,
                      title: "Dashboard",
                      activeIconSrc: "assets/icons/home_filled.svg",
                      inactiveIconSrc: "assets/icons/home_light.svg",
                      onPressed: () {
                        pageController.changePageId(PagesId.Dashboard);
                      },
                    ),
                    MenuTile(
                      isActive: pageController.pagesId == PagesId.Monitoring,
                      title: "Monitoring",
                      activeIconSrc: "assets/icons/activity_filled.svg",
                      inactiveIconSrc: "assets/icons/activity_light.svg",
                      onPressed: () {
                        pageController.changePageId(PagesId.Monitoring);
                      },
                    ),
                    ExpansionTile(
                      leading:
                          SvgPicture.asset("assets/icons/diamond_light.svg"),
                      title: Text(
                        "Activity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      children: [
                        MenuTile(
                          isActive: pageController.pagesId ==
                              PagesId.ActivityPerformanceTest,
                          isSubmenu: true,
                          title: "Performance Test",
                          onPressed: () {
                            pageController
                                .changePageId(PagesId.ActivityPerformanceTest);
                          },
                        ),
                        MenuTile(
                          isActive: pageController.pagesId ==
                              PagesId.ActivityTestReport,
                          isSubmenu: true,
                          title: "Test Report",
                          count: 16,
                          onPressed: () {
                            pageController
                                .changePageId(PagesId.ActivityTestReport);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  if (Responsive.isMobile(context))
                    const CustomerInfo(
                      name: 'Tran Mau Tri Tam',
                      designation: 'Visual Designer',
                      imageSrc:
                          'https://cdn.create.vista.com/api/media/small/339818716/stock-photo-doubtful-hispanic-man-looking-with-disbelief-expression',
                    ),
                  gapH8,
                  const Divider(),
                  gapH8,
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/help_light.svg',
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textLight,
                          BlendMode.srcIn,
                        ),
                      ),
                      gapW8,
                      Text(
                        'Help & getting started',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Chip(
                        backgroundColor: AppColors.secondaryLavender,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(horizontal: 0.5),
                        label: Text(
                          "8",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  gapH20,
                  const ThemeTabs(),
                  gapH8,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
