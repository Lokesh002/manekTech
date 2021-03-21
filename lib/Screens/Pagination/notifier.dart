import 'package:flutter/material.dart';
import 'package:manektech_project/backEnd/mobile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manektech_project/backEnd/networking.dart';

class MobileNotifier extends ValueNotifier<List<Mobile>> {
  MobileNotifier() : super(null);

  int _pageNumber = 1;
  bool _hasMoreMobile = true;
  int _batchesOf = 1;
  List<Mobile> _listMobiles;
  bool _loading = false;

  @override
  List<Mobile> get value => _value;
  List<Mobile> _value;
  @override
  set value(List<Mobile> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload() async {
    _listMobiles = <Mobile>[];
    _pageNumber = 1;
    await httpGetMobile(_pageNumber);
  }

  Future<void> getMore() async {
    if (_hasMoreMobile && !_loading) {
      _loading = true;
      await httpGetMobile(_pageNumber);
      _loading = false;
    }
  }

  Future<void> httpGetMobile(int page) async {
    _listMobiles ??= <Mobile>[];
    int pageNumber = page;

    Networking networking = Networking();

    int i = 0;
    while (_hasMoreMobile && (pageNumber - page) < _batchesOf) {
      var data = await networking.postData(pageNumber);
      MobileDataList mobileDataList = MobileDataList();
      var mobileData = await mobileDataList.getMobiles(data);
      data['data'] != []
          ? _listMobiles.addAll(mobileData)
          : _hasMoreMobile = false;
      pageNumber++;
      i++;
    }
    _pageNumber = pageNumber;
    value = _listMobiles;
  }
}
