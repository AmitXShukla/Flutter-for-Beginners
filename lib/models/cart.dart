import 'dart:collection';
import 'package:flutter_web/foundation.dart';
import 'datamodel.dart';

class CartModel extends ChangeNotifier {
  
  /// Internal, private state of the cart.
  final List<Item> _items = [];
  /// Internal, private state of the Order.
  final List<Order> _orders = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  /// An unmodifiable view of the orders in the cart.
  UnmodifiableListView<Order> get orders => UnmodifiableListView(_orders);

  double get totalPrice {
    double price = 00.0;
    _items.forEach((item) => { price = price + item.price });
    return price.toDouble();
  }
  //int get totalPrice => _items.length;
  
  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void remove(Item item) {
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    //notifyListeners();
  }

  void addorders(List<Item> orderitems) {
    _orders.add(new Order(orderdata: orderitems.toList(), orderstatus: 'New Order', orderdttm: DateTime.now()));
    removeAll();
  }

  void closeorder(List<Item> items) {
    _orders.remove(items);
  }
}