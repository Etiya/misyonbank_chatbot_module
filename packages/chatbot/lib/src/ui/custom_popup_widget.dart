import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/presentation/widgets/overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    super.key,
    required this.messageResponse,
  });
  final MessageResponse messageResponse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        top: false,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 30.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              Text(
                messageResponse.payload!.header.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black54,
                ),
              ),
              16.verticalSpace,
              Text(
                messageResponse.payload!.subHeader.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                ),
              ),
              25.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10).r,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 20.w,
                ),
                child: Text(
                  messageResponse.payload!.content.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                    color: const Color(0xFF7368F4),
                    shadows: const [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              25.verticalSpace,
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xFF7368F4),
                    ),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: messageResponse.payload!.content.toString(),
                      ),
                    );

                    if (context.mounted) {
                      showOverlay(
                        context,
                      );
                    }
                  },
                  child: Text(
                    messageResponse.payload!.buttonText.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              Text(
                messageResponse.payload!.annotation.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
