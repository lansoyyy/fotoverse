import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String? hint;
  bool? isObscure;
  final TextEditingController controller;
  final double? width;
  final IconData? prefixIcon;
  final double? height;
  final int? maxLine;
  final TextInputType? inputType;
  late bool? showEye;
  late Color? color;
  late Color? borderColor;
  late Color? hintColor;
  late double? radius;
  final String? Function(String?)? validator; // Add validator parameter

  final TextCapitalization? textCapitalization;

  AuthTextFieldWidget({
    super.key,
    this.hint = '',
    this.prefixIcon,
    required this.controller,
    this.isObscure = false,
    this.width = 325,
    this.height = 50,
    this.maxLine = 1,
    this.hintColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.showEye = false,
    this.color = Colors.white,
    this.radius = 5,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputType = TextInputType.text,
    this.validator, // Add validator parameter
  });

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        style: const TextStyle(
          fontFamily: 'Regular',
          fontSize: 14,
        ),
        textCapitalization: widget.textCapitalization!,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
            color: primary,
          ),
          suffixIcon: widget.showEye! == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure!;
                    });
                  },
                  icon: widget.isObscure!
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ))
              : const SizedBox(),
          hintStyle: const TextStyle(
            fontFamily: 'Regular',
            fontSize: 14,
            color: Colors.grey,
          ),
          hintText: widget.hint,
          border: InputBorder.none,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor!,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor!,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor!,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorStyle: const TextStyle(fontFamily: 'Bold', fontSize: 12),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),

        maxLines: widget.maxLine,
        obscureText: widget.isObscure!,
        controller: widget.controller,
        validator: widget.validator, // Pass the validator to the TextFormField
      ),
    );
  }
}
