import 'dart:math';

import 'package:core_dashboard/pages/activity_performancetest/widgets/config_item.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvailableConfigs extends StatelessWidget {
  const AvailableConfigs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      padding: const EdgeInsets.all(AppDefaults.padding * 0.75),
      child: Column(
        children: [
          gapH8,
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDefaults.padding * 0.5,
            ),
            child: SectionTitle(
              title: "Available Configs",
              color: AppColors.secondaryLavender,
            ),
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDefaults.padding * 0.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Configs', style: Theme.of(context).textTheme.labelSmall),
                Text('Accuracy', style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
          gapH8,
          const Divider(),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return ConfigItem(
                name: 'Config # ${index + 1}',
                accuracy: '${Random().nextInt(100)} %',
                imageSrc: 'assets/images/illustration/ai.png',
                isActive: index % 2 == 0,
                onPressed: () {},
              );
            },
          ),
          gapH16,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDefaults.padding * 0.5,
            ),
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                "All products",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          gapH8,
        ],
      ),
    );
  }
}
