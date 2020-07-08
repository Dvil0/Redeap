import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CloudFireStoreApi {

  /// Return list of documents selected.
  Future<QuerySnapshot> getDocuments( String reportCode, String unitCreate, int dateCreate );

  /// Remove document selected.
  Future<void> removeDocument( String id );

  /// Add document selected.
  Future<DocumentReference> addDocument( Map data );

  /// Update document selected.
  Future<void> updateDocument( Map data, String id );
}