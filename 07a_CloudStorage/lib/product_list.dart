// CSCI 4100U - 07a Cloud Storage

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String type;
  double cost;
  DocumentReference reference;

  Product.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.name = map['name'];
    this.type = map['type'];
    this.cost = map['cost'];
  }
}

class ProductList extends StatefulWidget {
  ProductList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildProductList(context),
      bottomNavigationBar: _buildTypeDropdown(context),
    );
  }

  Widget _buildTypeDropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: DropdownButton(
        value: _category,
        items: <String>['All', 'Storage', 'Graphics Card', 'Mobile Phone']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        onChanged: (String value) {
          setState(() {
            _category = value;
          });
          print('Selected category: $_category.');
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _category == 'All' ? Firestore.instance.collection('products').snapshots() : Firestore.instance.collection('products').where('type', isEqualTo: _category).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: snapshot.data.documents.map((data) => _buildProduct(context, data)).toList(),
        );
      },
    );
  }

  Widget _buildProduct(BuildContext context, DocumentSnapshot productData) {
    final product = Product.fromMap(productData.data, reference: productData.reference);
    return GestureDetector(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.type),
        trailing: Text(product.cost.toString()),
      ),
      onLongPress: () {
        product.reference.delete();
      },
    );
  }
}
