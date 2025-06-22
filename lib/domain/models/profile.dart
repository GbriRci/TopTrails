import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String userId;
  final String email;
  final DateTime registrationDate;

  Profile({
    required this.userId,
    required this.email,
    required this.registrationDate,
  });

  //Il metodo factory serve per creare un'istanza di profofile da un documento Firestor
  factory Profile.fromFirestore(String uid, Map<String, dynamic> data) {
    return Profile(
      userId: uid,
      email: data['email'] ?? '',
      registrationDate: (data['registrationDate'] as Timestamp).toDate(),
    );
  }
  
  @override
  String toString() {
    return "User(uid: $userId, email: $email, registrationDate: $registrationDate";
  }
}