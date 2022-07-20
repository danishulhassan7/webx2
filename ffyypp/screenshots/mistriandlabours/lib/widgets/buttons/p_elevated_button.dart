import 'package:flutter/material.dart';

class PElevatedButton extends StatelessWidget {
  const PElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 40.0,
    this.iconOnLeading = false,
    this.disable = false,
    this.iconSpacing = 15,
    this.isBusy = false,
    this.disableColor = Colors.grey,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Widget? icon;
  final double height;
  final bool iconOnLeading;
  final bool disable;
  final double iconSpacing;
  final bool isBusy;
  final Color disableColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: disable ? () {} : onPressed,
        style: ButtonStyle(
          backgroundColor:
              disable ? MaterialStateProperty.all(disableColor) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && iconOnLeading)
              Padding(
                padding: EdgeInsets.only(right: iconSpacing),
                child: icon,
              ),
            Text(
              label,
              style: textStyle ??
                  Theme.of(context).textTheme.button!.copyWith(
                        color: disable
                            ? Colors.grey
                            : Theme.of(context).textTheme.button!.color,
                      ),
            ),
            if (icon != null && !iconOnLeading)
              Padding(
                padding: EdgeInsets.only(left: iconSpacing),
                child: icon,
              ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              child: AnimatedSwitcher(
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                reverseDuration: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 300),
                child: isBusy
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: disable
                                ? Colors.grey
                                : Theme.of(context).textTheme.button!.color,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
