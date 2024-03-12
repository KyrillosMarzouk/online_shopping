import 'order_item.dart';

class Order{
  final String id;
  final String status;
  final List<OrderItem> items;

  Order(this.id, this.status, this.items);
}