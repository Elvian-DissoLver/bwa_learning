//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class ApiKelases{
//  final Firestore _db = Firestore.instance;
//  String path;
//  String institutionId;
//  CollectionReference ref;
//  String collectionPath;
//
//  ApiKelases(this.path) {
//    ref = _db.collection(path);
//  }
//
//  void setPath(String path) {
//    this.path = path;
//  }
//
//  String getinstitutionId() {
//    return institutionId;
//  }
//
//  void setinstitutionId(String institutionId) {
//    this.institutionId = institutionId;
//  }
//
//  void setCollectionPath(String collectionPath) {
//    this.collectionPath = collectionPath;
//  }
//
//  Future<QuerySnapshot> getDataCollection() {
////    return ref.getDocuments() ;
//    return ref.where('institutionId', isEqualTo: institutionId).getDocuments();
//  }
//
//  Future<QuerySnapshot> getDataCollectionByName(String className) {
////    return ref.getDocuments() ;
//    return ref.where('className', isEqualTo: className).getDocuments();
//  }
//
//  Stream<QuerySnapshot> streamDataCollection() {
//    return ref.snapshots() ;
//  }
//  Future<DocumentSnapshot> getDocumentById(String id) {
//    return ref.document(id).get();
//  }
//  Future<void> removeDocument(String id){
//    return ref.document(id).delete();
//  }
//  Future<DocumentReference> addDocument(Map data) {
//    return ref.add(data);
//  }
//  Future<void> updateDocument(Map data , String id) {
//    return ref.document(id).updateData(data) ;
//  }
//}