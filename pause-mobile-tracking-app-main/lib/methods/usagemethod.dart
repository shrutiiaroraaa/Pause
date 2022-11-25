// ignore_for_file: avoid_print

import 'package:app_usage/app_usage.dart';

class UsageMethods {
  List<AppUsageInfo> dailyInfos = [];
  List<AppUsageInfo> weeklyInfos = [];
  num totalDailyMins = 0;
  num totalDailyHours = 0;
  num totalWeeklyMins = 0;
  num totalWeeklyHours = 0;

  void sumMin() {}

  // Future getUsageStats() async {
  //   totalDailyHours = 0;
  //   totalDailyMins = 0;
  //   try {
  //     DateTime endDate = DateTime.now();
  //     DateTime startDate = endDate.subtract(const Duration(days: 7));
  //     dailyInfos = await AppUsage.getAppUsage(startDate, endDate);
  //     for (int i = 0; i < dailyInfos.length; i++)
  //     {
  //     totalDailyMins = totalDailyMins + dailyInfos[i].usage.inMinutes.toInt();
  //   }
  //   totalDailyHours = totalDailyMins / 60;
  //     return dailyInfos;
  //   } on AppUsageException catch (exception) {
  //     print(exception);
  //   }
  // }

  Future getDailyUsageStats() async {
    totalDailyHours = 0;
    totalDailyMins = 0;
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(hours: 12));
      dailyInfos = await AppUsage.getAppUsage(startDate, endDate);
      for (int i = 0; i < dailyInfos.length; i++) {
        totalDailyMins = totalDailyMins + dailyInfos[i].usage.inMinutes.toInt();
      }
      totalDailyHours = totalDailyMins / 60;
      return dailyInfos;
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  Future getWeeklyUsageStats() async {
    totalWeeklyHours = 0;
    totalWeeklyMins = 0;
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(days: 7));
      weeklyInfos = await AppUsage.getAppUsage(startDate, endDate);
      for (int i = 0; i < weeklyInfos.length; i++) {
        totalWeeklyMins =
            totalWeeklyMins + weeklyInfos[i].usage.inMinutes.toInt();
      }
      totalWeeklyHours = totalWeeklyMins / 60;
      return weeklyInfos;
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
}
