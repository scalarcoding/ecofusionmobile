import 'package:core_dashboard/shared/constants/enums.dart';
import 'package:flutter/material.dart';

class PageIdController extends ChangeNotifier {
  PagesId _pagesId = PagesId.ActivityPerformanceTest;
  PagesId get pagesId => _pagesId;

  changePageId(PagesId page) {
    _pagesId = page;
    notifyListeners();
  }
}
