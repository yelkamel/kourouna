import 'dart:async';

import 'package:Kourouna/pages/widgets/button/cross_button.dart';
import 'package:flutter/material.dart';
import 'package:Kourouna/@constants/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class SocialDistance extends StatefulWidget {
  @override
  _SocialDistanceState createState() => _SocialDistanceState();
}

class _SocialDistanceState extends State<SocialDistance>
    with TickerProviderStateMixin {
  Completer<GoogleMapController> _controllerMap = Completer();
  bool _show = false;
  LatLng _center = const LatLng(48.84596090011522, 2.373186598527708);

  AnimationController _controller;
  Animation<double> _animation;
  void _onMapCreated(GoogleMapController controller) {
    _controllerMap.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    Future.delayed(Duration(seconds: 4), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'distance',
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 130,
                    height: 130,
                    child: Image.asset(Images.distance),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(
                      top: 15, left: 30, right: 30, bottom: 100),
                  child: Stack(children: [
                    GoogleMap(
                      onCameraIdle: () {
                        print('onCameraIdle');
                      },
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Lottie.network(
                              "https://assets6.lottiefiles.com/packages/lf20_PnbvHJ.json"),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                title:
                                    Text("Il ne faut pas sortir de chez soi !"),
                                leading: Image.asset(Images.instructionMedical),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CrossButton(),
          )
        ]),
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
