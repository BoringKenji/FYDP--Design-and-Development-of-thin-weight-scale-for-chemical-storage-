import 'package:flutter/material.dart';
import 'package:fydp_app/presentation/constants.dart';
import '../../details/chemicals_details.dart';

class Recommand_chemicals extends StatelessWidget {
  Recommand_chemicals({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Expanded(
        child: Row(
          children: [
            RecommendPlantCard(
              image: "assets/images/Green_test_tube.png",
              title: "H2O",
              country: "Hong Kong",
              precentage: 60,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chemicals_Details(
                        id: 1,
                        name: "H2O",
                        brand: "Scharlau",
                        cas: "7732-18-5",
                        purchasedate: "NA",
                      ),
                    ));
              },
            ),
            RecommendPlantCard(
              image: "assets/images/Orange_testtube.png",
              title: "HCl",
              country: "Russia",
              precentage: 75,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chemicals_Details(
                        id: 2,
                        name: "HCl",
                        brand: "Scharlau",
                        cas: "7647-01-0",
                        purchasedate: "NA",
                      ),
                    ));
              },
            ),
            RecommendPlantCard(
              image: "assets/images/pink_testtube.png",
              title: "NaCl",
              country: "Brazil",
              precentage: 100,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Chemicals_Details(
                        id: 3,
                        name: "Nacl",
                        brand: "Scharlau",
                        cas: "7647-14-5",
                        purchasedate: "NA",
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendPlantCard extends StatelessWidget {
  const RecommendPlantCard({
    Key? key,
    required this.country,
    required this.title,
    required this.image,
    required this.precentage,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int precentage;
  final Function press;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding,
      ),
      width: size.width * 0.4,
      // height: size.height * 0.4,
      child: TextButton(
        onPressed: () => press(),
        child: Column(
          children: [
            Image.asset(image),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    )
                  ]),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                            text: "$country".toUpperCase(),
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.5)))
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$precentage%',
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
