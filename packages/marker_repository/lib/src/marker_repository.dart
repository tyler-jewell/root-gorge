import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:marker_repository/src/models/marker.dart';

/// A class that represents a [FirestoreException] when working with Firestore.
class FirestoreException implements Exception {
  /// [FirestoreException]
  const FirestoreException([this.code = 'Unknown Firestore Error Occured']);

  /// Return the [FirestoreException] translated errors.
  factory FirestoreException.fromCode(String code) {
    switch (code) {
      case 'invalid-argument':
        return const FirestoreException(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const FirestoreException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const FirestoreException(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const FirestoreException(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const FirestoreException(
          'Please enter a stronger password.',
        );
      default:
        return const FirestoreException();
    }
  }

  /// The [FirestoreException] error code.
  final String code;

  @override
  String toString() {
    return code;
  }
}

///  Marker Repository
class MarkerRepository {
  /// The collection reference for the todos
  CollectionReference<Marker> markersCollection =
      FirebaseFirestore.instance.collection('markers').withConverter<Marker>(
            fromFirestore: (snapshot, _) => Marker.fromJson(snapshot.data()!),
            toFirestore: (marker, _) => marker.toJson(),
          );

  /// Add a new [Marker] to the repository
  Future<void> addNewMarker(Marker marker) async {
    try {
      await markersCollection.add(marker);
    } catch (e, s) {
      if (kDebugMode) {
        print('Error adding new marker: $e');
      }
      throw FirestoreException.fromCode(e.toString());
    }
  }

  /// Delete a [Marker] from the repository
  Future<void> deleteMarker(Marker marker) async {
    await markersCollection.doc(marker.id).delete();
  }

  /// Get all [Marker] stream from the repository
  Stream<List<Marker>> markerStream() {
    return markersCollection.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  /// Get all [Marker]s from the repository
  Future<List<Marker>> markers() {
    return markersCollection.get().then(
      (snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
    );
  }

  /// Update a [Marker] from the repository
  Future<void> updateMarker(Marker marker) async {
    await markersCollection.doc(marker.id).update(marker.toJson());
  }
}
