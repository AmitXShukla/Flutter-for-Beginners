class Item {
  final String submenu_id;
  final String menu_id;
  final String menu_type;
  final String submenu_name;
  final String description;
  final String tooltip;
  final String image;
  final String recipe;
  final String review;
  final double price;

  const Item(
      {this.submenu_id,
      this.menu_id,
      this.menu_type,
      this.submenu_name,
      this.description,
      this.tooltip,
      this.image,
      this.recipe,
      this.review,
      this.price
      });
  
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        submenu_id: json['submenu_id'],
        menu_id: json['menu_id'],
        menu_type: json['menu_type'],
        submenu_name: json['submenu_name'],
        description: json['description'],
        tooltip: json['tooltip'],
        image: json['image'],
        recipe: json['recipe'],
        review: json['review'],
        price: json['price']);
  }
}

class MenuItems {
    final List<Item> items;
    const MenuItems({this.items});

factory MenuItems.fromJson(List<dynamic> json) {
  List<Item> items = new List<Item>(); 
  return new MenuItems(items: items);
}
  }

class FoodMenu {
  final String menu_id;
  final String menu_type;
  final String description;
  final String tooltip;
  final String image;

  const FoodMenu(
      {this.menu_id,
      this.menu_type,
      this.description,
      this.tooltip,
      this.image});

  factory FoodMenu.fromJson(Map<String, dynamic> json) {
    return FoodMenu(
        menu_id: json['menu_id'],
        menu_type: json['menu_type'],
        description: json['description'],
        tooltip: json['tooltip'],
        image: json['image']);
  }
}
class Order {
  final List<Item> orderdata;
  final String orderstatus;
  final DateTime orderdttm;

  const Order({
    this.orderdata,
    this.orderstatus,
    this.orderdttm
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderdata: json['orderdata'],
        orderstatus: json['orderstatus'],
        orderdttm: json['orderdttm']);
  }
}