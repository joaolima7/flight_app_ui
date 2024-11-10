import 'package:flutter/material.dart';
import 'package:flightapp/styles/styles.dart';

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  const CityCard({
    Key? key,
    required this.imagePath,
    required this.cityName,
    required this.monthYear,
    required this.discount,
    required this.oldPrice,
    required this.newPrice,
    required String title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.black87,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: 200,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "R\$${oldPrice},00",
                          style: dropDownTextStyle.copyWith(
                            fontSize: 14.0,
                            color: Colors.white70,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "R\$${newPrice},00",
                          style: dropDownTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    cityName,
                    style: dropDownTextStyle.copyWith(
                        fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 35),
                  Text(
                    monthYear,
                    style: dropDownTextStyle.copyWith(
                        fontSize: 16.0, color: Colors.white54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
