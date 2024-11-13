import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';

import '../../../util/common_widgets/common_appbar.dart';
import '../../../util/common_widgets/common_widgets.dart';

class LiveLocation extends StatefulWidget {
  static const screenName = "LiveLocation";

  const LiveLocation({Key? key, required this.lat, required this.long}) : super(key: key);

  final double lat;
  final double long;



  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    print("LiveLocation::::${widget.lat}::::${widget.long}");
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
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.long),
                zoom: 14.4746,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(widget.lat, widget.long)
                ),
              },
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
