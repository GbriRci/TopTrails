import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedTrail {
  final String id;
  final String trailName;
  final int m;
  final DateTime date;

  CompletedTrail({required this.id, required this.trailName, required this.m, required this.date});

  factory CompletedTrail.fromFirestore(String id, Map<String, dynamic> data) {
    return CompletedTrail(
      id: id,
      trailName: data['trailName'] ?? '',
      m: (data['m'] as num).toInt(),
      date: (data['date'] as Timestamp?)!.toDate(),
    );
  }
}
