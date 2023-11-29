import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';

import '../../../util/common_widgets/common_appbar.dart';
import '../../../util/common_widgets/common_widgets.dart';

class LiveLocation extends StatefulWidget {
  static const screenName = "LiveLocation";

  const LiveLocation({Key? key}) : super(key: key);

  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    IronSource.hideBanner();
    super.initState();
  }

  @override
  void dispose() {
    IronSource.displayBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
        child: Column(
      children: [
        verticalSpace(10),
        commonAppBar(heading: "Live Location"),
        Expanded(
          child: roundedContainer(
            borderRadiusWhole: BorderRadius.circular(13)
                .copyWith(bottomRight: Radius.zero, bottomLeft: Radius.zero),
            // padding: const EdgeInsets.all(25)
            //     .copyWith(bottom: 0, left: 15, right: 15),
            margin: const EdgeInsets.all(10).copyWith(bottom: 0),
            width: width,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              // mapType: MapType.hybrid,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                print("Hello Map");
                _controller.complete(controller);
              },
            )
          ),
        ),
      ],
    ));
  }
}
