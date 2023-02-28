import 'package:collaction_cms/presentation/shared/form/util/field_popup.dart';
import 'package:collaction_cms/presentation/shared/form/util/date_time/time_picker.dart';
import 'package:collaction_cms/presentation/theme/button.dart';
import 'package:collaction_cms/presentation/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerButton extends StatefulWidget {
  final double width;
  final Function(DateTime)? callback;
  final DateTime? selectedTime;
  final DateTime? earliestTime;
  final DateTime? latestTime;
  final bool readOnly;

  const TimePickerButton({
    super.key,
    required this.width,
    this.callback,
    this.selectedTime,
    this.earliestTime,
    this.latestTime,
    this.readOnly = false,
  });

  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
  bool _timeSet = false;
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
  }

  void _closeTimePicker() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: widget.readOnly,
            child: TextButton(
              onPressed: () {
                if (!widget.readOnly) {
                  setState(() {
                    _showOverlay = true;
                  });
                }
              },
              style: formFieldButtonStyle(readOnly: widget.readOnly).copyWith(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: widget.width,
                    child: Text(
                      _timeSet
                          ? DateFormat.Hm().format(widget.selectedTime!)
                          : "--:--",
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w300,
                        color: kBlackPrimary300,
                        fontSize: 15,
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showOverlay)
            fieldPopup(
              CollActionTimePicker(
                selectedTime: widget.selectedTime,
                earliestTime: widget.earliestTime,
                latestTime: widget.latestTime,
                onTimeSelected: (DateTime dateTime) {
                  _timeSet = true;
                  widget.callback!(dateTime);
                },
                onCancel: _closeTimePicker,
              ),
              height: 174,
              width: 220,
              offset: 0,
              onTapOutside: _closeTimePicker,
            ),
        ],
      ),
    );
  }
}