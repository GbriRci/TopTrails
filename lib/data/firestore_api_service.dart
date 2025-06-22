import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:main/domain/models/completed_trail.dart';
import 'package:main/domain/models/folder.dart';
import 'package:main/domain/models/profile.dart';

class FirestoreApiService {
  const FirestoreApiService();

  Future<void> addUser({required String userId, required String email}) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "uid": userId,
        "email": email,
        "registrationDate": Timestamp.fromDate(DateTime.now()),
      });

      //cartella di default
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("folders")
          .add({
            "name": "Trails",
            "trailsId": [],
            "imageUrl":
                "https://uvbsrcalcmbvwhdewmgm.supabase.co/storage/v1/object/public/toptrails//logo.png",
          });
    } catch (e) {
      debugPrint("Error during user insertion");
      debugPrint(e.toString());
      throw Exception("Error during user insertion");
    }
  }

  Future<void> addFolder({
    required String userId,
    required String folderName,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('folders')
          .add({
            'name': folderName,
            'trailsId': [],
            'imageUrl':
                'https://uvbsrcalcmbvwhdewmgm.supabase.co/storage/v1/object/public/toptrails//logo.png',
          });
    } catch (e) {
      debugPrint("Error during folder insertion");
      debugPrint(e.toString());
      throw Exception("Error during folder insertion");
    }
  }

  Future<void> addTrailToFolder({
    required String userId,
    required String folderId,
    required String trailId,
  }) async {
    try {
      final folderRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("folders")
          .doc(folderId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(folderRef);
        if (!snapshot.exists) {
          throw Exception("Folder does not exist");
        }

        final trailsId = List<String>.from(snapshot.data()?['trailsId'] ?? []);
        if (!trailsId.contains(trailId)) {
          trailsId.add(trailId);
          transaction.update(folderRef, {'trailsId': trailsId});
        }
      });
    } catch (e) {
      debugPrint("Error during trail insertion in folder");
      debugPrint(e.toString());
      throw Exception("Error during trail insertion in folder");
    }
  }

  Future<Profile?> getUser(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return Profile.fromFirestore(doc.id, doc.data()!);
    } else {
      debugPrint("profofile not found");
      return null;
    }
  }

  Future<List<CompletedTrail>> getCompletedTrails(String userId) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('completed_trails')
            .get();

    return snapshot.docs
        .map((doc) => CompletedTrail.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<List<Folder>> getFolders(String userId) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('folders')
            .get();

    return snapshot.docs
        .map((doc) => Folder.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<void> addCompletedTrail({
    required String userId,
    required String trailName,
    required int m,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('completed_trails')
        .add({
          'trailName': trailName,
          'm': m,
          'date': Timestamp.fromDate(DateTime.now()),
        });
  }

  Future<void> deleteTrailFromFolder({
    required String userId,
    required String folderId,
    required String trailId,
  }) async {
    try {
      final folderRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("folders")
          .doc(folderId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(folderRef);
        final trailsId = List<String>.from(snapshot.data()?['trailsId'] ?? []);
        if (trailsId.contains(trailId)) {
          trailsId.remove(trailId);
          transaction.update(folderRef, {'trailsId': trailsId});
        }
      });
    } catch (e) {
      debugPrint("Error during trail deletion from folder");
      debugPrint(e.toString());
      throw Exception("Error during trail deletion from folder");
    }
  }

  Future<void> deleteFolder({
    required String userId,
    required String folderId,
  }) async {
    try {
      final folderRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("folders")
          .doc(folderId);

      await folderRef.delete();
    } catch (e) {
      debugPrint("Error during folder deletion");
      debugPrint(e.toString());
      throw Exception("Error during folder deletion");
    }
  }

  Future<void> updateFolder({
    required String userId,
    required String folderId,
    String? newName,
    String? newImageUrl,
  }) async {
    try {
      final folderRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("folders")
          .doc(folderId);

      final Map<String, dynamic> updateData = {};
      if (newName != null) updateData['name'] = newName;
      if (newImageUrl != null) updateData['imageUrl'] = newImageUrl;

      if (updateData.isNotEmpty) {
        await folderRef.update(updateData);
      }
    } catch (e) {
      debugPrint("Error during folder update");
      debugPrint(e.toString());
      throw Exception("Error during folder update");
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection("users")
          .doc(userId);

      //cartelle
      final folders = await userRef.collection("folders").get();
      for (final doc in folders.docs) {
        await doc.reference.delete();
      }

      //percorsi completati
      final completed = await userRef.collection("completed_trails").get();
      for (final doc in completed.docs) {
        await doc.reference.delete();
      }

      //utente
      await userRef.delete();
    } catch (e) {
      debugPrint("Error during user deletion");
      debugPrint(e.toString());
      throw Exception("Error during user deletion");
    }
  }
}
