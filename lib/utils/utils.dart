import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final objects = snaps
                  .map((json) => fromJson(json as Map<String, dynamic>))
                  .toList();

              sink.add(objects);
            },
          );
}
