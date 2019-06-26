import 'package:flutter_web/material.dart';
import 'package:myfoodrestaurant/provider/provider.dart';
import 'package:myfoodrestaurant/models/cart.dart';
import 'package:myfoodrestaurant/models/datamodel.dart';
import 'package:myfoodrestaurant/shared/custom.style.dart';

class ShopCart extends StatelessWidget {
  static const routeName = '/shopcart';

  final Item item;
  const ShopCart({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    _updateCart(order) async {
      var x = await cart.addorders(order);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Row(
            children: <Widget>[
              Text("Total: USD \$ ${cart.totalPrice.toString()}"),
              SizedBox(width: 15.0),
              Icon(Icons.payment, color: Colors.redAccent, size: 30.0),
            ],
          )),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed:
                  cart.items.isEmpty ? null : () => _updateCart(cart.items),
                  //       onPressed: cart.orders.isEmpty ? null : () => cart.closeorder(cart.orders),
              splashColor: cart.items.isEmpty
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorLight,
              child: Text('Order Now'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemExtent: 125,
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, cart.items[index]),
                ),
              ),
            ),
            Container(height: 4, color: Colors.black)
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(context, Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(item.image, width: 80, height: 80),
        title:
            Text(item.menu_type, style: Theme.of(context).textTheme.headline),
        subtitle: Row(
          children: <Widget>[
            Text(item.submenu_name),
            SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            Text('USD \$', style: cHeaderDarkText),
            Text(item.price.toString(), style: cHeaderDarkText),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
