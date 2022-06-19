import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).primaryColor
            ],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: 1,
          duration: Duration(milliseconds: 1200),
          child: Center(
            child: Container(
              height: 140.0,
              width: 140.0,
              child: Center(
                child: ClipOval(
                    child: Image(
                  image: AssetImage("asset/images/mh.png"),
                )),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
