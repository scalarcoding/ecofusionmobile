import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestHeader extends StatelessWidget {
  const TestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding * 1.25),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: "Test Header",
            color: AppColors.secondaryBabyBlue,
          ),
          gapH20,
          const Text(
            'Klik tombol di bawah untuk memulai performance test',
          ),
          const Text(
            'Report Number :',
          ),
          Text(
            '# 12123877431',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          gapH20,
          OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/clipboard_light.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textLight,
                    BlendMode.srcIn,
                  ),
                ),
                if (!Responsive.isMobile(context)) gapW4,
                if (!Responsive.isMobile(context))
                  Text(
                    "Mulai Test",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
