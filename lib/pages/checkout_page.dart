import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _emailController = TextEditingController();
  final _cardController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Récapitulatif du Panier', style: textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Votre panier est vide',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return _CartItemCard(item: item);
                    },
                  ),
                ),
                // Floating Action Button for menu
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      // Show menu
                    },
                    child: const Icon(Icons.menu),
                  ),
                ),
                // Price Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _PriceRow(
                        label: 'Sous-total',
                        value: cartProvider.subtotal,
                        textTheme: textTheme,
                      ),
                      _PriceRow(
                        label: 'Frais de livraison',
                        value: cartProvider.deliveryFee,
                        textTheme: textTheme,
                      ),
                      _PriceRow(
                        label: 'Taxes',
                        value: cartProvider.taxes,
                        textTheme: textTheme,
                      ),
                      const Divider(height: 24),
                      _PriceRow(
                        label: 'Total',
                        value: cartProvider.total,
                        textTheme: textTheme,
                        isBold: true,
                      ),
                      const SizedBox(height: 16),
                      // Email input
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      // Card number input
                      TextField(
                        controller: _cardController,
                        decoration: InputDecoration(
                          labelText: 'Numéro de carte (simulation)',
                          prefixIcon: const Icon(Icons.credit_card),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Payment button
                      FilledButton(
                        onPressed: () {
                          _processPayment(context, cartProvider);
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Payer ${cartProvider.total.toStringAsFixed(2)}DT',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _processPayment(BuildContext context, CartProvider cartProvider) {
    if (_emailController.text.isEmpty || _cardController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Simulate payment
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
          size: 48,
        ),
        title: const Text('Paiement réussi'),
        content: Text(
          'Montant: ${cartProvider.total.toStringAsFixed(2)}DT\nEmail: ${_emailController.text}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              cartProvider.clearCart();
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to products
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final dynamic item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Three dots menu
            IconButton(
              icon: const Icon(Icons.more_vert),
              iconSize: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                // Show item options
              },
            ),
            const SizedBox(width: 8),
            // Product Image
            Container(
              width: 60,
              height: 75,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  item.product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.phone_android,
                      size: 36,
                      color: colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.product.price.toStringAsFixed(2)}DT',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  iconSize: 20,
                  onPressed: () {
                    cartProvider.decrementQuantity(item.product.id);
                  },
                ),
                Text(
                  '${item.quantity}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 20,
                  onPressed: () {
                    cartProvider.incrementQuantity(item.product.id);
                  },
                ),
              ],
            ),
            const SizedBox(width: 8),
            // Total price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.totalPrice.toStringAsFixed(2)}DT',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  iconSize: 20,
                  onPressed: () {
                    cartProvider.removeFromCart(item.product.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final TextTheme textTheme;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    required this.textTheme,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                : textTheme.bodyMedium,
          ),
          Text(
            '${value.toStringAsFixed(2)}DT',
            style: isBold
                ? textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                : textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
