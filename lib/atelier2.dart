import 'package:flutter/material.dart';

// Modèle de données
class Product {
  final String name;
  final double price;
  final String image;
  final bool isNew;
  final double rating;
  final String description;
  final Map<String, String> specifications;

  const Product(
    this.name,
    this.price,
    this.image, {
    this.isNew = false,
    this.rating = 0.0,
    this.description = '',
    this.specifications = const {},
  });
}

// Modèle pour les items du panier
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ProductListPageM3 extends StatefulWidget {
  const ProductListPageM3({super.key});

  @override
  State<ProductListPageM3> createState() => _ProductListPageM3State();
}

class _ProductListPageM3State extends State<ProductListPageM3> {
  final List<CartItem> _cartItems = [];

  final List<Product> products = const [
    Product(
      'iPhone 15',
      999,
      'images/iphone-15.jpg',
      isNew: true,
      rating: 4.5,
      description:
          'Découvrez le iPhone 15, un produit haute performance conçu pour répondre à tous vos besoins. Design élégant et fonctionnalités avancées pour une expérience exceptionnelle.',
      specifications: {
        'Écran': '6.1 pouces Super Retina XDR',
        'Processeur': 'A16 Bionic',
        'Mémoire': '128 GB',
        'Batterie': 'Jusqu à 20h de vidéo',
      },
    ),
    Product(
      'Samsung Galaxy',
      799,
      'images/samsung.jpg',
      isNew: false,
      rating: 4.2,
      description:
          'Le Samsung Galaxy offre une expérience Android premium avec un écran AMOLED vibrant et des performances exceptionnelles.',
      specifications: {
        'Écran': '6.4 pouces AMOLED',
        'Processeur': 'Snapdragon 8 Gen 2',
        'Mémoire': '256 GB',
        'Batterie': 'Jusqu à 24h de vidéo',
      },
    ),
    Product(
      'Google Pixel',
      699,
      'images/google.jpg',
      isNew: true,
      rating: 4.7,
      description:
          'Google Pixel combine l intelligence artificielle avancée avec une photographie exceptionnelle pour capturer vos moments préférés.',
      specifications: {
        'Écran': '6.2 pouces OLED',
        'Processeur': 'Google Tensor G3',
        'Mémoire': '128 GB',
        'Batterie': 'Jusqu à 24h d autonomie',
      },
    ),
  ];

  void _addToCart(Product product) {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item.product.name == product.name,
      );

      if (existingItemIndex >= 0) {
        _cartItems[existingItemIndex].quantity++;
      } else {
        _cartItems.add(CartItem(product: product, quantity: 1));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ajouté au panier'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCartDialog() {
    final totalPrice = _cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    final totalItems =
        _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Récapitulatif Panier'),
        content: _cartItems.isEmpty
            ? const Text('Votre panier est vide')
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Articles: $totalItems',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: ${totalPrice.toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(height: 24),
                    ..._cartItems.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item.product.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${item.product.price.toStringAsFixed(2)}€',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'x${item.quantity}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final totalItems =
        _cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Produits'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _showCartDialog,
              ),
              if (totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      totalItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ExpandableProductCard(
            product: product,
            onAddToCart: () => _addToCart(product),
          );
        },
      ),
    );
  }
}

// Widget pour une carte produit expansible
class ExpandableProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ExpandableProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ExpandableProductCard> createState() => _ExpandableProductCardState();
}

class _ExpandableProductCardState extends State<ExpandableProductCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // En-tête de la carte (toujours visible)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Image du produit
                  Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(widget.product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (widget.product.isNew)
                        Positioned(
                          top: 2,
                          left: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  // Info produit
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.product.rating.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            Text(
                              '${widget.product.price.toStringAsFixed(2)}€',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bouton panier
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: colorScheme.primary,
                    ),
                    onPressed: widget.onAddToCart,
                  ),

                  // Flèche d'expansion
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          // Contenu expansible
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Spécifications
                  Text(
                    'Spécifications',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.product.specifications.entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: TextStyle(
                                        color: colorScheme.onSurfaceVariant),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
