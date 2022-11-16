import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_things.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Help Center",
          style: TextStyle(color: HexColor("#036635")),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      print("CALLING");
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
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final mailUrl = Uri.parse(
                        'mailto:smith@example.org?subject=News&body=New%20plugin');
                    if (await canLaunchUrl(mailUrl)) {
                      print("CALLING");
                      launchUrl(mailUrl);
                    } else {
                      throw 'Could not launch $mailUrl';
                    }
                  },
                  child: Text("Write to Us"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: HexColor("#036635")),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: HexColor("#036635"),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "What is Lorem Ipsum?",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Where does it come from?",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Why do we use it?",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Where can I get some?",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "The standard Lorem Ipsum passage, used since the 1500s",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
              ],
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              iconColor: HexColor("#036635"),
              collapsedIconColor: HexColor("#036635"),
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Section 1.10.32 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC",
                style: TextStyle(color: HexColor("#036635")),
              ),
              children: [
                Text(
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
