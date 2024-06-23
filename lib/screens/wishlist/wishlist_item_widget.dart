import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../generated/l10n.dart';
import '../../models/index.dart' show Product;
import '../../models/posts/article_model.dart';
import '../../services/service_config.dart';
import '../../services/services.dart';
import '../../widgets/common/flux_image.dart';
import '../../widgets/product/action_button_mixin.dart';
import '../../widgets/product/dialog_add_to_cart.dart';
import '../../widgets/product/widgets/pricing.dart';

class WishlistItem extends StatelessWidget with ActionButtonMixin {
  const WishlistItem({required this.product, this.onAddToCart, this.onRemove});

  final Article product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(children: [
          InkWell(
           // onTap: () => onTapProduct(context, product: product),
            child: Row(
              key: ValueKey(product.id),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: onRemove,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: FluxImage(
                                imageUrl: product.mrssThumbnail
                                ,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.sanitizedTitle ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                  ),
                                  const SizedBox(height: 7),
                                 /* ProductPricing(
                                    product: product.date.toString(),
                                    hide: false,
                                    priceTextStyle: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  )*/
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(color: kGrey200, height: 1),
          const SizedBox(height: 10.0),
        ]);
      },
    );
  }
}
