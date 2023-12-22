import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_MapViewController
    extends MPFlutter_Wechat_PlatformViewController {
  MapContext? _mapContext;

  _createMapContext() {
    if (_mapContext == null) {
      if (pvid != null) {
        _mapContext = wx.createMapContext(pvid!);
      }
    }
  }

  MapContext? getMapContext() {
    _createMapContext();
    return _mapContext;
  }
}

class MPFlutter_Wechat_MapView extends StatelessWidget {
  final MPFlutter_Wechat_MapViewController? controller;
  final double longitude;
  final double latitude;
  final double scale;
  final double minScale;
  final double maxScale;
  final List<Marker> markers;
  final List<Cover> covers;
  final List<Polyline> polyline;
  final List<Circle> circles;
  final List<Control> controls;
  final List<Point> includePoints;
  final bool showLocation;
  final List<Polygon> polygons;
  final String subkey;
  final int layerStyle;
  final double rotate;
  final double skew;
  final bool enable3D;
  final bool showCompass;
  final bool showScale;
  final bool enableOverlooking;
  final bool enableAutoMaxOverlooking;
  final bool enableZoom;
  final bool enableScroll;
  final bool enableRotate;
  final bool enableSatellite;
  final bool enableTraffic;
  final bool enablePOI;
  final bool enableBuilding;
  final Map<String, dynamic> setting;
  final Function(mpjs.JSObject)? onTap;
  final Function(mpjs.JSObject)? onMarkerTap;
  final Function(mpjs.JSObject)? onLabelTap;
  final Function(mpjs.JSObject)? onControlTap;
  final Function(mpjs.JSObject)? onCalloutTap;
  final Function(mpjs.JSObject)? onUpdated;
  final Function(mpjs.JSObject)? onRegionChange;
  final Function(mpjs.JSObject)? onPoiTap;
  final Function(mpjs.JSObject)? onPolylineTap;
  final Function(mpjs.JSObject)? onAbilitySuccess;
  final Function(mpjs.JSObject)? onAbilityFailed;
  final Function(mpjs.JSObject)? onAuthSuccess;
  final Function(mpjs.JSObject)? onInterpolatePoint;
  final Function(mpjs.JSObject)? onError;
  
  final Function(mpjs.JSObject)? onPlay;
  
  MPFlutter_Wechat_MapView({
    this.controller,
    required this.longitude,
    required this.latitude,
    this.scale = 16,
    this.minScale = 3,
    this.maxScale = 20,
    this.markers = const [],
    this.covers = const [],
    this.polyline = const [],
    this.circles = const [],
    this.controls = const [],
    this.includePoints = const [],
    this.showLocation = false,
    this.polygons = const [],
    this.subkey = '',
    this.layerStyle = 1,
    this.rotate = 0,
    this.skew = 0,
    this.enable3D = false,
    this.showCompass = false,
    this.showScale = false,
    this.enableOverlooking = false,
    this.enableAutoMaxOverlooking = false,
    this.enableZoom = true,
    this.enableScroll = true,
    this.enableRotate = false,
    this.enableSatellite = false,
    this.enableTraffic = false,
    this.enablePOI = true,
    this.enableBuilding = true,
    this.setting = const {},
    this.onTap,
    this.onMarkerTap,
    this.onLabelTap,
    this.onControlTap,
    this.onCalloutTap,
    this.onUpdated,
    this.onRegionChange,
    this.onPoiTap,
    this.onPolylineTap,
    this.onAbilitySuccess,
    this.onAbilityFailed,
    this.onAuthSuccess,
    this.onInterpolatePoint,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return MPFlutterPlatformView(
      controller: controller,
      viewClazz: "MPFlutter_Wechat_MapView",
      viewProps: {
        "longitude": longitude,
        "latitude": latitude,
        "scale": scale,
        "minScale": minScale,
        "maxScale": maxScale,
        "markers": markers,
        "covers": covers,
        "polyline": polyline,
        "circles": circles,
        "controls": controls,
        "includePoints": includePoints,
        "showLocation": showLocation,
        "polygons": polygons,
        "subkey": subkey,
        "layerStyle": layerStyle,
        "rotate": rotate,
        "skew": skew,
        "enable3D": enable3D,
        "showCompass": showCompass,
        "showScale": showScale,
        "enableOverlooking": enableOverlooking,
        "enableAutoMaxOverlooking": enableAutoMaxOverlooking,
        "enableZoom": enableZoom,
        "enableScroll": enableScroll,
        "enableRotate": enableRotate,
        "enableSatellite": enableSatellite,
        "enableTraffic": enableTraffic,
        "enablePOI": enablePOI,
        "enableBuilding": enableBuilding,
        "setting": setting,
      },
      eventCallback: (originEvent, detail) {
        final event = originEvent.toLowerCase();
        if (event == "tap") {
          onTap?.call(detail);
        } else if (event == "markertap") {
          onMarkerTap?.call(detail);
        } else if (event == "labeltap") {
          onLabelTap?.call(detail);
        } else if (event == "controltap") {
          onControlTap?.call(detail);
        } else if (event == "callouttap") {
          onCalloutTap?.call(detail);
        } else if (event == "updated") {
          onUpdated?.call(detail);
        } else if (event == "regionchange") {
          onRegionChange?.call(detail);
        } else if (event == "poitap") {
          onPoiTap?.call(detail);
        } else if (event == "polylinetap") {
          onPolylineTap?.call(detail);
        } else if (event == "abilitysuccess") {
          onAbilitySuccess?.call(detail);
        } else if (event == "abilityfailed") {
          onAbilityFailed?.call(detail);
        } else if (event == "authsuccess") {
          onAuthSuccess?.call(detail);
        } else if (event == "interpolatepoint") {
          onInterpolatePoint?.call(detail);
        } else if (event == "error") {
          onError?.call(detail);
        }
      },
    );
  }
}
