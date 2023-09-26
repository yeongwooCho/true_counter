import 'package:flutter/material.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/repository/festival_repository.dart';

class FestivalProvider extends ChangeNotifier {
  final FestivalRepository repository;
  Map<String, List<FestivalModel>> cache = {};

  FestivalProvider({
    required this.repository,
  }) : super() {
    getFestivals();
  }

  void getFestivals() async {
    final resp = await repository.getFestivals();

    cache.update('', (value) => resp, ifAbsent: () => resp);

    notifyListeners();
  }
}
