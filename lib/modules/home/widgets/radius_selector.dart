import 'package:departuretimes/shared/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadiusSelector extends StatelessWidget {
  final RxInt radius;
  final Function(int) onChanged;

  const RadiusSelector(
      {super.key, required this.radius, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text('${StringsConstants.radius}: '),
          Expanded(
            child: Obx(() => Slider(
                  value: radius.value.toDouble(),
                  min: 100,
                  max: 5000,
                  divisions: 49,
                  label: '${radius.value}m',
                  onChanged: (value) => onChanged(value.round()),
                )),
          ),
        ],
      ),
    );
  }
}
