import 'package:core_dashboard/models/performance_test_model.dart';
import 'package:flutter/material.dart';

class PerformanceTestController extends ChangeNotifier {
  final List<PerformanceTestModel> _performanceTestModel = [];
  List<PerformanceTestModel> get performanceTestModel => _performanceTestModel;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  bool _editMode = false;
  bool get editMode => _editMode;

  addPerformanceTest(PerformanceTestModel test) {
    _performanceTestModel.add(test);
    notifyListeners();
  }

  deletePerformanceTest(int index) {
    _performanceTestModel.removeAt(index);
    notifyListeners();
  }

  updatePerformanceTest(PerformanceTestModel test) {
    _performanceTestModel[selectedIndex] = test;
    notifyListeners();
  }

  nextSelectedIndex() {
    if (_selectedIndex < 9) _selectedIndex++;
    notifyListeners();
  }

  prevSelectedIndex() {
    if (_selectedIndex > 0) _selectedIndex--;
    notifyListeners();
  }

  setSelectedIndex(int selected) {
    _selectedIndex = selected;
    notifyListeners();
  }

  editingMode() {
    _editMode = true;
    notifyListeners();
  }

  addingMode() {
    _editMode = false;
    notifyListeners();
  }

  resetForm() {
    _performanceTestModel.clear();
    _selectedIndex = 0;
    notifyListeners();
  }
}
