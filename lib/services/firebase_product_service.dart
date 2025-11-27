import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/firebase_models.dart';

class FirebaseProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<FirebaseProduct>> getProductsStream() {
    return _firestore
        .collection('products')
        .where('stock', isGreaterThan: 0)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FirebaseProduct.fromFirestore(doc))
            .toList());
  }

  Future<void> updateProductStock(String productId, int newStock) async {
    await _firestore
        .collection('products')
        .doc(productId)
        .update({'stock': newStock});
  }

  Future<FirebaseProduct?> getProduct(String productId) async {
    final doc = await _firestore.collection('products').doc(productId).get();
    return doc.exists ? FirebaseProduct.fromFirestore(doc) : null;
  }

  Future<void> decrementStock(String productId, int quantitySold) async {
    final productDoc =
        await _firestore.collection('products').doc(productId).get();
    if (productDoc.exists) {
      final currentStock = (productDoc.data()!['stock'] ?? 0) as int;
      await _firestore.collection('products').doc(productId).update({
        'stock': currentStock - quantitySold,
      });
    }
  }
}
