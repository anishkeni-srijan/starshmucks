import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/home/home_screen.dart';
import 'common_things.dart';
import 'db/cart_db.dart';
import 'model/cart_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}
var product;
getpdata(item){
 product = item;
}
class _ProductDetailState extends State<ProductDetail> {
  addToCart(context, prod) async {
    CartDB cdb = CartDB();
    MenuDB db = MenuDB();
    final cartp = await db.Offersdata();
    cdb.insertDataCart(
      CartModel(id: prod, qty: 1),
    );
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: gethomeappbar(),
          body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  product.image,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.52,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.52,
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(product.title)),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(product.description)),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      AutoSizeText("\$" + product.price),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.52,
                      ),
                      ElevatedButton(onPressed: () {
                        addToCart(context,product.id);
                        cartinit = true;
                        setState(() {});
                      }, child: Text('Add')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

    }


}
