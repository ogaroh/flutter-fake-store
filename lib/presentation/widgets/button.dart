import 'package:fake_store/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppButtonType {
  primary,
  primaryDark,
  dark,
  outline,
  outlineSecondary,
  ghost,
  error,
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final style = _getButtonStyle(type);

    return SizedBox(
      width: width ?? double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: _getTextColor(type),
          ),
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(AppButtonType type) {
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
      case AppButtonType.primaryDark:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
      case AppButtonType.dark:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.dark,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0.5,
        );
      case AppButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black54, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
      case AppButtonType.outlineSecondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: Colors.black54,
          side: const BorderSide(color: AppColors.outline, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
      case AppButtonType.ghost:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.disabled,
          foregroundColor: Colors.black54,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
      case AppButtonType.error:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        );
    }
  }

  Color _getTextColor(AppButtonType type) {
    switch (type) {
      case AppButtonType.primary:
        return Colors.black;
      case AppButtonType.primaryDark:
      case AppButtonType.dark:
        return AppColors.white;
      case AppButtonType.outline:
        return Colors.black;
      case AppButtonType.outlineSecondary:
      case AppButtonType.ghost:
        return Colors.black54;
      case AppButtonType.error:
        return AppColors.white;
    }
  }
}

class CustomBackButtom extends StatelessWidget {
  const CustomBackButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.greyFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: InkWell(
        onTap: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
