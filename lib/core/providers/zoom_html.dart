import 'package:flutter/material.dart';

class ZoomHtmlProvider extends ChangeNotifier {
  int _zoomPercentage = 100;
  ZoomHtmlProvider();
  zoomIn() {
    _zoomPercentage = _zoomPercentage + 10;
    notifyListeners();
  }

  zoomOut() {
    _zoomPercentage = _zoomPercentage - 10;
    notifyListeners();
  }

  set setZoom(int zoom) {
    _zoomPercentage = zoom;
    notifyListeners();
  }

  int get getZoom {
    return _zoomPercentage;
  }
}
