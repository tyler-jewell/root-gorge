import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marker_repository/src/models/marker.dart';

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
    await markersCollection.add(marker);
  }

  /// Delete a [Marker] from the repository
  Future<void> deleteMarker(Marker marker) async {
    await markersCollection.doc(marker.id).delete();
  }

  /// Get all [Marker]s from the repository
  Stream<List<Marker>> markers() {
    return markersCollection.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  /// Update a [Marker] from the repository
  Future<void> updateMarker(Marker marker) async {
    await markersCollection.doc(marker.id).update(marker.toJson());
  }
}
