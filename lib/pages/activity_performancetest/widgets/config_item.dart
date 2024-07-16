import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/avatar/config_avatar.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ConfigItem extends StatefulWidget {
  const ConfigItem({
    super.key,
    required this.name,
    required this.accuracy,
    required this.imageSrc,
    this.isActive = true,
    this.onPressed,
  });

  final String name, accuracy, imageSrc;
  final bool isActive;
  final Function()? onPressed;

  @override
  State<ConfigItem> createState() => _ConfigItemState();
}

class _ConfigItemState extends State<ConfigItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding * 0.5,
        vertical: AppDefaults.padding * 0.75,
      ),
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        child: Row(
          children: [
            ConfigAvatar(imageSrc: widget.imageSrc),
            gapW8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isHovered ? AppColors.primary : null),
                  ),
                  const Text('detail')
                ],
              ),
            ),
            gapW8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.accuracy,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isHovered ? AppColors.primary : null),
                ),
                gapH4,
                Chip(
                  backgroundColor: widget.isActive
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding * 0.25,
                      vertical: AppDefaults.padding * 0.25),
                  label: Text(
                    widget.isActive ? "Active" : "Inactive",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: widget.isActive
                            ? AppColors.success
                            : AppColors.error),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
