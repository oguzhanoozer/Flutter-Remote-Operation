import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/constants/app_size.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../core/configs/theme/app_text_styles.dart';
import '../../core/models/rx.dart';
import 'icon_button.dart';
import 'obx.dart';

const double _emptyHeight = 30;

enum TextFieldType {
  roundedSingle(false, AppSize.textFieldRadius, 1),
  rectangleSingle(false, 4, 1),
  rectangleMulti(true, 4, null);

  final bool _expands;
  final double _radius;
  final int? _lines;

  const TextFieldType(this._expands, this._radius, this._lines);
}

final class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.type = TextFieldType.roundedSingle,
    this.hintText,
    String? initialValue,
    this.isError = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.obscureText = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : _controller = TextEditingController(text: initialValue);

  final TextFieldType type;
  final String? hintText;
  final bool isError;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function()? onTap;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController _controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Rx<bool> isLockPassword = Rx<bool>(false);
  Rx<bool> isShowClearButton = Rx<bool>(false);
  Rx<bool> isShowSuffixIcon = Rx<bool>(false);
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    isShowSuffixIcon(set: () => _focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    widget._controller.addListener(() {
      isShowClearButton(set: () => widget._controller.text.isNotEmpty);
    });

    return SizedBox(
      height: AppSize.textFieldHeight,
      child: Obx.multiple(
        <RxBase>[isLockPassword, isShowSuffixIcon],
        builder: (
          BuildContext context,
          _,
        ) {
          return TextField(
            focusNode: _focus,
            maxLines: widget.type._lines,
            minLines: widget.type._lines,
            expands: widget.type._expands,
            controller: widget._controller,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            showCursor: true,
            obscureText: widget.isPasswordField ? !isLockPassword.value : false,
            obscuringCharacter: '*',
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            cursorWidth: 1,
            cursorColor: AppColors.onSurfaceHigh,
            style: AppTextStyles.body1_high(),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              suffixIcon: switch (widget.isError) {
                true => CustomIconButton(
                    icon: AppIcons.error(),
                  ),
                false => switch (isShowSuffixIcon.value) {
                    true => switch (widget.isPasswordField) {
                        true => CustomIconButton(
                            onTap: () {
                              isLockPassword(set: () => !isLockPassword.value);
                            },
                            icon: !isLockPassword.value ? AppIcons.password() : AppIcons.password_yellow(),
                          ),
                        false => CustomIconButton(
                            onTap: () => widget._controller.text = '',
                            icon: AppIcons.clear(color: AppColors.shadow),
                          ),
                      },
                    false => const SizedBox()
                  },
              },
              suffixIconConstraints: BoxConstraints.loose(const Size.fromHeight(_emptyHeight)),
              labelText: widget.hintText,
              labelStyle: AppTextStyles.body1_medium(color: widget.isError ? AppColors.error : AppColors.shadow),
              floatingLabelStyle: AppTextStyles.body1_low(color: widget.isError ? AppColors.error : AppColors.shadow),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppSize.textFieldPaddingVertical,
                horizontal: AppSize.textFieldPaddingHorizontal,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.isError ? AppColors.error : AppColors.shadow),
              ),
            ),
          );
        },
      ),
    );
  }
}
