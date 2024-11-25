import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_request.dart';
import 'package:etiya_chatbot_flutter/src/core/etiya_chatbot_data/models/api/etiya_message_response.dart';
import 'package:etiya_chatbot_flutter/src/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormSheet extends HookWidget {
  FormSheet({
    super.key,
    required this.fields,
  });

  final List<Field> fields;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic>? values;

  @override
  Widget build(BuildContext context) {
    // values listesini useState ile yönetiyoruz.
    final valuesState =
        useState<List<dynamic>>(List.generate(fields.length, (index) => null));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                for (final field in fields)
                  buildFormField(
                    field: field,
                    index: fields.indexOf(field),
                    valuesState: valuesState,
                  ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final List<ReplyField> replyField = fields
                            .asMap()
                            .entries
                            .map(
                              (entry) => ReplyField(
                                label: entry.value.label,
                                value: valuesState.value[entry.key],
                              ),
                            )
                            .toList();

                        Navigator.of(context).pop({
                          "replyField": replyField,
                        });
                      }
                    },
                    color: const Color(0xFF7368F4),
                    child: Text(
                      context.localization.submit,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onUpdate(
    int index,
    dynamic val,
    ValueNotifier<List<dynamic>> valuesState,
  ) async {
    // Yeni değeri values listesinde güncelliyoruz
    valuesState.value[index] = val;
    valuesState
        .notifyListeners(); // Değişiklikleri dinleyenleri bilgilendiriyoruz
  }

  Widget buildFormField({
    required Field field,
    required int index,
    required ValueNotifier<List<dynamic>> valuesState,
  }) {
    switch (field.type) {
      case "text":
        // TextEditingController kullanarak değerlerin kontrolünü sağlıyoruz
        final controller = useTextEditingController();
        final focusNode = useFocusNode();

        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: field.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 238, 238),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: (val) {
              onUpdate(index, val, valuesState); // Değeri güncelliyoruz
            },
          ),
        );
      case "textArea":
        // TextEditingController kullanarak değerlerin kontrolünü sağlıyoruz
        final controller = useTextEditingController();
        final focusNode = useFocusNode();

        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
            onChanged: (val) {
              onUpdate(index, val, valuesState); // Değeri güncelliyoruz
            },
            maxLines: 2,
            decoration: InputDecoration(
              labelText: field.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 238, 238),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      case "checkbox":
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: FormBuilderCheckbox(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // Validation sadece kullanıcı etkileşimi olduğunda çalışacak
            onChanged: (val) {
              onUpdate(index, val, valuesState); // Değeri güncelliyoruz
            },
            validator: (value) {
              if (value == null || value == false) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
            name: 'DENEME',
            title: const Text(
              "I agree to the Privacy Policy, Terms of Use and Terms of Service",
            ),
          ),
        );
      case "select":
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: DropdownButtonFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: field.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 238, 238),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (value) {
              if (value == null) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
            hint: Text(field.label!),
            onChanged: (val) {
              onUpdate(index, val, valuesState); // Değeri güncelliyoruz
            },
            items: field.options
                ?.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
          ),
        );
      default:
        return Container();
    }
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonStyle,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
