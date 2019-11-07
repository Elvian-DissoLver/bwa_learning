import 'package:cloud_firestore/cloud_firestore.dart';

class ApiKelases{
  final Firestore _db = Firestore.instance;
  String path;
  String userId;
  CollectionReference ref;
  String collectionPath;

  ApiKelases(this.path) {
    ref = _db.collection(path);
  }

  void setPath(String path) {
    this.path = path;
  }

  String getUserId() {
    return userId;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  void setCollectionPath(String collectionPath) {
    this.collectionPath = collectionPath;
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
//    return ref.where('userId', isEqualTo: userId).getDocuments();
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }
}