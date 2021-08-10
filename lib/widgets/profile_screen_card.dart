import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

class ProfileScreenCard extends StatelessWidget {
  late final Widget message;
  final Widget? otherMessage;

  ProfileScreenCard({required this.message, this.otherMessage});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      radius: 15,
      borderRadius: BorderRadius.circular(30),
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Card(
          color: kBlackGrey,
          child: otherMessage == null
              ? Center(child: message)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    otherMessage!,
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: message,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
