import 'package:flutter/material.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.labelText,
    required this.valueWidget,
    this.onTap,
    this.validator,
  });

  final String labelText;
  final Widget valueWidget;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator == null ? null : (_) => validator!(null),
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),

                  errorText: formFieldState.hasError
                      ? formFieldState.errorText
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    valueWidget,
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
