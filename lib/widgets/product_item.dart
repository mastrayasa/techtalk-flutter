import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_talk/currency_util.dart';
import 'package:tech_talk/data/product.dart';
import 'package:tech_talk/providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              product.imageUrl,
              height: 100,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                    icon: Icon(
                      (product.isFavorite)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: product.toggleFavorite,
                  ),
                ),
                Expanded(
                  child: Text(
                    CurrencyUtil.formatToIDR(product.price),
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: FlatButton(
                color: Colors.orangeAccent,
                onPressed: () => cart.addToCart(product),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_shopping_cart, color: Colors.white),
                    Text(
                      "Add to cart",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
