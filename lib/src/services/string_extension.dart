extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String titleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
