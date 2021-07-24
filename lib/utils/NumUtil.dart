
import 'package:intl/intl.dart';

/// Num Util.
class NumUtil {
  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueStr(String valueStr, {int fractionDigits}) {
    double value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueDouble(double value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }

  /// get int by value str.
  static int getIntByValueStr(String valueStr, {int defValue = 0}) {
    return int.tryParse(valueStr) ?? defValue;
  }

  /// get double by value str.
  static double getDoubleByValueStr(String valueStr, {double defValue = 0}) {
    return double.tryParse(valueStr) ?? defValue;
  }

  ///isZero
  static bool isZero(num value) {
    return value == null || value == 0;
  }

  /// 加 (精确相加,防止精度丢失).
  /// add (without loosing precision).
  static double add(num a, num b) {
    return addDec(a, b).toDouble();
  }

  /// 减 (精确相减,防止精度丢失).
  /// subtract (without loosing precision).
  static double subtract(num a, num b) {
    return subtractDec(a, b).toDouble();
  }

  /// 乘 (精确相乘,防止精度丢失).
  /// multiply (without loosing precision).
  static double multiply(num a, num b) {
    return multiplyDec(a, b).toDouble();
  }

  /// 除 (精确相除,防止精度丢失).
  /// divide (without loosing precision).
  static double divide(num a, num b) {
    return divideDec(a, b).toDouble();
  }

  /// 加 (精确相加,防止精度丢失).
  /// add (without loosing precision).
  static num addDec(num a, num b) {
    return addDecStr(a.toString(), b.toString());
  }

  /// 减 (精确相减,防止精度丢失).
  /// subtract (without loosing precision).
  static num subtractDec(num a, num b) {
    return subtractDecStr(a.toString(), b.toString());
  }

  /// 乘 (精确相乘,防止精度丢失).
  /// multiply (without loosing precision).
  static num multiplyDec(num a, num b) {
    return multiplyDecStr(a.toString(), b.toString());
  }

  /// 除 (精确相除,防止精度丢失).
  /// divide (without loosing precision).
  static num divideDec(num a, num b) {
    return divideDecStr(a.toString(), b.toString());
  }

  /// 除 (精确相除,防止精度丢失).保留几位小数，返回String
  /// divide (without loosing precision).
  static String divideStrNum(num a, num b, int digits) {
    return divideDecStr((a ?? 0).toString(), (b ?? 0).toString())
        .toStringAsFixed(digits);
  }

  /// 除 (精确相除,防止精度丢失).保留几位小数，返回String
  /// divide (without loosing precision).
  static String divideStrStr(String a, String b, int digits) {
    return divideDecStr(a ?? '0', b ?? '0').toStringAsFixed(digits);
  }

  /// 四舍五入(精确相除,防止精度丢失).保留几位小数，返回String
  /// (without loosing precision).
  static String toStringAsFixed(num a, int digits) {
    return num.parse((a ?? 0).toString()).toStringAsFixed(digits);
  }

  /// 四舍五入(精确相除,防止精度丢失).保留几位小数，返回Double
  /// (without loosing precision).
  static num toDoubleAsFixed(num a, int digits) {
    return num.parse(
        num.parse((a ?? 0).toString()).toStringAsFixed(digits));
  }

  /// 四舍五入(精确相除,防止精度丢失).保留几位小数，返回String
  /// (without loosing precision).
  static String toStringAsFixedStr(String a, int digits) {
    return num.parse(a).toStringAsFixed(digits);
  }

  /// 余数
  static num remainder(num a, num b) {
    return remainderDecStr(a.toString(), b.toString());
  }

  /// Relational less than operator.
  static bool lessThan(num a, num b) {
    return lessThanDecStr(a.toString(), b.toString());
  }

  /// Relational less than or equal operator.
  static bool thanOrEqual(num a, num b) {
    return thanOrEqualDecStr(a.toString(), b.toString());
  }

  /// Relational greater than operator.
  static bool greaterThan(num a, num b) {
    return greaterThanDecStr(a.toString(), b.toString());
  }

  /// Relational greater than or equal operator.
  static bool greaterOrEqual(num a, num b) {
    return greaterOrEqualDecStr(a.toString(), b.toString());
  }

  /// 加
  static num addDecStr(String a, String b) {
    return num.parse(a) + num.parse(b);
  }

  /// 减
  static num subtractDecStr(String a, String b) {
    return num.parse(a) - num.parse(b);
  }

  /// 乘
  static num multiplyDecStr(String a, String b) {
    return num.parse(a) * num.parse(b);
  }

  /// 除
  static num divideDecStr(String a, String b) {
    return num.parse(a) / num.parse(b);
  }

  /// 余数
  static num remainderDecStr(String a, String b) {
    return num.parse(a) % num.parse(b);
  }

  /// Relational less than operator.
  static bool lessThanDecStr(String a, String b) {
    return num.parse(a) < num.parse(b);
  }

  /// Relational less than or equal operator.
  static bool thanOrEqualDecStr(String a, String b) {
    return num.parse(a) <= num.parse(b);
  }

  /// Relational greater than operator.
  static bool greaterThanDecStr(String a, String b) {
    return num.parse(a) > num.parse(b);
  }

  /// Relational greater than or equal operator.
  static bool greaterOrEqualDecStr(String a, String b) {
    return num.parse(a) >= num.parse(b);
  }

  static String parseFeeNumber(num fee) {
    if (fee == null) {
      return "0";
    }
    //数字格式化
    NumberFormat format = NumberFormat.currency(
        locale: 'id_ID', name: 'IDR', symbol: 'Rp', decimalDigits: 0);
    return format.format(fee);
  }
}