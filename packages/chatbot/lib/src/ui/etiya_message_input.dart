import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EtiyaMessageInput extends StatefulHookWidget {
  const EtiyaMessageInput({
    super.key,
    required this.sendButtonTapped,
    this.maxLength,
    this.hintText = "Aa",
    this.showCharacterCount,
  });

  final Function(String) sendButtonTapped;
  final String hintText;
  final int? maxLength;
  final bool? showCharacterCount;

  @override
  _EtiyaMessageInputState createState() => _EtiyaMessageInputState();
}

class _EtiyaMessageInputState extends State<EtiyaMessageInput> {
  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    final isTextEmpty = useState(true);
    final textLength = useState(0);
    useEffect(
      () {
        textEditingController.addListener(() {
          isTextEmpty.value = textEditingController.text.trim().isEmpty;
        });
        return () {
          textEditingController.dispose();
        };
      },
      [textEditingController],
    );
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          children: [
            PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: 1.sw,
                maxWidth: 1.sw,
              ),
              offset: const Offset(0, -180),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              color: Colors.white,
              icon: const Icon(Icons.dehaze, color: Colors.black54),
              onSelected: (String value) {
                debugPrint('Selected: $value');
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Option 1',
                    child: const Text('Option 1'),
                    onTap: () {
                      widget.sendButtonTapped("Option1");
                      textEditingController.clear();
                      textLength.value = 0;
                    },
                  ),
                  const PopupMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Option 3',
                    child: Text('Option 3'),
                  ),
                ];
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: textEditingController,
                textCapitalization: TextCapitalization.sentences,
                maxLength: widget.maxLength,
                decoration: InputDecoration(
                  suffixText: widget.showCharacterCount == true
                      ? '${textLength.value}/${widget.maxLength}'
                      : null,
                  suffixStyle: TextStyle(
                    fontSize: 10.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 2),
                  ),
                  counter: const Offstage(),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xffAEA4A3),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  textLength.value = textEditingController.text.length;
                },
                textInputAction: TextInputAction.send,
                onSubmitted: (_) {
                  if (!isTextEmpty.value) {
                    widget.sendButtonTapped(textEditingController.text);
                    textEditingController.clear();
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: isTextEmpty.value
                  ? null
                  : () {
                      widget.sendButtonTapped(textEditingController.text.trim());
                      textEditingController.clear();
                      textLength.value = 0;
                    },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isTextEmpty.value
                      ? Colors.grey.shade400
                      : const Color(0xFF7368F4),
                ),
                child: Icon(
                  Icons.send_outlined,
                  color:
                      isTextEmpty.value ? Colors.grey.shade100 : Colors.white70,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
