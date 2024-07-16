import 'package:core_dashboard/shared/utils/input_formatter.dart';
import 'package:core_dashboard/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  void Function(String)? onChanged;
  void Function()? onTap;
  void Function(String)? onFieldSubmitted;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? hint;
  bool? enable;
  bool? readonly;
  TextEditingController? txtController;
  bool? autoFocus;
  List<TextInputFormatter>? inputFormatters;
  TextCapitalization? textCapitalization;
  bool? obscureText;
  double? width;
  FocusNode? focusNode;

  CustomTextField({
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.enable,
    this.readonly,
    this.onTap,
    this.txtController,
    this.autoFocus,
    super.key,
    this.inputFormatters,
    this.textCapitalization,
    this.obscureText,
    this.width,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: 48,
      child: Center(
        child: TextFormField(
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters ?? [],
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          autofocus: autoFocus ?? false,
          controller: txtController,
          readOnly: readonly ?? false,
          enabled: enable,
          onChanged: onChanged,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor.getColor(1)),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor.brandColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon),
        ),
      ),
    );
  }
}
