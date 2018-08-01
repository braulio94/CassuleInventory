
class InventoryDate {

  static final date_year = 'year';
  static final date_month = 'month';
  static final date_day = 'day';
  static final date_hour = 'hour';
  static final date_minute = 'minute';
  static final date_second = 'second';
  static final date_millisecond = 'millisecond';
  static final date_microsecond = 'microsecond';

  int id;
  DateTime date;

  InventoryDate({this.date, this.id});

  Map<String, dynamic> toMap(){
    Map map = Map<String, dynamic>();
      map['id']= id;
      map['year']= date.year;
      map['month']= date.month;
      map['day']= date.day;
      map['hour']= date.hour;
      map['minute']= date.minute;
      map['second']= date.second;
      map['millisecond']= date.millisecond;
      map['microsecond']= date.microsecond;
    return map;
  }

  static fromMap(Map map) {
    InventoryDate inventoryDate = InventoryDate();
    inventoryDate.id = map['id'];
    int year = map['year'];
    int month = map['month'];
    int day = map['day'];
    int hour = map['hour'];
    int minute = map['minute'];
    int second = map['second'];
    int millisecond = map['millisecond'];
    int microsecond = map['microsecond'];
    inventoryDate.date = DateTime(year, month, day, hour, minute, second, millisecond, microsecond);
    return inventoryDate;
  }
}