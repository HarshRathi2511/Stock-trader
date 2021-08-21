import 'package:flutter/material.dart';
import 'package:stock_trader/constants.dart';

class ProfileScreenCard extends StatelessWidget {
  late final Widget message;
  final Widget? otherMessage;

  ProfileScreenCard({required this.message, this.otherMessage});
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: kBlackGrey,
      color: Colors.black,
      child: otherMessage == null
          ? InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                child: Center(
                  child: message,
                ),
              ),
            )
          : Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: message,
                  ),
                  Spacer(),
                  otherMessage!,
                ],
              ),
            ),
    );
  }
}
