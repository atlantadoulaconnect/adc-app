import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


// Returns time as 5:30 PM
String formatTimeHSS(Timestamp timestamp) {
  return new DateFormat.jm().format(timestamp.toDate());
}

// Returns date as Jul 10, 2019
String formatDateMonDDYYYY(Timestamp timestamp) {
  return new DateFormat("MMM d, yyyy").format(timestamp.toDate());
}

String formatDateMonthYYYY(DateTime date) {
  return new DateFormat("MMMM yyyy").format(date);
}

// Returns Today, Yesterday, day of the week, or Mon. DD, YYYY
// Returns Mon. DD, YYYY if timestamp is more than a week before today
String formatDateRelative(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  final DateTime now = new DateTime.now();
  final DateTime today = new DateTime(now.year, now.month, now.day);
  final DateTime yesterday = new DateTime(now.year, now.month, now.day - 1);
  final DateTime oneWeekAgo = new DateTime (now.year, now.month, now.day - 7);

  // Removes hour/minutes/seconds from the given date for comparisons
  DateTime dateDay = new DateTime(date.year, date.month, date.day);

  if (dateDay == today) {
    return "Today";
  }
  if (dateDay == yesterday) {
    return "Yesterday";
  }
  if (dateDay.compareTo(oneWeekAgo) > 0) {
    return new DateFormat.EEEE().format(date);
  }
  return new DateFormat("MMM d, yyyy").format(date);
}