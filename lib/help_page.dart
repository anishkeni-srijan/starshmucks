import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Need Help?",
        ),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: HexColor("#175244"),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.05),
                    BlendMode.dstATop,
                  ),
                  image: ExactAssetImage('images/shmucks.png'),
                ),
              ),
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "24/7",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Help Centre",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tell us how we can help.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: HexColor("#036635"),
                  ),
                ),
                Icon(
                  Icons.waving_hand_rounded,
                  color: HexColor("#175244"),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: AlignmentDirectional.center,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Our team of Superheros are standing by for service & support.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: HexColor("#036635"),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                elevation: 8,
                child: ExpansionTile(
                  trailing: SizedBox(
                    width: 10,
                  ),
                  iconColor: HexColor("#036635"),
                  collapsedIconColor: HexColor("#036635"),
                  title: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/chat.png",
                            width: 50,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 20, color: HexColor("#036635")),
                          ),
                        ],
                      )),
                  children: [
                    TextButton(
                      onPressed: () async {
                        final mailUrl = Uri.parse(
                            'mailto:anish.keni@srijan.net?subject=News&body=New%20plugin');
                        if (await canLaunchUrl(mailUrl)) {
                          launchUrl(mailUrl);
                        } else {
                          throw 'Could not launch $mailUrl';
                        }
                      },
                      child: Text(
                        "Write to Us",
                        style: TextStyle(color: HexColor("#036635")),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                elevation: 8,
                child: ExpansionTile(
                    trailing: SizedBox(
                      width: 10,
                    ),
                    iconColor: HexColor("#036635"),
                    collapsedIconColor: HexColor("#036635"),
                    title: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 10.0, left: 30),
                        child: Row(
                          children: [
                            Image.asset(
                              "images/faq.png",
                              width: 50,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(
                                  fontSize: 20, color: HexColor("#036635")),
                            ),
                          ],
                        )),
                    children: [
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "How to get StarShmucks app?",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "The StarShmucks app is free and available for iPhone and Android users. You can download the app by simply searching for 'StarShmucks' on the App Store or Google Play.If you ever change or lose your device, simply reinstall the StarShmucks app on your new device, log in as normal and you’re ready to go!")
                        ],
                      ),
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "Can I edit my order?",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "Your order can be edited before it reaches the restaurant. You could contact customer support team via call to do so. Once order is placed and restaurant starts preparing your food, you may not edit its contents"),
                        ],
                      ),
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "I want to cancel my order",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "We will do our best to accommodate your request if the order is not placed to the restaurant (Customer service number:  1800999999). Please note that we will have a right to charge a cancellation fee up to full order value to compensate our restaurant and delivery partners if your order has been confirmed.")
                        ],
                      ),
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "Do you charge for delivery?",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "Delivery fee varies from city to city and is applicable if order value is below a certain amount. Delivery fee (if any) is specified on the 'Review Order' page. ")
                        ],
                      ),
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "How long do you take to deliver?",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "Standard delivery times vary by the location selected and prevailing conditions. Once you select your location, an estimated delivery time is mentioned for each outlet.")
                        ],
                      ),
                      ExpansionTile(
                        childrenPadding:
                            EdgeInsets.only(left: 15, bottom: 10, right: 15),
                        iconColor: HexColor("#036635"),
                        collapsedIconColor: HexColor("#036635"),
                        expandedAlignment: Alignment.topLeft,
                        title: Text(
                          "Can I order in advance?",
                          style: TextStyle(color: HexColor("#036635")),
                        ),
                        children: [
                          Text(
                              "We currently do not support this functionality. All our orders are placed and executed on-demand.")
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                elevation: 8,
                child: ExpansionTile(
                  trailing: SizedBox(
                    width: 10,
                  ),
                  iconColor: HexColor("#036635"),
                  collapsedIconColor: HexColor("#036635"),
                  title: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/call.png",
                            width: 50,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Call Us',
                            style: TextStyle(
                                fontSize: 20, color: HexColor("#036635")),
                          ),
                        ],
                      )),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call_outlined,
                            size: 25,
                            color: HexColor("#036635"),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final call = Uri.parse('tel:1800999999');
                            if (await canLaunchUrl(call)) {
                              launchUrl(call);
                            } else {
                              throw 'Could not launch $call';
                            }
                          },
                          child: Text(
                            "1800999999",
                            style: TextStyle(
                              color: HexColor("#036635"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
