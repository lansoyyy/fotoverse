import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hint;
  final String label;
  bool? isObscure;
  final TextEditingController controller;
  final double? width;
  final IconData? prefixIcon;
  final double? height;
  final int? maxLine;
  final TextInputType? inputType;
  late bool? showEye;
  late Color? color;
  late Color? textcolor;
  late Color? borderColor;
  late Color? hintColor;
  late double? radius;
  final String? Function(String?)? validator; // Add validator parameter

  final TextCapitalization? textCapitalization;
  final FontStyle? fontStyle;

  final bool? isRequred;

  TextFieldWidget({
    Key? key,
    this.hint = '',
    this.isRequred = true,
    this.fontStyle = FontStyle.italic,
    required this.label,
    this.prefixIcon,
    required this.controller,
    this.isObscure = false,
    this.width = 325,
    this.height = 60,
    this.maxLine = 1,
    this.textcolor = Colors.white,
    this.hintColor = Colors.white,
    this.borderColor = Colors.grey,
    this.showEye = false,
    this.color = Colors.white,
    this.radius = 5,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputType = TextInputType.text,
    this.validator, // Add validator parameter
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Bold',
                  color: widget.textcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              widget.isRequred!
                  ? const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Bold',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const TextSpan(
                      text: '',
                      style: TextStyle(
                        fontSize: 0,
                        fontFamily: 'Bold',
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
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
              filled: true,
              fillColor: Colors.white,
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              hintStyle: TextStyle(
                fontStyle: widget.fontStyle!,
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
            validator:
                widget.validator, // Pass the validator to the TextFormField
          ),
        ),
      ],
    );
  }
}
