import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/cubit/chatbot_cubit.dart';
import 'package:etiya_chatbot_flutter/src/localization/localization.dart';
import 'package:etiya_chatbot_flutter/src/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConversationFeedback extends StatefulWidget {
  const ConversationFeedback(
    this.message, {
    super.key,
    required this.theme,
  });

  final MessageResponse message;
  final ChatTheme theme;

  @override
  State<StatefulWidget> createState() => ConversationFeedbackState();
}

class ConversationFeedbackState extends State<ConversationFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  double progress = 0;

  TextEditingController feedbackTextController = TextEditingController();
  double ratingScore = 3;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);

    controller
      ..addListener(() {
        setState(() {});
      })
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AnimatedContainer(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(
          milliseconds: 300,
        ),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 20.h,
                      top: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 44,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  context.read<ChatbotCubit>().clearSession();
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _ConversationFeedbackTitle(
                          title: widget.message.text!,
                          textStyle: widget.theme.incomingMessageBodyTextStyle
                              .copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: RatingBar.builder(
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              initialRating: 3,
                              allowHalfRating: true,
                              unratedColor: Colors.grey.withAlpha(50),
                              itemBuilder: (context, index) {
                                if (ratingScore > index &&
                                    ratingScore < index + 1) {
                                  return const Stack(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.solidStarHalfStroke,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  );
                                } else if (ratingScore >= index + 1) {
                                  return const FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber,
                                  );
                                } else {
                                  return const FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber,
                                  );
                                }
                              },
                              onRatingUpdate: (rating) {
                                setState(() {
                                  ratingScore = rating;
                                });
                                Log.info('onRatingUpdate = $rating');
                              },
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            "Tap a Star to Rate",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Leave a review (optional)',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          controller: feedbackTextController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 7,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => sendFeedback(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => sendFeedback(),
                            style: widget.theme.carouselButtonStyle,
                            child: Text(context.localization.submit),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendFeedback() async {
    context.read<ChatbotCubit>().userSubmittedFeedbackMessage(
          ratingScore: ratingScore,
          feedback: feedbackTextController.text,
          sessionId: int.tryParse(widget.message.sessionId!) ?? 0,
        );
    Navigator.of(context).pop();
  }
}

class _ConversationFeedbackTitle extends StatelessWidget {
  const _ConversationFeedbackTitle({
    required this.title,
    required this.textStyle,
  });

  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      textAlign: TextAlign.start,
    );
  }
}
