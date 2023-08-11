import 'package:flutter/material.dart';
import '../../utils/global.colors.dart';

class CheckboxBulanGlobal extends StatefulWidget {
  const CheckboxBulanGlobal(
      {super.key,
      required this.bulanItem,
      required this.onChanged,
      required this.isChecked});
  final String bulanItem;
  final Function(bool value) onChanged;
  final bool isChecked;
  @override
  State<CheckboxBulanGlobal> createState() => _CheckboxBulanGlobalState();
}

class _CheckboxBulanGlobalState extends State<CheckboxBulanGlobal> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: -10,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: GlobalColors.stroke,
          ),
          child: Checkbox(
            checkColor: GlobalColors.whiteColor,
            activeColor: GlobalColors.mainColor,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
                widget.onChanged(isChecked);
              });
            },
            visualDensity: VisualDensity.compact,
          ),
        ),
        Text(widget.bulanItem),
      ],
    );
  }
}
