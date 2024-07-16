import 'package:core_dashboard/shared/widgets/components/glassmorphism.dart';
import 'package:core_dashboard/theme/widget_props.dart';
import 'package:flutter/material.dart';

class ListBottomsheet extends StatelessWidget {
  final List<String> list;

  const ListBottomsheet({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      blur: 10,
      color: Colors.black,
      opacity: 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          height: cWidth(context),
          child: ListView(
            children: list.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.white),
                      borderRadius: kDefaultBorderRadiusAll,
                    ),
                    height: 60,
                    child: Center(
                        child: Text(
                      e,
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  onTap: () {
                    Navigator.pop(context, e);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
