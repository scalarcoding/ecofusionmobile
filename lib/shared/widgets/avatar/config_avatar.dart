import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:flutter/cupertino.dart';

class ConfigAvatar extends StatelessWidget {
  const ConfigAvatar({
    super.key,
    this.height = 54,
    this.width = 54,
    this.radius = AppDefaults.borderRadius,
    required this.imageSrc,
  });

  final double height, width, radius;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: AssetImage(imageSrc),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
