import 'package:flutter_web/material.dart';
import 'package:myfoodrestaurant/provider/provider.dart';
import 'package:myfoodrestaurant/models/cart.dart';
import 'package:myfoodrestaurant/models/datamodel.dart';
import 'package:myfoodrestaurant/shared/custom.style.dart';

class Orders extends StatelessWidget {
  static const routeName = '/orders';

  final Item item;
  const Orders({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Row(
            children: <Widget>[
              Text("Orders"),
              SizedBox(width: 15.0),
              Icon(Icons.check_circle, color: Colors.redAccent, size: 30.0),
            ],
          )),
      body: Center(
        child: Column(
          children: [
            //Text("Total: USD \$ ${cart.totalPrice.toString()}", style: cHeaderDarkText),
//             RaisedButton(
//               // TODO: change cart.add to cart.order(orders) and cart.flush all orders
//       onPressed: cart.orders.isEmpty ? null : () => cart.closeorder(cart.orders),
//         //cart.add(item),
//       splashColor: cart.orders.isEmpty ? Theme.of(context).primaryColor: Theme.of(context).primaryColorLight,
//       child: Text('Order Closed'),
// ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemExtent: 125,
                  itemCount: cart.orders.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, cart.orders[index]),
                ),
              ),
            ),
            Container(height: 4, color: Colors.black)
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(context, Order order) {
    String menuData = "";
    getStringData(String d) {
      menuData = menuData + ", " + d.toString();
    }

    order.orderdata.forEach((f) => getStringData(f.submenu_name));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(order.orderdttm.toString(),
            style: Theme.of(context).textTheme.headline),
        subtitle: Row(children: <Widget>[
          Text(order.orderstatus),
          SizedBox(
            width: 20.0,
            height: 20.0,
          ),
          Text("# of Items: ${order.orderdata.length.toString()}",
              style: cHeaderDarkText),
          Text(menuData, style: cHeaderDarkText),
        ]),
      ),
    );
  }
}
