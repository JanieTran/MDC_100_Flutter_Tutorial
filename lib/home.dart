// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:Shrine/supplemental/asymmetric_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
//    return Scaffold(
//      appBar: AppBar(
//        // Status bar text color to black
//        brightness: Brightness.light,
//        // Menu button
//        leading: IconButton(
//          icon: Icon(Icons.menu),
//          onPressed: () { print('Menu button'); },
//        ),
//        // App title
//        title: Text('SHRINE'),
//        // Action buttons
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () { print('Search button'); },
//          ),
//          IconButton(
//            icon: Icon(Icons.tune),
//            onPressed: () { print('Filter button'); },
//          )
//        ],
//      ),
//      // Grid view
//      body: AsymmetricView(
//        products: ProductsRepository.loadProducts(Category.all),
//      ),
//      // Ensure keyboard not altering sizing
////      resizeToAvoidBottomInset: false,
//    );
    return  AsymmetricView(
      products: ProductsRepository.loadProducts(Category.all),
    );
  }

  // Collection of cards
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }
    
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );
    
    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
          // Amount of shadow
          elevation: 0.0,
        child: Column(
          // Align items at the center of card
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  // Image span across width of box
                  fit: BoxFit.fitWidth,
                )
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 18.0),
                child: Column(
                  // Align labels to the bottom of scrolling axis
                  mainAxisAlignment: MainAxisAlignment.end,
                  // Align labels at center of non-scrolling axis
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      // Text break at soft line breaks
                      softWrap: false,
                      // Truncate overflowing text, denoting ...
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    )
                  ],
                ),
              )
            )
          ]
        )
      );
    }).toList();
  }
}
