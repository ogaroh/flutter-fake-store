// an extension on String to capitalize the first letter
extension StringExtension on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}
