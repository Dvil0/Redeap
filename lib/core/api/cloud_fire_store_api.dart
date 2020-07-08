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

class CloudFireStoreApiImpl implements CloudFireStoreApi {

  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference reference;

  CloudFireStoreApiImpl({this.path}) {
    reference = _db.collection( path );
  }

  @override
  Future<DocumentReference> addDocument(Map data) {
    return reference.add(data);
  }

  @override
  Future<QuerySnapshot> getDocuments( String reportCode, String unitCreate, int dateCreate) {
    return reference.getDocuments();
  }

  @override
  Future<void> removeDocument(String id ) {
    return reference.document( id ).delete();
  }

  @override
  Future<void> updateDocument(Map data, String id ) {
    return reference.document( id ).updateData( data );
  }
  
}