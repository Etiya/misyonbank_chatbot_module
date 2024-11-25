import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_chat/swifty_chat.dart';

class DateRangePickerPopup extends StatefulWidget {
  final String hintText;
  final BuildContext context;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String helpText;
  final String cancelText;
  final String confirmText;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool isRequired;
  final bool hasError;
  final Message? message;

  const DateRangePickerPopup({
    super.key,
    required this.context,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.startDateController,
    required this.endDateController,
    this.hintText = 'GG/AA/YYYY - GG/AA/YYYY',
    this.helpText = 'Select a date',
    this.cancelText = 'Cancel',
    this.confirmText = 'OK',
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.black,
    this.icon = Icons.calendar_month,
    this.hintStyle,
    this.labelStyle,
    this.isRequired = false,
    this.hasError = false,
    this.message,
  });

  @override
  State<DateRangePickerPopup> createState() => _DateRangePickerPopupState();
}

class _DateRangePickerPopupState extends State<DateRangePickerPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        readOnly: true,
        // Her iki tarihi gösterecek şekilde controller'ı güncelliyoruz.
        controller: TextEditingController(
          text: widget.startDateController.text.isNotEmpty &&
                  widget.endDateController.text.isNotEmpty
              ? '${widget.startDateController.text} - ${widget.endDateController.text}'
              : '',
        ),
        decoration: InputDecoration(
          errorText: widget.isRequired && widget.hasError
              ? 'This field is mandatory'
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText:
              widget.isRequired ? '${widget.hintText} *' : widget.hintText,
          hintStyle: widget.hintStyle,
          labelStyle: widget.labelStyle,
          suffixIcon: IgnorePointer(
            ignoring: !widget.message!.canTap,
            child: IconButton(
              onPressed: () async {
                final DateTimeRange? selectedDate = await showDateRangePicker(
                  context: widget.context,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  helpText: widget.helpText,
                  cancelText: widget.cancelText,
                  confirmText: widget.confirmText,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        datePickerTheme: DatePickerThemeData(
                          rangeSelectionBackgroundColor:
                              Colors.blue.withOpacity(
                            0.2,
                          ),
                        ),
                        colorScheme: ColorScheme.light(
                          primary: widget.primaryColor,
                          onSurface: widget.secondaryColor,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (selectedDate != null) {
                  if (context.mounted) {
                    context.read<ChatbotCubit>().userAddedDateTimeMessage(
                          "${selectedDate.start.toIso8601String()}Z",
                          endDate: "${selectedDate.end.toIso8601String()}Z",
                        );
                    setState(() {
                      widget.startDateController.text =
                          "${selectedDate.start.day.toString().padLeft(2, '0')}/${selectedDate.start.month.toString().padLeft(2, '0')}/${selectedDate.start.year}";
                      widget.endDateController.text =
                          "${selectedDate.end.day.toString().padLeft(2, '0')}/${selectedDate.end.month.toString().padLeft(2, '0')}/${selectedDate.end.year}";
                    });
                  }
                }
              },
              icon: Icon(widget.icon),
            ),
          ),
        ),
      ),
    );
  }
}
