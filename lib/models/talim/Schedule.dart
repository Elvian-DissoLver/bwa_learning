
class Schedule {
  int scheduleID;
  String name;
  var startDate;
  var endDate;
  var startTime;
  var endTime;
  String months;
  String days;
  String weeks;
  int companyID;
  int timeScheduleID;

  Schedule({
    this.scheduleID,
    this.name,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.months,
    this.weeks,
    this.days,
    this.companyID,
    this.timeScheduleID
  });

  Schedule.fromJson(Map<String, dynamic> map) {
    scheduleID = map['ScheduleID'];
    name = map['Name_en_us'];
    startDate = map['StartDate'];
    endDate = map['EndDate'];
    startTime = map['StartTime'];
    endTime = map['EndTime'];
    months = map['Months'];
    weeks = map['Weeks'];
    days = map['Days'];
    companyID = map['Company_id'];
    timeScheduleID = map['TimeScheduleID'];
    print('Schedule');
  }

  static bool getIsInFromInt(int value) {
    switch(value){
      case 1:
        return true;
      case 0:
        return false;
      default:
        return false;
    }
  }

  static int getIsInFromBool(bool value) {
    switch(value){
      case true:
        return 1;
      case false:
        return 0;
      default:
        return 0;
    }
  }
}
