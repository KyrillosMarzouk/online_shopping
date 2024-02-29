
import 'offer.dart';

class Product{
  int id;
  String image;
  String title;
  double price;
  Offer? offer;
  String uom;
  int catId;

  Product(this.id, this.image, this.title, this.price, this.offer, this.uom,
      this.catId);
}