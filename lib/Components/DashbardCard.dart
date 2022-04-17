import 'package:flutter/material.dart';

Widget dashboardCard(BuildContext context, String title, String image, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width*0.45,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/$image.png"),
              ),
              Text(
                title,
                softWrap: true,
                style: Theme.of(context).textTheme.headline6.merge(TextStyle(fontWeight: FontWeight.bold))
              ),
            ],
          ),
        ),
      ),
    ),
  );
}