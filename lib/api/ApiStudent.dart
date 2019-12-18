//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class ApiStudent{
//  final Firestore _db = Firestore.instance;
//  String path;
//  String institutionId;
//  CollectionReference ref;
//  String collectionPath;
//
//  ApiStudent(this.path) {
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
//    return ref.where('institutionId', isEqualTo: institutionId).getDocuments();
//  }
//
//  Future<QuerySnapshot> getDataCollectionByclassId(String idKelas) {
////    return ref.getDocuments() ;
//    return ref.where('idKelas', isEqualTo: idKelas).getDocuments();
//  }
//
//  Future<QuerySnapshot> getDataCollectionByPhone(String finder) async{
//    return ref.where('noHp', isGreaterThanOrEqualTo: finder).getDocuments().;
//  }
//
//  Stream<QuerySnapshot> streamDataCollection() {
//    return ref.snapshots() ;
//  }
//  Future<DocumentSnapshot> getDocumentById(String id) {
//    return ref.document().get();
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