import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final int id;
  final String name;
  final double price;
  final Color color;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'color': color.toARGB32(),
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    color: Color(json['color']),
    quantity: json['quantity'] ?? 1,
  );
}

class CartProvider extends ChangeNotifier {
  static const String _key = 'prince_baby_cart';
  List<CartItem> _items = [];
  bool _isOpen = false;
  SharedPreferences? _prefs; // كاش للتفضيلات

  List<CartItem> get items => _items;
  bool get isOpen => _isOpen;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  CartProvider() {
    _loadCart();
  }

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> _loadCart() async {
    final prefs = await _preferences;
    final data = prefs.getString(_key);
    if (data != null) {
      final List<dynamic> list = jsonDecode(data);
      _items = list.map((e) => CartItem.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await _preferences;
    await prefs.setString(
      _key,
      jsonEncode(_items.map((e) => e.toJson()).toList()),
    );
  }

  void setIsOpen(bool open) {
    _isOpen = open;
    notifyListeners();
  }

  void addItem({
    required int id,
    required String name,
    required double price,
    required Color color,
  }) {
    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(id: id, name: name, price: price, color: color));
    }
    notifyListeners();
    _saveCart();
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveCart();
  }

  void updateQuantity(int id, int quantity) {
    if (quantity < 1) {
      removeItem(id);
      return;
    }
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
      _saveCart();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart();
  }
}
