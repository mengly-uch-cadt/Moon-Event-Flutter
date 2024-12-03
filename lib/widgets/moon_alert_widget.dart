import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';

class MoonAlertWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final String? cancelText;
  final String? okText;
  final bool? inLineButton; 
  final bool? typeError;

  const MoonAlertWidget({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.cancelText = 'Cancel',
    this.okText = 'Ok',
    this.inLineButton = true,
    this.typeError = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Icon(
              icon,
              key: ValueKey<IconData?>(icon),
              size: 64,
              color: typeError == true ? AppColors.red : AppColors.primary, // Example color
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: description != null
          ? SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : null,
      actions: <Widget>[
        if (typeError == true)
          MoonButtonWidget(
            text: cancelText,
            textColor: AppColors.primary,
            buttonColor: AppColors.gray,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        if (typeError == false)
          if (inLineButton == true)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: MoonButtonWidget(
                    text: cancelText,
                    textColor: AppColors.primary,
                    buttonColor: AppColors.gray,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: MoonButtonWidget(
                    text: okText,
                    buttonColor: AppColors.primary,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            )
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MoonButtonWidget(
                  text: cancelText,
                  textColor: AppColors.primary,
                  buttonColor: AppColors.gray,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                const SizedBox(height: 8),
                MoonButtonWidget(
                  text: okText,
                  buttonColor: AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
      ],
    );
  }
}
