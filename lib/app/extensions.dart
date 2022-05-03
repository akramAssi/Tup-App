// ignore_for_file: constant_identifier_names

const EMPTY = "";
const ZERO = 0;

extension NonNullString on String? {
  String orEmpty() {
    return this ?? "";
  }
}

extension NonNullInteger on int? {
  int orZero() {
    return this ?? 0;
  }
}
