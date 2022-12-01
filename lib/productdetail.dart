import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/home/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'common_things.dart';
import 'db/cart_db.dart';
import 'model/cart_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

var product;
getpdata(item) {
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
        persistentFooterButtons: cartinit ? [viewincart()]: null,
        bottomNavigationBar:Container(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              addToCart(context, product.id);
              cartinit = true;
              setState(() {
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
            child: const Text("Add To Cart"),
            //   ),
            // ],
          ),
        ) ,
        appBar: gethomeappbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://picsum.photos/id/1060/536/354.jpg?blur=5",
                        scale: 4),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(
                          0, MediaQuery.of(context).size.height * 0.30, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        product.image,
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(

                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                ),
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * -0.15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(product.category),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Capacity",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("330ml"),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left:  MediaQuery.of(context).size.width * 0.2,
                  right:  MediaQuery.of(context).size.width * 0.2,
                ),
                transform: Matrix4.translationValues(
                    0, MediaQuery.of(context).size.height * -0.12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Calories",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("40cals / 100gms", maxLines: 2),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Placeholder",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("temp"),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                    transform: Matrix4.translationValues(
                        0, MediaQuery.of(context).size.height * -0.07, 0),
                    child: Text(
                      product.title,
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              Container(
                transform: Matrix4.translationValues(
                    -15, MediaQuery.of(context).size.height * -0.05, 0),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                  Text("\$"+
                  product.price,
                  style: TextStyle(fontSize: 30),
                ),
                      Container(
                        transform: Matrix4.translationValues(MediaQuery.of(context).size.width * 0.45, 0, 0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.solid,
                                  blurRadius: 20,
                                  color: Colors.grey, //New
                                  offset: Offset(0, 0))
                            ],
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.favorite_border,color: Colors.white,),
                          )
                      ),
                      SizedBox(width:  MediaQuery.of(context).size.width * 0.02,),
                      Container(
                          transform: Matrix4.translationValues(MediaQuery.of(context).size.width * 0.1, 0, 0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.solid,
                                blurRadius: 20,
                                color: Colors.grey, //New
                                offset: Offset(0, 0))
                          ],
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child:Icon(Icons.share,color: Colors.white,),))
                ]),
              ),
              Container(
                transform: Matrix4.translationValues(
                    20, MediaQuery.of(context).size.height * -0.03, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                    Container(
                           child: Text(
                          product.description,
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
