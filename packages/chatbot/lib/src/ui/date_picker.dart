import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_chat/swifty_chat.dart';

class DatePickerPopup extends StatefulWidget {
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
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool isRequired;
  final bool hasError;
  final Message? message;

  const DatePickerPopup({
    super.key,
    required this.context,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.controller,
    this.hintText = 'GG/AA/YYYY',
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
  State<DatePickerPopup> createState() => _DatePickerPopupState();
}

class _DatePickerPopupState extends State<DatePickerPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        readOnly: true,
        controller: widget.controller,
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
                final DateTime? selectedDate = await showDatePicker(
                  context: widget.context,
                  initialDate: widget.initialDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  helpText: widget.helpText,
                  cancelText: widget.cancelText,
                  confirmText: widget.confirmText,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
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
                          "${selectedDate.toIso8601String()}Z",
                        );
                    setState(() {
                      widget.controller.text =
                          "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
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
