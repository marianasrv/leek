enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension MonthExtension on Month {
  String get abbr {
    switch (this) {
      case Month.january:
        return 'JAN';
      case Month.february:
        return 'FEB';
      case Month.march:
        return 'MAR';
      case Month.april:
        return 'APR';
      case Month.may:
        return 'MAY';
      case Month.june:
        return 'JUN';
      case Month.july:
        return 'JUL';
      case Month.august:
        return 'AUG';
      case Month.september:
        return 'SEP';
      case Month.october:
        return 'OCT';
      case Month.november:
        return 'NOV';
      case Month.december:
        return 'DEC';
      default:
        return null;
    }
  }

  int get order {
    switch (this) {
      case Month.january:
        return 1;
      case Month.february:
        return 2;
      case Month.march:
        return 3;
      case Month.april:
        return 4;
      case Month.may:
        return 5;
      case Month.june:
        return 6;
      case Month.july:
        return 7;
      case Month.august:
        return 8;
      case Month.september:
        return 9;
      case Month.october:
        return 10;
      case Month.november:
        return 11;
      case Month.december:
        return 12;
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case Month.january:
        return 'January';
      case Month.february:
        return 'February';
      case Month.march:
        return 'March';
      case Month.april:
        return 'April';
      case Month.may:
        return 'May';
      case Month.june:
        return 'June';
      case Month.july:
        return 'July';
      case Month.august:
        return 'August';
      case Month.september:
        return 'September';
      case Month.october:
        return 'October';
      case Month.november:
        return 'November';
      case Month.december:
        return 'December';
      default:
        return null;
    }
  }
}
